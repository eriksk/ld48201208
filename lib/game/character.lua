Character = {}
Character.__index = Character

function Character.new(filename, x, y, controller, attack_manager)
	local s = {}
	setmetatable(s, Character)

	s.textures = create_sprite_sheet(content_path .. "gfx/" .. filename .. ".png", 8, 8, 32)

	character_count = character_count or 0
	s.id = character_count
	character_count = character_count + 1
	s.width = 32
	s.height = 32
	s.position = Vec2.new(x or 0.0, y or 0.0)
	s.velocity = Vec2.new()
	s.scale = Vec2.new(2.0, 2.0)
	s.origin = Vec2.new(s.width / 2.0, s.height / 2.0)
	s.rotation = 0.0
	s.color = Color.white()
	s.grounded = true
	s.speed = 0.002
	s.max_speed = 0.4
	s.controller = controller
	s.attacking = false
	s.attack_manager = attack_manager
	s.health = 100

	s.animation = "jump"
	s.animations = {}
	s.animations["idle"] = Animation.new({0, 1}, 200)
	s.animations["walk"] = Animation.new({9, 10}, 100)
	s.animations["jump"] = Animation.new({18, 19}, 100)
	s.animations["slide"] = Animation.new({27, 28}, 50)
	s.animations["punch"] = Animation.new({36, 37, 38}, 50)
	s.animations["kick"] = Animation.new({0}, 500)
	s.animations["hit"] = Animation.new({0}, 500)
	s.flipped = false
	s:fall_off()

	return s
end

function Character:contains(x, y)
	if x < self.position.x - self.origin.x * math.abs(self.scale.x) then
		return false
	elseif x > self.position.x + self.origin.x * math.abs(self.scale.x) then
		return false
	elseif y < self.position.y - self.origin.y * math.abs(self.scale.y) then
		return false
	elseif y > self.position.y + self.origin.y * math.abs(self.scale.y) then
		return false
	else
		return true
	end
end

function Character:set_dir(dir)
	if dir == "left" then
		self.flipped = true
		self.scale.x = -math.abs(self.scale.x)
	elseif dir == "right" then
		self.flipped = false
		self.scale.x = math.abs(self.scale.x)
	end
end

function Character:set_anim(anim)
	if self.animation == anim then
	else
		self.animation = anim
		self.animations[self.animation]:reset()
	end
end

function Character:rotate(by)
	self.rotation = self.rotation + by
end

function Character:move(dir, dt)
	if dir == "left" then
		self.velocity.x = self.velocity.x - self.speed * dt
	elseif dir == "right" then
		self.velocity.x = self.velocity.x + self.speed * dt
	end
end

function Character:jump()
	if self.grounded then
		self.velocity.y = -0.5
		self.grounded = false
		self:set_anim("jump")
	end
end

function Character:land()
	self.velocity.y = 0.0
	self.grounded = true
	self:set_anim("idle")
end

function Character:fall_off()
	self.velocity.y = 0.0
	self.grounded = false
	self:set_anim("jump")
end

function Character:atk_punch()
	if self.attacking then
	else
		self:set_anim("punch")
		self.attacking = true
		self.velocity.x = 0.0
		if self.velocity.y > 0.0 then
			self.velocity.y = 0.0
		end

		local direction = "right"
		local damage = 10
		if self.flipped then
			direction = "left"
		end
		-- register punch
		self.attack_manager:reg_atk(
			Attack.new(
				self.id, 
				Vec2.new(self.position.x + (self.width * clamp(self.scale.x, -1.0, 1.0)), self.position.y), 
				direction,
				damage)
		)
	end
end

function Character:atk_kick()
	if self.attacking then
	else
		self:set_anim("kick")
		self.attacking = true
		self.velocity.x = 0.0
		if self.velocity.y > 0.0 then
			self.velocity.y = 0.0
		end
	end
end

function Character:atk_special()
	if self.attacking then
	else
		self.attacking = true
		self.velocity.x = 0.0
		if self.velocity.y > 0.0 then
			self.velocity.y = 0.0
		end
	end
end

function Character:update(dt)
	if self.attacking then
		if self.animations[self.animation].ticks > 0 then
			if self.grounded then
				self:fall_off()
			else
				self:set_anim("idle")
			end
			self.attacking = false
		end
	else
	end
	self.controller:update(self, dt)
	
	if self.grounded then
		-- do nothing yet
	else
		self.velocity.y = self.velocity.y + gravity * dt
		if self.position.y > ground then
			self.position.y = ground
			self:land()
		end
	end

	-- apply friction
	if self.velocity.x > 0.0 then
		self.velocity.x = self.velocity.x - friction * dt
		if self.velocity.x < 0.0 then
			self.velocity.x = 0.0
		end
	elseif self.velocity.x < 0.0 then
		self.velocity.x = self.velocity.x + friction * dt
		if self.velocity.x > 0.0 then
			self.velocity.x = 0.0
		end
	end

	self.velocity.x = clamp(self.velocity.x, -self.max_speed, self.max_speed)

	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
	self.position.x = clamp(self.position.x, 0, screen_width)

	self.animations[self.animation]:update(dt)
end

function Character:draw()
	-- hud
	set_color(Color.black())
	love.graphics.print("Frame: " .. self.animations[self.animation]:getFrame(), 16, 16)
	love.graphics.print("Animation: " .. self.animation, 16, 32)
	love.graphics.print("Grounded: " .. tostring(self.grounded), 16, 48)
	love.graphics.print("Speed: " .. tostring(math.abs(self.velocity.x)), 16, 64)

	set_color(self.color)
	love.graphics.draw(
		self.textures[self.animations[self.animation]:getFrame() + 1],
		self.position.x,
		self.position.y,
		self.rotation,
		self.scale.x,
		self.scale.y,
		self.origin.x,
		self.origin.y
	)
	
	local left = self.position.x - self.origin.x * math.abs(self.scale.x)
	local right = self.position.x + self.origin.x * math.abs(self.scale.x) 
	local top = self.position.y - self.origin.y * math.abs(self.scale.y)
	local bottom = self.position.y + self.origin.y * math.abs(self.scale.y)

	love.graphics.rectangle("line", left, top, right - left, bottom - top)

	set_color(Color.new(0, 0, 0, 80))
	love.graphics.draw(
		self.textures[self.animations[self.animation]:getFrame() + 1],
		self.position.x - self.width,
		ground + (ground - self.position.y) + self.height * self.scale.y,
		self.rotation,
		self.scale.x,
		-self.scale.y,
		self.origin.x,
		self.origin.y,
		0.5 * self.scale.x
	)
end
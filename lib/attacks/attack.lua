Attack = {}
Attack.__index = Attack

function Attack.new(owner, position, direction, damage, persistent, texture, sound, velocity, force, gravity)
	local a = {}
	setmetatable(a, Attack)

	a.owner = owner
	a.gravity = gravity or false
	a.force = force or 0.01
	a.position = position
	a.direction = direction
	a.damage = damage
	a.sound = sound or "swoosh_" .. (1 + math.floor((math.random() * 2)))
	a.persistent = persistent or false
	a.texture = texture
	if a.texture then
		a.velocity = velocity or Vec2.new()
		a.rotation = a.velocity:angle()
		a.scale = Vec2.new(1.0, 1.0)
		a.origin = Vec2.new(a.texture:getWidth() / 2.0, a.texture:getHeight() / 2.0)
	end
	a.is_hit = false

	return a
end

function Attack:hit()
	self.is_hit = true
end

function Attack:update(dt)
	if self.texture then
		if self.gravity then
			self.velocity.y = self.velocity.y + gravity * dt
		end
		self.position.x = self.position.x + self.velocity.x * dt
		self.position.y = self.position.y + self.velocity.y * dt
	end
end

function Attack:draw()
	if self.texture then
		love.graphics.draw(
			self.texture,
			self.position.x,
			self.position.y,
			self.rotation,
			self.scale.x,
			self.scale.y,
			self.origin.x,
			self.origin.y
		)
	end
end
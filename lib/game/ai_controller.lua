AIController = {}
AIController.__index = AIController

function AIController:new()
	local p = {}
	setmetatable(p, AIController)

	p.job = 0
	p.current = 0.0
	p.duration = 0.0
	p.dir = "left"

	return p
end

function AIController:input(c, dt, other_player)	
	if c.attacking then
	else
		if c.grounded then
			if self.job == 0 then -- chase
				if other_player.position.x < c.position.x then
					self.dir = "left"
				else
					self.dir = "right"
				end
				c:move(self.dir, dt)
				c:set_anim("walk")
				c:set_dir(self.dir)
				if self:in_front_of(c, other_player) then
					self.job = 1
				end
			elseif self.job == 1 then -- punch
				c:atk_punch()
				self.job = 0
			elseif self.job == 3 then -- kick
				c:atk_kick()
				self.job = 0
			else
				c:set_anim("idle")
			end

			--elseif love.keyboard.isDown(self.controls["right"]) then
			--	c:move("right", dt)
			--	c:set_anim("walk")
			--	c:set_dir("right")
			--else
			--	if c.velocity.x > 0.0 or c.velocity.x < 0.0 then
			--		c:set_anim("slide")
			--	else
			--		c:set_anim("idle")
			--	end
			--end
--
			--if love.keyboard.isDown(self.controls["jump"]) then
			--	c:jump()
			--end
		else
			--if love.keyboard.isDown(self.controls["left"]) then
			--	c:move("left", dt)
			--	c:set_dir("left")
			--elseif love.keyboard.isDown(self.controls["right"]) then
			--	c:move("right", dt)
			--	c:set_dir("right")
			--else
			--end
		end
		--if love.keyboard.isDown(self.controls["punch"]) then
		--	c:atk_punch()
		--elseif love.keyboard.isDown(self.controls["kick"]) then
		--	c:atk_kick()
		--elseif love.keyboard.isDown(self.controls["special"]) then
		--	c:atk_special()
		--end
	end
end

function AIController:in_front_of(c, other)
	return distance(c.position.x, c.position.y, other.position.x, other.position.y) < 64
end

function AIController:update(character, dt, other_player)
	self:input(character, dt, other_player)
end
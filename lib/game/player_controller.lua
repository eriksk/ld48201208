PlayerController = {}
PlayerController.__index = PlayerController

function PlayerController.new(controls)
	local p = {}
	setmetatable(p, PlayerController)

	p.controls = controls

	return p
end

function PlayerController:input(c, dt, other_player)	
	if c.attacking then
	else
		if c.grounded then
			if love.keyboard.isDown(self.controls["left"]) then
				c:move("left", dt)
				c:set_anim("walk")
				c:set_dir("left")
			elseif love.keyboard.isDown(self.controls["right"]) then
				c:move("right", dt)
				c:set_anim("walk")
				c:set_dir("right")
			else
				if c.velocity.x > 0.0 or c.velocity.x < 0.0 then
					c:set_anim("slide")
				else
					c:set_anim("idle")
				end
			end

			if love.keyboard.isDown(self.controls["jump"]) then
				c:jump()
			end
		else
			if love.keyboard.isDown(self.controls["left"]) then
				c:move("left", dt)
				c:set_dir("left")
			elseif love.keyboard.isDown(self.controls["right"]) then
				c:move("right", dt)
				c:set_dir("right")
			else
			end
		end
		if love.keyboard.isDown(self.controls["punch"]) then
			c:atk_punch()
		elseif love.keyboard.isDown(self.controls["kick"]) then
			c:atk_kick()
		elseif love.keyboard.isDown(self.controls["special"]) then
			c:atk_special()
		end
	end
end

function PlayerController:update(character, dt, other_player)
	self:input(character, dt, other_player)
end
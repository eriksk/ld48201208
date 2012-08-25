PlayerController = {}
PlayerController.__index = PlayerController

function PlayerController:new()
	local p = {}
	setmetatable(p, PlayerController)

	return p
end

function PlayerController:input(c, dt)	
	if c.grounded then
		if love.keyboard.isDown("left") then
			c:move("left", dt)
			c:set_anim("walk")
			c:set_dir("left")
		elseif love.keyboard.isDown("right") then
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

		if love.keyboard.isDown("up") then
			c:jump()
		end
	else
		if love.keyboard.isDown("left") then
			c:move("left", dt)
			c:set_dir("left")
		elseif love.keyboard.isDown("right") then
			c:move("right", dt)
			c:set_dir("right")
		else
		end
	end
end

function PlayerController:update(character, dt)
	self:input(character, dt)
end
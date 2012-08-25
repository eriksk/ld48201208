Player2Controller = {}
Player2Controller.__index = Player2Controller

function Player2Controller:new()
	local p = {}
	setmetatable(p, Player2Controller)

	return p
end

function Player2Controller:input(c, dt)	
	if c.attacking then
	else
		if c.grounded then
			if love.keyboard.isDown("a") then
				c:move("left", dt)
				c:set_anim("walk")
				c:set_dir("left")
			elseif love.keyboard.isDown("d") then
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

			if love.keyboard.isDown("w") then
				c:jump()
			end
		else
			if love.keyboard.isDown("a") then
				c:move("left", dt)
				c:set_dir("left")
			elseif love.keyboard.isDown("d") then
				c:move("right", dt)
				c:set_dir("right")
			else
			end
		end
		if love.keyboard.isDown("g") then
			c:atk_punch()
		elseif love.keyboard.isDown("h") then
			c:atk_kick()
		end
	end
end

function Player2Controller:update(character, dt)
	self:input(character, dt)
end
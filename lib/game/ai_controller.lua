AIController = {}
AIController.__index = AIController

function AIController:new()
	local p = {}
	setmetatable(p, AIController)

	return p
end

function AIController:input(c, dt)	
	if c.grounded then
	--	if love.keyboard.isDown("a") then
	--		c:move("left", dt)
	--		c:set_anim("walk")
	--		c:set_dir("left")
	--	elseif love.keyboard.isDown("d") then
	--		c:move("right", dt)
	--		c:set_anim("walk")
	--		c:set_dir("right")
	--	else
	--		if c.velocity.x > 0.0 or c.velocity.x < 0.0 then
	--			c:set_anim("slide")
	--		else
	--			c:set_anim("idle")
	--		end
	--	end
--
	--	if love.keyboard.isDown("w") then
	--		c:jump()
	--	end
	else
	--	if love.keyboard.isDown("a") then
	--		c:move("left", dt)
	--		c:set_dir("left")
	--	elseif love.keyboard.isDown("d") then
	--		c:move("right", dt)
	--		c:set_dir("right")
	--	else
	--	end
	end
end

function AIController:update(character, dt)
	self:input(character, dt)
end
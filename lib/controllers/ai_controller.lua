AIController = {}
AIController.__index = AIController

function AIController:new()
	local p = {}
	setmetatable(p, AIController)

	p.job = 0
	p.current = 0.0
	p.duration = 0
	p.target = Vec2.new()
	p.dir = "left"

	return p
end

function AIController:set_job(job, other_player)
	self.job = job
	self.current = 0.0
	self.duration = 200 + math.random() * 500
	self.target.x = other_player.position.x
	self.target.y = other_player.position.y
end

function AIController:input(c, dt, other_player)	
	if c.attacking then
	else
		if c.grounded then
			if c.animation == "hit" then
			else
				if self.job == 0 then -- chase
					if self.target.x < c.position.x then
						self.dir = "left"
					else
						self.dir = "right"
					end
					c:move(self.dir, dt)
					c:set_anim("walk")
					c:set_dir(self.dir)
					if self:in_front_of(c, other_player) then
						if other_player.position.y < c.position.y and math.random() > 0.9 then
							self:set_job(3, other_player)
						else
							self:set_job(self:get_job(), other_player)
						end
					end
					self.current = self.current + dt
					if self.current > self.duration then
						if math.random() > 0.7 then
							self:set_job(3, other_player)
						else
							self:set_job(0, other_player)
						end
					end
				elseif self.job == 1 then -- punch
					c:atk_punch()
					self:set_job(0, other_player)
				elseif self.job == 2 then -- kick
					c:atk_kick()
					self:set_job(0, other_player)
				elseif self.job == 3 then -- jump
					c:jump()
					self:set_job(0, other_player)
				elseif self.job == 4 then -- special
					c:atk_special()
					self:set_job(0, other_player)
				else
					self:set_job(0, other_player)
					c:set_anim("idle")
				end
			end
		else
		end
	end
end

function AIController:get_job()
	local job = 0
	local rand = math.random()
	if rand > 0.9 then
		job = 4
	elseif rand > 0.8 then
		job = 2 --kick
	elseif rand > 0.7 then
		job = 3 -- jump
	elseif rand > 0.4 then
		job = 1 --punch
	else
		-- walk
	end
	return job
end

function AIController:in_front_of(c, other)
	return distance(c.position.x, c.position.y, other.position.x, other.position.y) < 40
end

function AIController:update(character, dt, other_player)
	self:input(character, dt, other_player)
end
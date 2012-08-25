AttackManager = {}
AttackManager.__index = AttackManager

function AttackManager:new()
	local a = {}
	setmetatable(a, AttackManager)	

	a.attacks = {}

	return a
end

function AttackManager:reg_atk(attack)
	self.attacks[#self.attacks + 1] = attack
end

function AttackManager:update(characters, dt)	
	for i=1,#self.attacks do
		local attack = self.attacks[i]
		for j=1,characters:size() do
			local character = characters:get(j)
			if character.id == attack.owner then
				-- do nothing
			else
				if character:contains(attack.position.x, attack.position.y) then
					character:hit(attack.direction, attack.damage)
				end
			end	 	
		end 
	end
	-- clear attacks
	for i=1,#self.attacks do
		self.attacks[i] = nil
	end
end

function AttackManager:draw()
	-- TODO: remove
	set_color(Color.red())
	for i=1,#self.attacks do
		local attack = self.attacks[i] 
		love.graphics.print("x", attack.position.x, attack.position.y)
	end
end
AttackManager = {}
AttackManager.__index = AttackManager

function AttackManager.new(particle_manager)
	local a = {}
	setmetatable(a, AttackManager)	

	a.attacks = {}
	a.particle_manager = particle_manager

	return a
end

function AttackManager:reg_atk(attack)
	self.attacks[#self.attacks + 1] = attack
	audio_manager:play_sound("swoosh_" .. (1 + math.floor((math.random() * 2))))
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
					self.particle_manager:add(character.position.x, character.position.y, 5)
					character:hit(attack.direction, attack.damage)
					audio_manager:play_sound("hit_" .. (1 + math.floor((math.random() * 3))))
					audio_manager:play_sound("ouch_" .. (1 + math.floor((math.random() * 3))))
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
end
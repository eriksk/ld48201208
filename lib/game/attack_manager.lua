AttackManager = {}
AttackManager.__index = AttackManager

function AttackManager.new(particle_manager)
	local a = {}
	setmetatable(a, AttackManager)	

	a.attacks = {}
	a.particle_manager = particle_manager
	a.textures = create_sprite_sheet("content/gfx/attacks.png", 4, 4, 32)

	return a
end

function AttackManager:reg_atk(attack)
	self.attacks[#self.attacks + 1] = attack
	audio_manager:play_sound(attack.sound)
end

function AttackManager:update(characters, dt)	
	for i=1,#self.attacks do
		local attack = self.attacks[i]
		if attack then
			if attack.persistent then
				attack:update(dt)
			end
			for j=1,characters:size() do
				local character = characters:get(j)
				if character.id == attack.owner then
					-- do nothing
				else
					if character:contains(attack.position.x, attack.position.y) then
						attack:hit()
						self.particle_manager:add_stars(character.position.x, character.position.y, 5)
						character:hit(attack.direction, attack.damage)
						audio_manager:play_sound("hit_" .. (1 + math.floor((math.random() * 3))))
						audio_manager:play_sound("ouch_" .. (1 + math.floor((math.random() * 3))))
						dt_slow_down = 300
					end
				end	 	
			end 
		end
	end
	-- clear attacks
	for i,attack in pairs(self.attacks) do		
		if attack then
			if attack.is_hit or attack.position.x < -100 or attack.position.x > screen_width + 100 then
				table.remove(self.attacks, i) --self.attacks[i] = nil
			end
			if attack.persistent then
			else
				table.remove(self.attacks, i)
			end
		else
			table.remove(self.attacks, i)  --self.attacks[i] = nil
		end
	end
end

function AttackManager:draw()
	for i=1,#self.attacks do
		local attack = self.attacks[i]
		if attack then
			attack:draw()
		end
	end
end
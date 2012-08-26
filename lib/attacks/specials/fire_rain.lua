FireRain = {}
FireRain.__index = FireRain

function FireRain.new()
	local h = {}
	setmetatable(h, FireRain)

	return h
end

function FireRain:use(character)
	-- register FireRain
	local direction = "right"
	local damage = 50
	if character.flipped then
		direction = "left"
	end
	local angle = 0
	for i=0,5 do
		character.attack_manager:reg_atk(
			Attack.new(
				character.id, 
				Vec2.new(math.random() * screen_width, 0), 
				direction,
				damage,
				true,
				character.attack_manager.textures[7],
				"hadouken",
				Vec2.new(),
				1.0, true)
		)
	end
end
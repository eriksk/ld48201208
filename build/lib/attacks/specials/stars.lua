Stars = {}
Stars.__index = Stars

function Stars.new()
	local h = {}
	setmetatable(h, Stars)

	return h
end

function Stars:use(character)
	-- register Stars
	local direction = "right"
	local damage = 5
	if character.flipped then
		direction = "left"
	end
	local angle = 0
	for i=0,10 do
		angle = to_radians(lerp(-90, 0, i / 10.0))
		character.attack_manager:reg_atk(
			Attack.new(
				character.id, 
				Vec2.new(character.position.x + (character.width * clamp(character.scale.x, -1.0, 1.0)), character.position.y, true), 
				direction,
				damage,
				true,
				character.attack_manager.textures[4],
				"hadouken",
				Vec2.new(character:forward() * 0.2, math.sin(angle)),
				1.0, true)
		)
	end
end
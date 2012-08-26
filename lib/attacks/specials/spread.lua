Spread = {}
Spread.__index = Spread

function Spread.new()
	local h = {}
	setmetatable(h, Spread)

	return h
end

function Spread:use(character)
	-- register Spread
	local direction = "right"
	local damage = 50
	if character.flipped then
		direction = "left"
	end
	character.attack_manager:reg_atk(
		Attack.new(
			character.id, 
			Vec2.new(character.position.x + (character.width * clamp(character.scale.x, -1.0, 1.0)), character.position.y, true), 
			direction,
			damage,
			true,
			character.attack_manager.textures[3],
			"hadouken",
			Vec2.new(character:forward() * 0.8, 0.0),
			1.0)
	)

	character.attack_manager:reg_atk(
		Attack.new(
			character.id, 
			Vec2.new(character.position.x + (character.width * clamp(character.scale.x, -1.0, 1.0)), character.position.y, true), 
			direction,
			damage,
			true,
			character.attack_manager.textures[3],
			"hadouken",
			Vec2.new(character:forward() * 0.8, -0.2),
			1.0)
	)

	character.attack_manager:reg_atk(
		Attack.new(
			character.id, 
			Vec2.new(character.position.x + (character.width * clamp(character.scale.x, -1.0, 1.0)), character.position.y, true), 
			direction,
			damage,
			true,
			character.attack_manager.textures[3],
			"hadouken",
			Vec2.new(character:forward() * 0.8, -0.4),
			1.0)
	)
end
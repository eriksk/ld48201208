Hadouken = {}
Hadouken.__index = Hadouken

function Hadouken.new()
	local h = {}
	setmetatable(h, Hadouken)

	return h
end

function Hadouken:use(character)
	-- register hadouken
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
			character.attack_manager.textures[1],
			"hadouken",
			Vec2.new(character:forward() * 0.8, 0.0))
	)
end
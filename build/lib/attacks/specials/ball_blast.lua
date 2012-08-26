BallBlast = {}
BallBlast.__index = BallBlast

function BallBlast.new()
	local h = {}
	setmetatable(h, BallBlast)

	return h
end

function BallBlast:use(character)
	-- register BallBlast
	local direction = "right"
	local damage = 10
	if character.flipped then
		direction = "left"
	end
	local angle = 0
	for i=0,12 do
		angle = to_radians(lerp(0, 360, i / 12.0))
		character.attack_manager:reg_atk(
			Attack.new(
				character.id, 
				Vec2.new(character.position.x + (character.width * clamp(character.scale.x, -1.0, 1.0)), character.position.y, true), 
				direction,
				damage,
				true,
				character.attack_manager.textures[6],
				"hadouken",
				Vec2.new(math.cos(angle), math.sin(angle)),
				1.0, true)
		)
	end
end
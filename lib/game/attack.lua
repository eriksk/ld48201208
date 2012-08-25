Attack = {}
Attack.__index = Attack

function Attack.new(owner, position, direction, damage)
	local a = {}
	setmetatable(a, Attack)

	a.owner = owner
	a.position = position
	a.direction = direction
	a.damage = damage

	return a
end


function Attack:apply(character)
	-- TODO: hit character
end
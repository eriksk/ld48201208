function lerp(min, max, weight)
	return min + (max - min) * weight
end

function distance(x1, y1, x2, y2)
	return math.sqrt(((x1 - x2) * (x1 - x2)) - ((y1 - y2) * (y1 - y2)))
end

function clamp(value, min, max)
	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value
end

function create_sprite_sheet(texture, cols, rows, cell_size)
	print("TODO")
end
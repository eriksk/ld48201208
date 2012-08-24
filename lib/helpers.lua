function lerp(min, max, weight)
	return min + (max - min) * weight
end

-- cubic interpolation using a hermite spline
function qlerp(min, max, weight)
	return hermite(min, 0.0, max, 0.0, weight)
end

-- value1, tangent1, value2, tangent2
function hermite(v1, t1, v2, t2, weight)
	local sCubed = weight * weight * weight
	local sSquared = weight * weight
	local result = 0.0
	
	if weight == 0.0 then
		result = v1
	elseif weight == 1.0 then
		result = v2
	else
		result = (2 * v1 - 2 * v2 + t2 + t1) * sCubed + (3 * v2 - 3 * v1 - 2 * t1 - t2) * sSquared + t1 * weight + v1
	end

    return result
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

function set_color(color)
	love.graphics.setColor(color.r, color.g, color.b, color.a)
end
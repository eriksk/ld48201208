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

function create_sprite_sheet(filename, cols, rows, cell_size)
	local images = {}
	local img = love.image.newImageData(filename)
	local i = 1
    for row=0,rows do
        for col=0,cols do
            local sprite = love.image.newImageData(32, 32)
            sprite:paste(img, 0, 0, col * cell_size, row * cell_size, cell_size, cell_size)
            images[i] = love.graphics.newImage(sprite)
            images[i]:setFilter(texture_filter, texture_filter)
            i = i + 1
        end
    end
    return images
end

function set_color(color)
	love.graphics.setColor(color.r, color.g, color.b, color.a)
end

function to_radians(degrees)
	return degrees * math.pi / 180.0
end
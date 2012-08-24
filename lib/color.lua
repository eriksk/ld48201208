Color = {}
Color.__index = Color

function Color.new(r, g, b, a)
	local c = {}
	setmetatable(c, Color)

	c.r = r or 255
	c.g = g or 255
	c.b = b or 255
	c.a = a or 255

	return c
end

function Color.lerp(color1, color2, weight)
	return Color.new(
		lerp(color1.r, color2.r, weight),
		lerp(color1.g, color2.g, weight),
		lerp(color1.b, color2.b, weight),
		lerp(color1.a, color2.a, weight)
	)
end

function Color.red()
	return Color.new(255, 0, 0)
end

function Color.green()
	return Color.new(0, 255, 0)
end

function Color.blue()
	return Color.new(0, 0, 255)
end

function Color.black()
	return Color.new(0, 0, 0)
end
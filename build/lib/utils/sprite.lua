Sprite = {}
Sprite.__index = Sprite

function Sprite.new(filename, x, y)
	local s = {}
	setmetatable(s, Sprite)

	s.texture = love.graphics.newImage("content/gfx/" .. filename .. ".png")
	s.texture:setFilter(texture_filter, texture_filter)
	s.width = s.texture:getWidth()
	s.height = s.texture:getHeight()
	s.position = Vec2.new(x or 0.0, y or 0.0)
	s.velocity = Vec2.new()
	s.origin = Vec2.new(s.width / 2.0, s.height / 2.0)
	s.scale = 1.0
	s.rotation = 0.0
	s.color = Color.white()

	return s
end

function Sprite:set_color(color)
	self.color.r = color.r
	self.color.g = color.g
	self.color.b = color.b
	self.color.a = color.a
end

function Sprite:rotate(by)
	self.rotation = self.rotation + by
end

function Sprite:update(dt)
	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
end

function Sprite:draw()
	set_color(self.color)
	love.graphics.draw(
		self.texture,
		self.position.x,
		self.position.y,
		self.rotation,
		self.scale,
		self.scale,
		self.origin.x,
		self.origin.y
	)
end
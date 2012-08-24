Sprite = {}
Sprite.__index = Sprite

function Sprite.create(filename, x, y)
	local s = {}
	setmetatable(s, Sprite)

	s.texture = love.graphics.newImage("content/gfx/" .. filename .. ".png")
	s.width = s.texture:getWidth()
	s.height = s.texture:getHeight()
	s.position = Vec2.create(x or 0.0, y or 0.0)
	s.velocity = Vec2.create()
	s.origin = Vec2.create(s.width / 2.0, s.height / 2.0)
	s.scale = 1.0
	s.rotation = 0.0

	return s
end

function Sprite:update(dt)
	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
end

function Sprite:draw()
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
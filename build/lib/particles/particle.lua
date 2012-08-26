Particle = {}
Particle.__index = Particle

function Particle.new(texture, x, y, duration)
	local s = {}
	setmetatable(s, Particle)

	s.texture = texture
	s.width = s.texture:getWidth()
	s.height = s.texture:getHeight()
	s.position = Vec2.new(x or 0.0, y or 0.0)
	s.velocity = Vec2.new()
	s.origin = Vec2.new(s.width / 2.0, s.height / 2.0)
	s.scale = 1.0
	s.rotation = 0.0
	s.current = 0.0
	s.duration = duration
	s.rot_speed = 0.0

	return s
end

function Particle:rotate(by)
	self.rotation = self.rotation + by
end

function Particle:update(dt)
	self.position.x = self.position.x + self.velocity.x * dt
	self.position.y = self.position.y + self.velocity.y * dt
	self.rotation = self.rotation + self.rot_speed * dt
	self.current = self.current + dt
end

function Particle:draw()
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
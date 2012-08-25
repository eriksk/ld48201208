ParticleManager = {}
ParticleManager.__index = ParticleManager

function ParticleManager:new()
	local p = {}
	setmetatable(p, ParticleManager)

	p.particles = {}
	p.texture = love.graphics.newImage("content/gfx/particles.png")

	return p
end

function ParticleManager:add(x, y, count)
	for i=0,count do
		local p = Particle.new(self.texture, x + (-16.0 + math.random() * 32), y + (-16.0 + math.random() * 32), 50 + math.random() * 100)
		local angle = math.random() * 10.0
		local speed = 0.05 + math.random() * 0.1
		p.velocity.x = math.cos(angle) * speed
		p.velocity.y = math.sin(angle) * speed
		p.scale = 0.5 + math.random() * 0.8
		p.rot_speed = -0.05 + math.random() * 0.1
		self.particles[#self.particles + 1] = p
	end
end

function ParticleManager:update(dt)
	for i=1,#self.particles do
		local p = self.particles[i]
		p:update(dt)
	end
	for i=1,#self.particles do
		local p = self.particles[i]
		if p then
			if p.current > p.duration then
				table.remove(self.particles, i)
				i = i - 1
			end
		end
	end
end

function ParticleManager:draw()
	set_color(Color.white())
	for i=1,#self.particles do
		local p = self.particles[i]
		p:draw()
	end
end
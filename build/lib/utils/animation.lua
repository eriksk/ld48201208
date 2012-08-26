Animation = {}
Animation.__index = Animation

function Animation.new(frames, interval)
	local animation = {}
	setmetatable(animation, Animation)
	
	animation.current_frame = 1
	animation.current = 0.0
	animation.frames = frames
	animation.interval = interval
	animation.ticks = 0

	return animation
end

function Animation:reset()
	self.current = 0.0
	self.current_frame = 1
	self.ticks = 0
end

function Animation:getFrame()
	return self.frames[self.current_frame]
end

function Animation:update(dt)
	self.current = self.current + dt
	if self.current > self.interval then
		self.current = 0
		self.current_frame = self.current_frame + 1
		if self.current_frame > #self.frames then
			self.current_frame = 1
			self.ticks = self.ticks + 1
		end
	end
end
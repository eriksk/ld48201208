TextField = {}
TextField.__index = TextField

function TextField.new(text, x, y, font, color)
	local tf = {}
	setmetatable(tf, TextField)

	tf.font = font
	tf.color = color or Color.new()
	tf.position = Vec2.new(x or 0.0, y or 0.0)
	tf.rotation = 0.0
	tf.scale = Vec2.new(1.0, 1.0)
	tf.origin = Vec2.new(0.0, 0.0)
	tf.text = ""
	tf.align_mode = "center"
	tf:set_text(text)

	return tf
end

function TextField:set_scale(scale)
	self.scale.x = scale
	self.scale.y = scale
end

function TextField:set_color(color)
	self.color.r = color.r
	self.color.g = color.g
	self.color.b = color.b
	self.color.a = color.a
end

function TextField:set_align_mode(mode)
	self.align_mode = mode
	self:set_text(self.text)
end

function TextField:set_text(text)
	self.text = text
	if self.align_mode == "right" then
		self.origin.x = 0
		self.origin.y = self.font:getHeight(text) / 2.0
	end
	if self.align_mode == "left" then
		self.origin.x = self.font:getWidth(text)
		self.origin.y = self.font:getHeight(text) / 2.0
	end
	if self.align_mode == "center" then
		self.origin.x = self.font:getWidth(text) / 2.0
		self.origin.y = self.font:getHeight(text) / 2.0
	end
end

function TextField:draw()
	love.graphics.setFont(self.font)
	set_color(self.color)
	love.graphics.print(
		self.text,
		self.position.x, 
		self.position.y, 
		self.rotation, 
		self.scale.x, 
		self.scale.y, 
		self.origin.x,
		self.origin.y)
end
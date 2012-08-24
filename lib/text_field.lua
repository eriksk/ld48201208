TextField = {}
TextField.__index = TextField

function TextField.new(text, x, y, font)
	local tf = {}
	setmetatable(tf, TextField)

	tf.font = font
	tf.x = x
	tf.y = y
	tf.rotation = 0.0
	tf.scale = Vec2.new(1.0, 1.0)
	tf.origin = Vec2.new(0.0, 0.0)
	tf.text = ""
	tf.align_mode = "center"
	tf:setText(text)

	return tf
end

function TextField:set_align_mode(mode)
	self.align_mode = mode
	self:setText(self.text)
end

function TextField:setText(text)
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
	love.graphics.print(
		self.text,
		self.x, 
		self.y, 
		self.rotation, 
		self.scale.x, 
		self.scale.y, 
		self.origin.x,
		self.origin.y)
end
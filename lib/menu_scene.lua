MenuScene = {}
MenuScene.__index = MenuScene

function MenuScene.new(scene_manager)
	local s = {}
	setmetatable(s, MenuScene)

	s.name = "menu"
	s.transition_duration = 1000
	s.scene_manager = scene_manager
	s.title = TextField.new(
		"Ludum Dare 2012-08-25", 
		400, 
		300, 
		love.graphics.newFont("content/fonts/font.ttf", 36),
		Color.green())
	s.current = 0.0
	s.duration = 2000
	return s
end

function MenuScene:load()
end

function MenuScene:on_activated()
	self:load()
end

function MenuScene:update(dt)
	if love.keyboard.isDown("left") then
		self.title:set_align_mode("left")
	end
	if love.keyboard.isDown("right") then
		self.title:set_align_mode("right")
	end
	if love.keyboard.isDown("up") then
		self.title:set_align_mode("center")
	end
	if self.current < self.duration then
		self.current = self.current + dt
		self.title:set_color(Color.lerp(Color.black(), Color.red(), clamp(self.current / self.duration, 0.0, 1.0)))
		if self.title.position.y > 100 then
			self.title.position.y = qlerp(400, 100, clamp(self.current / self.duration, 0.0, 1.0))
		end
	end
end

function MenuScene:draw(dt)
	self.title:draw()
end
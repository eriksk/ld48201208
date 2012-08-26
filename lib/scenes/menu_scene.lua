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

	s.start_text = TextField.new(
		"press space", 
		400, 
		300, 
		love.graphics.newFont("content/fonts/font.ttf", 34),
		Color.red())

	s.current = 0.0
	s.duration = 2000
	s.state = "intro"
	return s
end

function MenuScene:load()
end

function MenuScene:on_activated()
	self:load()
	self.current = 0.0
	self.state = "intro"
	self.title.position.y = 400
	self.scene_manager.audio_manager:play_sound("startup")
end

function MenuScene:title_done()
	self.scene_manager.audio_manager:play_song("menu")
	self.state = "waiting"
end

function MenuScene:update(dt)
	if self.state == "intro" then
		if self.current < self.duration then
			self.current = self.current + dt
			self.title:set_color(Color.lerp(Color.black(), Color.green(), clamp(self.current / self.duration, 0.0, 1.0)))
			self.title.position.y = qlerp(400, 100, clamp(self.current / self.duration, 0.0, 1.0))
		else
			self:title_done()
		end
	elseif self.state == "waiting" then
	else
	end
	
	-- check for input to continue and change screen
	if love.keyboard.isDown(" ") then
		self.scene_manager:set_scene("game")
	end
end

function MenuScene:draw()
	set_color(Color.black())
	love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
	self.title:draw()
	if self.state == "waiting" then
		self.title.position.y = 100 + math.sin(total_time * 0.001) * 10.0
		self.start_text.position.y = 400 + math.sin(total_time * 0.01) * 10.0
		self.start_text.scale.x = 1.0 + math.sin(total_time * 0.01) * 0.1
		self.start_text:draw()
	end
end
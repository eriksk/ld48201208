MenuScene = {}
MenuScene.__index = MenuScene

function MenuScene.new(scene_manager)
	local s = {}
	setmetatable(s, MenuScene)

	s.name = "menu"
	s.transition_duration = 1000
	s.scene_manager = scene_manager
	s.title = Sprite.new("logo", screen_width / 2.0, 100)

	s.start_text = TextField.new(
		"press space", 
		400, 
		300, 
		love.graphics.newFont("content/fonts/font.ttf", 34),
		Color.red())

	s.current = 0.0
	s.duration = 2000
	s.state = "intro"
	s.intro_text = "Every time you die a mutation makes you evolve into a new stronger fighter. The first fighter to kill the other five times is the winner."

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
			self.title:set_color(Color.lerp(Color.black(), Color.white(), clamp(self.current / self.duration, 0.0, 1.0)))
			self.title.scale = 2.0
			self.title.position.y = qlerp(400, 100, clamp(self.current / self.duration, 0.0, 1.0))
		else
			self:title_done()
		end
	elseif self.state == "waiting" then
		-- allow the game to quit
		if love.keyboard.isDown("escape") then
			love.event.push("quit")
		end
	else
	end
	
	-- check for input to continue and change screen
	if love.keyboard.isDown(" ") then
		self.scene_manager:set_scene("select_players")
	end
end

function MenuScene:draw()
	set_color(Color.black())
	love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
	self.title:draw()
	if self.state == "waiting" then
		self.title.position.y = 100 + math.sin(total_time * 0.001) * 10.0
		self.start_text.position.y = 550 + math.sin(total_time * 0.01) * 10.0
		self.start_text.scale.x = 1.0 + math.sin(total_time * 0.01) * 0.1
		self.start_text:draw()

		set_color(Color.white())
		love.graphics.printf(self.intro_text, (screen_width / 2.0) - 150, screen_height / 2.0, 300, "center")
	end
end
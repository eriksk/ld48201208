SelectPlayersScene = {}
SelectPlayersScene.__index = SelectPlayersScene

function SelectPlayersScene.new(scene_manager)
	local s = {}
	setmetatable(s, SelectPlayersScene)

	s.name = "select_players"
	s.transition_duration = 1000
	s.scene_manager = scene_manager
	local font_path = "content/fonts/font.ttf"
	local title_font = love.graphics.newFont(font_path, 36)
	s.title = TextField.new("select players", screen_width / 2.0, 64, title_font, Color.green()) --text, x, y, font, color
	s.title:set_align_mode("center")
	s.p1_is_human = true
	s.p2_is_human = true
	s.current = 0.0

	return s
end

function SelectPlayersScene:load()
end

function SelectPlayersScene:on_activated()
	self.current = 0.0
	audio_manager:play_song("song2")
end

function SelectPlayersScene:continue()
	local settings = {}
	settings["p1"] = self.p1_is_human
	settings["p2"] = self.p2_is_human
	self.scene_manager:set_scene("game", settings)
end

function SelectPlayersScene:update(dt)

	self.current = self.current + dt
	if self.current > 800 then
		if love.keyboard.isDown("w") then
			self.p1_is_human = true
		elseif love.keyboard.isDown("s") then
			self.p1_is_human = false
		end

		if love.keyboard.isDown("up") then
			self.p2_is_human = true
		elseif love.keyboard.isDown("down") then
			self.p2_is_human = false
		end

		if love.keyboard.isDown(" ") then
			self:continue()
		end
		if love.keyboard.isDown("escape") then
			self.scene_manager:set_scene("menu")
		end
	end
end

function SelectPlayersScene:draw(dt)
	set_color(Color.black())
	love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
	self.title:draw()

	local y = 200
	love.graphics.print("Player 1", 100, y)
	love.graphics.print("Player 2", screen_width - 300, y)

	love.graphics.print("human", 124, y + 32)
	love.graphics.print("com", 124, y + 64)
	local cursor_1 = y + 32
	if self.p1_is_human then
	else
		cursor_1 = cursor_1 + 32
	end
	set_color(Color.yellow())
	love.graphics.print(">", 100, cursor_1)

	set_color(Color.green())
	love.graphics.print("human", screen_width - 276, y + 32)
	love.graphics.print("com", screen_width - 276, y + 64)
	local cursor_2 = y + 32
	if self.p2_is_human then
	else
		cursor_2 = cursor_2 + 32
	end
	set_color(Color.yellow())
	love.graphics.print(">", screen_width - 300, cursor_2)

	set_color(Color.red())
	love.graphics.print("press space to start", 240, screen_height - 100)

	set_color(Color.blue())
	love.graphics.print("Move: w a s d", 100, 300)
	love.graphics.print("Attack: g h j", 100, 332)

	love.graphics.print("Move: arrow keys", screen_width - 300, 300)
	love.graphics.print("Attack: . - rshift", screen_width - 300, 332)
end
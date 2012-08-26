Hud = {}
Hud.__index = Hud

function Hud.new(game_scene)
	local h = {}
	setmetatable(h, Hud)

	h.game = game_scene
	local font = love.graphics.newFont("content/fonts/font.ttf", 36)
	local small_font = love.graphics.newFont("content/fonts/font.ttf", 26)
	h.health_p1_text = TextField.new("", 0, 0, small_font, Color.white())
	h.health_p2_text = TextField.new("", 0, 0, small_font, Color.white())
	local big_font = love.graphics.newFont("content/fonts/font.ttf", 128)
	h.k_o_text = TextField.new("K.O", screen_width / 2.0, screen_height / 2.0, big_font, Color.red())
	h.k_o_text:set_align_mode("center")
	h.paused_text = TextField.new("paused", screen_width / 2.0, 100, big_font, Color.white())
	h.resume_text = TextField.new("space: resume", screen_width / 2.0, screen_height / 2.0, font, Color.green())
	h.exit_text = TextField.new("escape: exit", screen_width / 2.0, (screen_height / 2.0) + 32, font, Color.red())
	h.game_over_text = TextField.new("game over", screen_width / 2.0, 100, big_font, Color.white())
	h.press_space_text = TextField.new("press space", screen_width / 2.0, screen_height / 2.0, font, Color.red())

	return h
end

function Hud:update(dt)
end

function Hud:draw()
	set_color(Color.black())
	local p1 = self.game.players:first()
	local p2 = self.game.players:last()

	self:draw_hud_for_player("left", p1, self.health_p1_text)
	self:draw_hud_for_player("right", p2, self.health_p2_text)

	if self.game.state == "game_over" then
		self:draw_game_over_screen(p1, p2)
	elseif self.game.state == "round_over" then
		self:draw_round_over_screen(p1, p2)
	end
	if self.game.paused then
		set_color(Color.new(0,0,0, 200))
		love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
		self.paused_text:draw()
		self.resume_text:draw()
		self.exit_text:draw()
	end
end

function Hud:draw_game_over_screen(p1, p2)
	set_color(Color.new(0,0,0, 200))
	love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
	self.game_over_text:draw()
	self.press_space_text:draw()

	set_color(Color.green())
	local x = 300
	local y = 200
	if p1.score > p2.score then
		love.graphics.print("Player 1 Wins!", x, y)
	else
		love.graphics.print("Player 1 Wins!", x, y)		
	end
end

function Hud:draw_round_over_screen(p1, p2)
	if p1.health <= 0.0 then
		
	elseif p2.health <= 0.0 then

	end
	self.k_o_text.position.y = (screen_height / 2.0) + (math.sin(total_time * 0.005) * 5.0)
	self.k_o_text:set_color(Color.white())
	self.k_o_text:set_scale(1.05)
	self.k_o_text:draw()
	self.k_o_text.position.y = (screen_height / 2.0) + (math.sin(total_time * 0.005) * 10.0)
	self.k_o_text:set_scale(1)
	self.k_o_text:set_color(Color.red())
	self.k_o_text:draw()
end

function Hud:draw_hud_for_player(alignment, player, text_field)

	local x = 0
	local y = 32
	local border_x = 0
	if alignment == "left" then
		x = 100
		border_x = x - 64
	elseif alignment == "right" then
		x = screen_width - 300
		border_x = x - 32
	end

	-- border
	set_color(Color.new(0,0,0, 100))
	love.graphics.rectangle("fill", border_x, y - 16, 300, 100)
	set_color(Color.white())
	love.graphics.rectangle("line", border_x, y - 16, 300, 100)

	text_field.position.x = x + 100
	text_field.position.y = y + 32
	text_field:set_text("Generation: " .. player.generation)
	text_field:set_align_mode(alignment)
	text_field:draw()
	text_field.position.y = text_field.position. y + 32
	text_field:set_text("Score: " .. player.score)
	text_field:draw()

	set_color(Color.black())
	love.graphics.rectangle("fill", x, y, 200, 16)
	set_color(Color.lerp(Color.red(), Color.green(), clamp(player.health / player.max_health, 0.0, 1.0)))
	love.graphics.rectangle("fill", x + 2, y + 2, lerp(0, 196, clamp(player.health / player.max_health, 0.0, 1.0)), 12)

end
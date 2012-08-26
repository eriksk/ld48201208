Hud = {}
Hud.__index = Hud

function Hud.new(game_scene)
	local h = {}
	setmetatable(h, Hud)

	h.game = game_scene
	local font = love.graphics.newFont("content/fonts/font.ttf", 24)
	h.health_p1_text = TextField.new("", 0, 0, font, Color.black())
	h.health_p2_text = TextField.new("", 0, 0, font, Color.black())
	local big_font = love.graphics.newFont("content/fonts/font.ttf", 128)
	h.k_o_text = TextField.new("K.O", screen_width / 2.0, screen_height / 2.0, big_font, Color.red())
	h.k_o_text:set_align_mode("center")

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
	end
end

function Hud:draw_game_over_screen(p1, p2)
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
	if alignment == "left" then
		x = 100
	elseif alignment == "right" then
		x = screen_width - 300
	end

	text_field.position.x = x
	text_field.position.y = y
	text_field:set_text("Health: " .. player.health)
	text_field:set_align_mode(alignment)
	-- text_field:draw()


	set_color(Color.black())
	love.graphics.rectangle("fill", x, y, 200, 16)
	set_color(Color.lerp(Color.red(), Color.green(), clamp(player.health / player.max_health, 0.0, 1.0)))
	love.graphics.rectangle("fill", x + 2, y + 2, lerp(0, 196, clamp(player.health / player.max_health, 0.0, 1.0)), 12)

end
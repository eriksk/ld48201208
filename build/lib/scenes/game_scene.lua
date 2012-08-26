GameScene = {}
GameScene.__index = GameScene

function GameScene.new(scene_manager)
	local s = {}
	setmetatable(s, GameScene)

	s.scene_manager = scene_manager
	s.name = "game"
	s.transition_duration = 1000
	s.state = "running"
	s.paused = false
	s.paused_current = 0.0

	return s
end

function GameScene:load(params)
	self.particle_manager = ParticleManager.new()
	self.attack_manager = AttackManager.new(self.particle_manager)
	self.state = "running"
	self.paused = false

	self.hud = Hud.new(self)
	self.players = List.new()

	local p1_controls = {
		left = "a",
		right = "d",
		jump = "w",
		punch = "g",
		kick = "h",
		special = "j"
	}
	local p2_controls = {
		left = "left",
		right = "right",
		jump = "up",
		punch = ".",
		kick = "-",
		special = "rshift"
	}
	local p1_controller = nil
	local p2_controller = nil

	if params then
		if params["p1"] then
			p1_controller = PlayerController.new(p1_controls)
		else
			p1_controller = AIController.new()
		end
		if params["p2"] then
			p2_controller = PlayerController.new(p2_controls)
		else
			p2_controller = AIController.new()
		end
	else
		p1_controller = PlayerController.new(p1_controls)
		p2_controller = PlayerController.new(p2_controls)
	end


	self.players:add(Character.new("player", 100, 300, p1_controller, self.attack_manager))
	local p2 = Character.new("player2", screen_width - 100, 300, p2_controller, self.attack_manager)
	p2:set_dir("left")
	self.players:add(p2)

	TiledMap_Load("content/maps/map1.tmx", 32, "content/gfx/tiles.png")

	audio_manager:play_song("song1")
end

function GameScene:on_activated(params)
	self:load(params)
end

function GameScene:game_over(winner, loser)
	self.state = "game_over"
end

function GameScene:round_over(winner, loser)
	self.state = "round_over"
	self.round_wait = 2000
	self.attack_manager:reset()
	audio_manager:play_sound("k_o")
	winner.score = winner.score + 1
	loser:evolve()
	if winner.score == AttackFactory.max() then
		self:game_over(winner, loser)
	end
end

function GameScene:next_round()
	self.players:first():reset(100)
	self.players:last():reset(screen_width - 100)
	self.state = "running"
	audio_manager:play_sound("fight")
end

function GameScene:update(dt)
	if self.state == "running" then
		if self.paused then
			if love.keyboard.isDown(" ") then
				self.paused = false
			elseif love.keyboard.isDown("escape") and self.paused_current < 0.0 then
				self.scene_manager:set_scene("select_players")
			end
		else 
			if love.keyboard.isDown("escape") then
				if self.paused_current < 0.0 then
					self.paused = true
					self.paused_current = 300.0
				end
			end
		end
		
		self.paused_current = self.paused_current - dt
		if self.paused then

		else
			self.attack_manager:update(self.players, dt)
			for i=1,self.players:size() do
				-- player vs player collision
				for j=1,self.players:size() do
					if i == j then
					else
						local p1 = self.players:get(i)
						local p2 = self.players:get(j)
						if p1:contains(p2.position.x, p2.position.y) then
							local diff = lerp(1.0, 0.0, math.abs(p1.position.x - p2.position.x) / 32.0)
							if p1.position.x < p2.position.x then
								p1.position.x = p1.position.x - (diff * 0.5) * dt
							else
								p1.position.x = p1.position.x + (diff * 0.5) * dt
							end
						end
					end
				end
			end
			self.players:first():update(dt, self.players:last())
			self.players:last():update(dt, self.players:first())

			self.particle_manager:update(dt)
			self.hud:update(dt)

			if self.players:first().health <= 0.0 then
				self:round_over(self.players:last(), self.players:first())
			elseif self.players:last().health <= 0.0 then
				self:round_over(self.players:first(), self.players:last())
			end
		end
	elseif self.state == "game_over" then
		if love.keyboard.isDown(" ") then
			self.scene_manager:set_scene("select_players")
		end
	elseif self.state == "round_over" then
		self.round_wait = self.round_wait - dt
		if self.round_wait < 0.0 then
			self:next_round()
		end
	end
end

function GameScene:draw()
    set_color(Color.white())
    TiledMap_DrawNearCam(screen_width / 2.0, screen_height / 2.0)
    for i=1,self.players:size() do
    	self.players:get(i):draw()
    end

    self.particle_manager:draw()
    self.attack_manager:draw()
    self.hud:draw()
end
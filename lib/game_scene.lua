GameScene = {}
GameScene.__index = GameScene

function GameScene.new(scene_manager)
	local s = {}
	setmetatable(s, GameScene)

	s.scene_manager = scene_manager
	s.name = "game"
	s.transition_duration = 1000
	s.state = "running"

	return s
end

function GameScene:load()
	self.particle_manager = ParticleManager.new()
	self.attack_manager = AttackManager.new(self.particle_manager)
	self.state = "running"

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
		punch = "kp0",
		kick = "kp.",
		special = "kp1"
	}

	self.players:add(Character.new("player", 100, 300, PlayerController.new(p1_controls), self.attack_manager))
	local p2 = Character.new("player2", screen_width - 100, 300, AIController.new(), self.attack_manager)
	p2:set_dir("left")
	self.players:add(p2)

	TiledMap_Load("content/maps/map1.tmx", 32, "content/gfx/tiles.png")

	audio_manager:play_sound("suck_it")
	audio_manager:play_song("song1")
end

function GameScene:on_activated()
	self:load()
end

function GameScene:game_over(winner, loser)
	self.state = "game_over"
	audio_manager:play_sound("k_o")
end

function GameScene:update(dt)
	if self.state == "running" then
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
			self:game_over(self.players:first(), self.players:first())
		elseif self.players:last().health <= 0.0 then
			self:game_over(self.players:last(), self.players:first())
		end
	elseif self.state == "game_over" then
	end

	if love.keyboard.isDown("return") then
		self.scene_manager:set_scene("menu")
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
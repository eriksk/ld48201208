GameScene = {}
GameScene.__index = GameScene

function GameScene.new(scene_manager)
	local s = {}
	setmetatable(s, GameScene)

	s.scene_manager = scene_manager
	s.name = "game"
	s.transition_duration = 1000

	return s
end

function GameScene:load()
	self.players = List.new()
	self.players:add(Character.new("player", 100, 300, Player2Controller.new()))
	local p2 = Character.new("player2", screen_width - 100, 300, AIController.new())
	p2:set_dir("left")
	self.players:add(p2)

	TiledMap_Load("content/maps/map1.tmx", 32, "content/gfx/tiles.png")
end

function GameScene:on_activated()
	self:load()
end

function GameScene:update(dt)
	for i=1,self.players:size() do
		self.players:get(i):update(dt)
	end
	--if love.keyboard.isDown("left") then
	--	self.scene_manager:set_scene("menu")
	--end
end

function GameScene:draw()
    set_color(Color.white())
    TiledMap_DrawNearCam(screen_width / 2.0, screen_height / 2.0)
    for i=1,self.players:size() do
    	self.players:get(i):draw()
    end
end
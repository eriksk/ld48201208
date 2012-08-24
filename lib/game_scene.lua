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
	boxes = List.new()	

	box = Sprite.new('box', 200, 200)
	boxes:add(box)
	boxes:add(box)
	boxes:add(box)
	boxes:add(box)
	boxes:add(box)
end

function GameScene:on_activated()
	self:load()
end

function GameScene:update(dt)
	for i=1,boxes:size() do
		boxes:get(i):update(dt)
		boxes:get(i):rotate(0.0005 * dt)
	end

	if love.keyboard.isDown("left") then
		self.scene_manager:set_scene("menu")
	end
end

function GameScene:draw(dt)
	for i=1,boxes:size() do
		boxes:get(i):draw()
	end
end


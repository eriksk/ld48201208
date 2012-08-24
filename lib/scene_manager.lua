SceneManager = {}
SceneManager.__index = SceneManager

SCENE_STATE_NORMAL = 0
SCENE_STATE_TRANSITION = 1

function SceneManager.new()
	local sm = {}
	setmetatable(sm, SceneManager)

	sm.state = SCENE_STATE_NORMAL
	sm.scenes = {}
	
	return sm
end

function SceneManager:add_scene(scene)
	self.scenes[#self.scenes + 1] = scene
end

function SceneManager:set_scene(name)
	for i=1,#self.scenes do
		if self.scenes[i].name == name then
			self.current_scene = self.scenes[i]
			self.current_scene:on_activated()
		end
	end
end

function SceneManager:update(dt)
	if self.current_scene then
		self.current_scene:update(dt)
	end
end

function SceneManager:draw()
	if self.current_scene then
		self.current_scene:draw()
	end
end
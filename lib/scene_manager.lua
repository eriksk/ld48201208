SceneManager = {}
SceneManager.__index = SceneManager

SCENE_STATE_NORMAL = 0
SCENE_STATE_TRANSITION = 1

function SceneManager.new(audio_manager)
	local sm = {}
	setmetatable(sm, SceneManager)

	sm.state = SCENE_STATE_NORMAL
	sm.scenes = {}
	sm.audio_manager = audio_manager
	sm.current_scene = nil
	
	return sm
end

function SceneManager:add_scene(scene)
	self.scenes[scene.name] = scene
end

function SceneManager:set_scene(name)
	self.current_scene = name
	self.scenes[self.current_scene]:on_activated()
	-- stop all songs
	self.audio_manager:stop_all()
	-- reset color
	set_color(Color.white())
end

function SceneManager:update(dt)
	if self.current_scene then
		self.scenes[self.current_scene]:update(dt)
	end
end

function SceneManager:draw()
	if self.current_scene then
		self.scenes[self.current_scene]:draw()
	end
end
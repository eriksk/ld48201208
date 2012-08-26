Scene = {}
Scene.__index = Scene

function Scene.new(scene_manager)
	local s = {}
	setmetatable(s, Scene)

	s.name = ""
	s.transition_duration = 1000
	s.scene_manager = scene_manager

	return s
end

function Scene:load()
end

function Scene:on_activated()
end

function Scene:update(dt)
end

function Scene:draw(dt)
end
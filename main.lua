require "lib/helpers"
require 'lib/color'
require "lib/list"
require "lib/vec2"
require "lib/sprite"
require 'lib/text_field'
require 'lib/audio_manager'
require 'lib/scene_manager'
require 'lib/game_scene'
require 'lib/menu_scene'

function love.load()
	font = love.graphics.newFont("content/fonts/font.ttf", 24)
	love.graphics.setFont(font)

	-- TODO: resolution, probably just go with static 800 x 600
	modes = love.graphics.getModes()
	for k,v in pairs(modes) do
		--print(k)
		for k1,v1 in pairs(v) do
			--print(k1, v1)
		end
	end

	total_time = 0.0

	audio_manager = AudioManager.new()
	audio_manager:add_sound("startup")
	audio_manager:add_song("menu")

	scene_manager = SceneManager.new(audio_manager)
	scene_manager:add_scene(GameScene.new(scene_manager))
	scene_manager:add_scene(MenuScene.new(scene_manager))
	scene_manager:set_scene("menu")

end

function love.update(dt)
	dt = dt * 1000.0 -- to ms

	-- global timer
	total_time = total_time + dt

	-- allow the game to quit
	-- TODO: remove before release
	if love.keyboard.isDown("escape") then
		love.event.push("quit")
	end

	scene_manager:update(dt)
end

function love.draw()
	scene_manager:draw()
end
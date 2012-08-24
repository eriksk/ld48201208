require "lib/helpers"
require 'lib/color'
require "lib/list"
require "lib/vec2"
require "lib/sprite"
require 'lib/text_field'
require 'lib/scene_manager'
require 'lib/game_scene'
require 'lib/menu_scene'

function love.load()
	font = love.graphics.newFont("content/fonts/font.ttf", 24)
	love.graphics.setFont(font)

	modes = love.graphics.getModes()
	for k,v in pairs(modes) do
		--print(k)
		for k1,v1 in pairs(v) do
			--print(k1, v1)
		end
	end

	scene_manager = SceneManager.new()
	scene_manager:add_scene(GameScene.new(scene_manager))
	scene_manager:add_scene(MenuScene.new(scene_manager))
	scene_manager:set_scene("menu")

end

function love.update(dt)
	dt = dt * 1000.0 -- to ms

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
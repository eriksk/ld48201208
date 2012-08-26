-- framework
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
require 'lib/animation'
require 'lib/tmx_map'
require 'lib/particle_manager'
require 'lib/particle'

-- game specifics
require 'lib/game/character'
require 'lib/game/player_controller'
require 'lib/game/ai_controller'
require 'lib/game/attack_manager'
require 'lib/game/attack'
require 'lib/game/hud'
--- special attacks
require 'lib/game/specials/hadouken'

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

	initialize()

	total_time = 0.0

	audio_manager = AudioManager.new()
	audio_manager:add_sound("startup")
	audio_manager:add_sound("hit_1", ".ogg")
	audio_manager:add_sound("hit_2", ".ogg")
	audio_manager:add_sound("hit_3", ".ogg")
	audio_manager:add_sound("k_o", ".ogg")
	audio_manager:add_sound("ouch_1", ".ogg")
	audio_manager:add_sound("ouch_2", ".ogg")
	audio_manager:add_sound("ouch_3", ".ogg")
	audio_manager:add_sound("suck_it", ".ogg")
	audio_manager:add_sound("swoosh_1", ".ogg")
	audio_manager:add_sound("swoosh_2", ".ogg")
	audio_manager:add_sound("hadouken", ".wav")

	audio_manager:add_song("menu")
	audio_manager:add_song("song1")

	scene_manager = SceneManager.new(audio_manager)
	scene_manager:add_scene(GameScene.new(scene_manager))
	scene_manager:add_scene(MenuScene.new(scene_manager))
	scene_manager:set_scene("game")
end

function initialize()
	screen_width = 800
	screen_height = 640
	fullscreen = false
	love.graphics.setMode(screen_width, screen_height, fullscreen)
	love.graphics.setBackgroundColor(135, 206, 250)
	content_path = "content/"
	texture_filter = "nearest"
	gravity = 0.001
	friction = 0.001
	ground = 500
	dt_slow_down = 0
end

function love.update(dt)
	dt = dt * 1000.0 -- to ms
	if dt_slow_down > 0.0 then
		dt_slow_down = dt_slow_down - dt
		dt = dt * 0.5
	end

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
require "lib/attacks/attack"
require "lib/attacks/attack_manager"
require "lib/attacks/attack_factory"

require "lib/attacks/specials/hadouken"
require "lib/attacks/specials/green_ball"
require "lib/attacks/specials/spread"
require "lib/attacks/specials/stars"

require "lib/audio/audio_manager"
require "lib/characters/character"
require "lib/controllers/player_controller"
require "lib/controllers/ai_controller"
require "lib/particles/particle"
require "lib/particles/particle_manager"

require "lib/scenes/scene_manager"
require "lib/scenes/menu_scene"
require "lib/scenes/game_scene"
require "lib/scenes/select_players_scene"

require "lib/tmx/tmx_map"
require "lib/ui/hud"
require "lib/utils/animation"
require "lib/utils/color"
require "lib/utils/helpers"
require "lib/utils/list"
require "lib/utils/sprite"
require "lib/utils/text_field"
require "lib/utils/vec2"

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
	scene_manager:add_scene(SelectPlayersScene.new(scene_manager))
	scene_manager:set_scene("menu")
end

function initialize()
	screen_width = 800
	screen_height = 640
	fullscreen = false
	love.graphics.setMode(screen_width, screen_height, fullscreen)
	love.graphics.setBackgroundColor(135, 206, 250)
	content_path = "content/"
	texture_filter = "nearest"
	gravity = 0.0008
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

	scene_manager:update(dt)
end

function love.draw()
	scene_manager:draw()
end
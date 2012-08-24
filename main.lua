--require "lib/helpers"
--require "lib/list"
--require "lib/vec2"
--require "lib/sprite"

function love.load()
	font = love.graphics.newFont("content/fonts/font.ttf", 24)
end

function love.update(dt)
end

function love.draw()
	love.graphics.setFont(font)
	love.graphics.print("Hello Ludum Dare!!1", 400, 300)
end

AudioManager = {}
AudioManager.__index = AudioManager

function AudioManager:new()
	local a = {}
	setmetatable(a, AudioManager)

	a.sounds = {}
	a.songs = {}

	return a
end

function AudioManager:add_sound(name, file_type)
	self.sounds[name] = love.audio.newSource("content/audio/" .. name .. (file_type or ".wav"), "static")
end

function AudioManager:add_song(name)
	self.songs[name] = love.audio.newSource("content/audio/" .. name .. ".wav")
	self.songs[name]:setLooping(true)
end

function AudioManager:play_sound(name)
	love.audio.stop(self.sounds[name])
	love.audio.play(self.sounds[name])
end

function AudioManager:play_song(name)
	love.audio.play(self.songs[name])
end

function AudioManager:stop_all()
	for k,v in pairs(self.songs) do
		love.audio.stop(self.songs[k])
	end
end
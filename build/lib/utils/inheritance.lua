function inherit(baseClass)
	
	local new_class = {}
	local class = { __index = new_class }

	function new_class:new()
		local n = {}
		setmetatable(n, class)
		return n
	end

	if baseClass then
		setmetatable(new_class, { __index = baseClass })
	end

	return new_class
end
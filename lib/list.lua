List = {}
List.__index = List

function List.new()
	local l = {}
	setmetatable(l, List)

	l.items = {}

	return l
end

function List:get(index)
	return self.items[index]
end

function List:size()
	return #self.items
end

function List:add(item)
	self.items[#self.items + 1] = item
end

function List:remove(index)
	table.remove(self.items, index)
end

function List:last()
	return self.items[#self.items]
end

function List:first()
	if self:size() > 0 then
		return self.items[1]
	else
		return nil
	end
end

function List:clear()
	for k in pairs(self.items) do
		self.items[k] = nil
	end
end
local chain = {} 
chain.__index = chain

local function new(x,y)
	return setmetatable({x = x or 0, y = y or 0}, vector)
end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})

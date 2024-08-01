-- Define Chain class
Chain = {}
Chain.__index = Chain

function new(linkCount)
    local base = {}
    table.insert()
    return base
end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})
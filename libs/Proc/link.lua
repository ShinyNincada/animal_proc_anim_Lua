-- Define Chain class
Link = {}
Link.__index = Link

function new(pos)
    local base = {}
    base.angle = 90
    base.pos = pos or Vector()
    return base
end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})
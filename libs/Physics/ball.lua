Ball = {}
local Ball = {};
Ball.__index = Ball

function new(pos)
    local base = {}
    base.position = pos or Vector()
    setmetatable(base, Link)
    return base
end

function Ball:draw() 
	love.graphics.setColor(1,0,0)
    love.graphic.circle("fill", self.x, self.x, 16)
end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})
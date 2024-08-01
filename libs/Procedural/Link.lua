-- Define Chain class
Link = {}
Link.radius = 16
Link.__index = Link
Link.angle = 90


function new(pos)
    local base = {}
    base.position = pos or Vector()
    setmetatable(base, Link)
    return base
end

function new(pos, radius)
    local base = {}
    base.position = pos or Vector()
    base.radius = radius or 16
    setmetatable(base, Link)
    return base
end


function Link:draw() 
    -- love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

function Link:getPositionOnR(angle)
    local angleInRadians = math.rad(angle)  -- Convert angle to radians
    local x = self.position.x + self.radius * math.cos(angleInRadians)
    local y = self.position.y + self.radius * math.sin(angleInRadians)
    local p = Vector(x, y)  -- Assuming Vector is a function or class constructor
    
    return p
end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})
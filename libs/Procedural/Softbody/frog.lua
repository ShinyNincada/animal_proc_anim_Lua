local Blob = require(".libs.Procedural.Softbody.blob")

local Frog = {}
Frog.__index = Frog

function Frog:new(pos)
    local self = setmetatable({}, Frog)

    self.blob = Blob:new(pos, 6, 30) -- (position, segment count, radius or spacing)
    -- Add any custom frog logic like eyes, control, etc.

    return self
end

function Frog:update(w, h, mx, my, mouseDown)
    local target = Vector(mx, my)
    self.blob:update(w, h, target, mouseDown)
end

function Frog:draw()
    self.blob:draw()
end

return Frog

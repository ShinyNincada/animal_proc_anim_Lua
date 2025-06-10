Limb = {}
Limb.__index = Limb

function Limb:new(origin, length, a1, a2, a3, a4)
  local this = {
    shoulder = origin,
    length = length,
    a1,a2,a3,a4 = a1, a2, a3, a4,
    elbow = Vector(origin.x, origin.y),
    foot  = Vector(origin.x, origin.y + length)
  }
  return setmetatable(this, self)
end

function Limb:resolve(anchor, normal)
  -- Simple 2-bone IK: shoulder→elbow→foot
  self.shoulder = anchor
  self.elbow = anchor:add(Vector(math.cos(normal+self.a1), math.sin(normal+self.a1)):mul(self.length*0.5))
  self.foot  = self.elbow:add(Vector(math.cos(normal+self.a2), math.sin(normal+self.a2)):mul(self.length*0.5))
end

function Limb:display(anchor)
  love.graphics.setLineWidth(10)
  love.graphics.setColor(0, 0, 0)
  love.graphics.line(anchor.x, anchor.y, self.elbow.x, self.elbow.y, self.foot.x, self.foot.y)

  love.graphics.setLineWidth(6)
  love.graphics.setColor(0.33, 0.57, 0.50)
  love.graphics.line(anchor.x, anchor.y, self.elbow.x, self.elbow.y, self.foot.x, self.foot.y)
end

-- the module
return Limb
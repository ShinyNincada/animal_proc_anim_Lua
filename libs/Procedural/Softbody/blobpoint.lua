-- BlobPoint class
BlobPoint = {}
BlobPoint.__index = BlobPoint

--- func desc
---@param pos : Vector
---@return this: BlobPoint
function BlobPoint:new(initPos)
  local this = {
    pos = Vector.clone(initPos),
    ppos = Vector.clone(initPos),
    displacement = Vector.zero,
    displacementWeight = 0
  }
  setmetatable(this, self)
  return this
end

function BlobPoint:verletIntegrate()
  local temp = Vector.clone(self.pos)
  local velocity = Vector.zero
  velocity = self.pos - self.ppos
  velocity = velocity * 0.99
  self.pos = self.pos + velocity
  self.ppos = temp
end

function BlobPoint:applyGravity()
  self.pos.y = self.pos.y + 1
end

function BlobPoint:accumulateDisplacement(offset)
  self.displacement = self.displacement + offset
  self.displacementWeight = self.displacementWeight + 1
end

function BlobPoint:applyDisplacement()
  if self.displacementWeight > 0 then
    self.displacement = self.displacement / self.displacementWeight
    self.pos = self.pos + self.displacement
    
    -- Reset the displacement counter
    self.pos = Vector.zero
    self.displacementWeight = 0
  end
end

function BlobPoint:keepInBounds(w, h)
  self.pos.x = math.max(0, math.min(self.pos.x, w))
  self.pos.y = math.max(0, math.min(self.pos.y, h))
end

function BlobPoint:collideWithMouse(mx, my, pressed)
  if pressed then
    local dx = self.pos.x - mx
    local dy = self.pos.y - my
    local dist = math.sqrt(dx * dx + dy * dy)
    if dist < 100 then
      local scale = 100 / dist
      self.pos.x = mx + dx * scale
      self.pos.y = my + dy * scale
    end
  end
end

-- the module
return BlobPoint
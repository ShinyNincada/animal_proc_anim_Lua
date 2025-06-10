Blob = {}
Blob.__index = Blob
function Blob:new(originX, originY, numPoints, radius, puffiness)
  local this = {
    radius = radius or 100,
    area = radius * radius * math.pi * puffiness,
    circumference = radius * 2 * math.pi,
    chordLength = (radius * 2 * math.pi) / numPoints,
    points = {}
  }

  for i = 0, numPoints - 1 do
    local angle = (2 * math.pi * i / numPoints) - math.pi / 2
    local px = originX + math.cos(angle) * radius
    local py = originY + math.sin(angle) * radius
    table.insert(this.points, BlobPoint:new(px, py))
  end

  setmetatable(this, self)
  return this
end

function Blob:getArea()
  local area = 0
  for i = 1, #self.points do
    local cur = self.points[i].pos
    local next = self.points[(i % #self.points) + 1].pos
    area = area + ((cur.x - next.x) * (cur.y + next.y) / 2)
  end
  return area
end

function Blob:update(w, h, mx, my, pressed)
  for _, point in ipairs(self.points) do
    point:verletIntegrate()
    point:applyGravity()
  end

  for _ = 1, 10 do
    for i = 1, #self.points do
      local cur = self.points[i]
      local next = self.points[(i % #self.points) + 1]

      local dx = next.pos.x - cur.pos.x
      local dy = next.pos.y - cur.pos.y
      local dist = math.sqrt(dx * dx + dy * dy)

      if dist > self.chordLength then
        local error = (dist - self.chordLength) / 2
        local nx = dx / dist * error
        local ny = dy / dist * error
        cur:accumulateDisplacement(nx, ny)
        next:accumulateDisplacement(-nx, -ny)
      end
    end

    local areaError = self.area - self:getArea()
    local offset = areaError / self.circumference

    for i = 1, #self.points do
      local prev = self.points[(i - 2 + #self.points) % #self.points + 1]
      local cur = self.points[i]
      local next = self.points[i % #self.points + 1]

      local secX = next.pos.x - prev.pos.x
      local secY = next.pos.y - prev.pos.y
      local len = math.sqrt(secX * secX + secY * secY)
      local normX = -secY / len * offset
      local normY = secX / len * offset
      cur:accumulateDisplacement(normX, normY)
    end

    for _, point in ipairs(self.points) do
      point:applyDisplacement()
    end

    for _, point in ipairs(self.points) do
      point:keepInBounds(w, h)
      point:collideWithMouse(mx, my, pressed)
    end
  end
end

function Blob:draw()
  love.graphics.setLineWidth(3)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setLineJoin("bevel")
  love.graphics.setLineStyle("smooth")

  local curve = {}

  local n = #self.points
  for i = -2, n + 1 do
    local idx = (i - 1) % n + 1
    local p = self.points[idx].pos
    table.insert(curve, p.x)
    table.insert(curve, p.y)
  end

  love.graphics.line(curve)

  love.graphics.setColor(0.16, 0.17, 0.21)
  for _, point in ipairs(self.points) do
    love.graphics.circle("fill", point.pos.x, point.pos.y, 16)
  end
end

-- the module
return Blob
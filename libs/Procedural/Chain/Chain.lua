local link = require('libs.Procedural.Link')

local Chain = {};
Chain.gap = 16
Chain.__index = Chain

local function new(count, position, angle)
	return setmetatable({
		linkCount = count,
		position = position or Vector(),
		angle = angle or 0
	}, Chain)
end

function Chain:init()
	for i = 1, self.linkCount do
		local newLink = link(self.position)
		table.insert(self, i, newLink);
	end
end

function Chain:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()
    local worldX, worldY = mainCam:worldCoords(mouseX, mouseY)
	self[1].position = Vector(worldX, worldY)
    for i = 2, self.linkCount do
        if(dist(self[i].position, self[i-1].position) >= self.gap) then 
            self[i].position = ConstrainDistance(self[i].position, self[i-1].position, self.gap)
        end
    end

	TestValue = angleTo(self[2].position, self[1].position)

--    for i = 1, #chain do
--         left[i] = getPosition(chain[i].pos, 16, 180)
--         right[i] = getPosition(chain[i].pos, 16, 360)
--    end
end

function Chain:DrawEyes()
	local head = self[1]
    local right = head:getPositionOnR(TestValue)
    -- local left = head:getPositionOnR(180)
    love.graphics.circle("fill", right.x, right.y, 4)
    -- love.graphics.circle("fill", left.x, left.y, 4)
end

function Chain:draw()
	for i = 1, self.linkCount do
			-- self:DrawEyes()

	    if(i == 1) then 
	        self:DrawEyes()
	    end
	    love.graphics.setColor(1,1,1)
	    love.graphics.circle("line", self[i].position.x, self[i].position.y, 16)
	    love.graphics.setColor(1,0,0)
	    -- for j = 0, 360, 180 do 
	    --     local pos = getPosition(self[i].pos, 16, j)
	    --     love.graphics.circle("fill", pos.x, pos.y, 4)
	    -- end
	end
	love.graphics.setColor(1,0,0)

	for i = 1, self.linkCount - 1 do 
	    love.graphics.line(self[i].position.x, self[i].position.y, self[i+1].position.x, self[i+1].position.y)
	end
end

-- function ConstrainDistance(point, anchor, distance) 
--     return ((point - anchor).normalize() * distance) + anchor;
-- end



-- function InsertLeft(centers) 
--     for i = 1, #centers do 
--         table.insert(left, getPosition(centers[i].pos, 16, 180))
--     end
-- end

-- function InsertRight(centers) 
--     for i = 1, #centers do 
--         table.insert(right, getPosition(centers[i].pos, 16, 360))
--     end
-- end

-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})

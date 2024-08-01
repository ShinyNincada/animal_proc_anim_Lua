local link = require('libs.Procedural.Link')

local Snake = {};
Snake.gap = 16
Snake.__index = Snake

local function new(count, position, angle)
	return setmetatable({
		linkCount = count,
		position = position or Vector(),
		angle = angle or 0
	}, Snake)
end

local left = {}
local right = {}

function Snake:init()
    local head = link(self.position, 20)
    table.insert(self, head);

	for i = 2, self.linkCount do
		local newLink = link(self.position, 16-i)
		table.insert(self, i, newLink);
        table.insert( left, self[i]:getPositionOnR(0 + self[i].angle) )
        table.insert( right, self[i]:getPositionOnR(180 + self[i].angle) )
	end
end

function Snake:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()
    local worldX, worldY = mainCam:worldCoords(mouseX, mouseY)
	self[1].position = Vector(worldX, worldY)
    for i = 2, self.linkCount do
        if(dist(self[i].position, self[i-1].position) >= self.gap) then 
            self[i].position = ConstrainDistance(self[i].position, self[i-1].position, self.gap)
            self[i].angle = self[i-1].angle
        end
    end
    
    for i = 1, self.linkCount do 
        
        left[i] = self[i]:getPositionOnR(0 + self[i].angle)
        right[i] = self[i]:getPositionOnR(180 + self[i].angle) 
    end

	TestValue = angleTo(self[2].position, self[1].position)
  
--    for i = 1, #Snake do
--         left[i] = getPosition(Snake[i].pos, 16, 180)
--         right[i] = getPosition(Snake[i].pos, 16, 360)
--    end
end



function Snake:Head()
	local head = self[1]
    local right = head:getPositionOnR(TestValue + 30)
    local left = head:getPositionOnR(TestValue - 30)
    -- local left = head:getPositionOnR(180)
    love.graphics.circle("fill", right.x, right.y, 4)
    love.graphics.circle("fill", left.x, left.y, 4)
    -- love.graphics.circle("fill", left.x, left.y, 4)
end

function Snake:draw()
	for i = 1, self.linkCount do
			-- self:DrawEyes()

	    if(i == 1) then 
	        self:Head()
	    end
	    love.graphics.setColor(1,1,1)
	    love.graphics.circle("line", self[i].position.x, self[i].position.y, self[i].radius)
	    love.graphics.setColor(1,0,0)
	    -- for j = 1, self.linkCount do 
	    --     local pos = self[i]:getPositionOnR(j+self[i].angle)
	    --     love.graphics.circle("fill", left[j].x, left[j].y, 4)
	    -- end
	    love.graphics.circle("fill", left[i].x, left[i].y, 4)
	    love.graphics.circle("fill", right[i].x, right[i].y, 4)
	end
	love.graphics.setColor(1,0,0)

	for i = 1, self.linkCount - 1 do 
	    love.graphics.line(self[i].position.x, self[i].position.y, self[i+1].position.x, self[i+1].position.y)
	    love.graphics.line(left[i].x, left[i].y, left[i+1].x, left[i+1].y)
	    love.graphics.line(right[i].x, right[i].y, right[i+1].x, right[i+1].y)
	end

end

function ConstrainDistance(point, anchor, distance) 
    return ((point - anchor).normalize() * distance) + anchor;
end


-- the module
return setmetatable({new = new},
	{__call = function(_, ...) return new(...) end})

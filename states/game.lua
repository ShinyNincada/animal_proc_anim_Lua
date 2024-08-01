local game = {}
local mainCam = Camera(0, 0)

local chain = {}
chain.count = 15
chain.gap = 16

local chainEye = {}
chainEye.size = 16
chainEye.dotCount = 2
chainEye.angle = 90

left = {}
right = {}

function ConstrainDistance(point, anchor, distance) 
    return ((point - anchor).normalize() * distance) + anchor;
end

function getPosition( center, radius, angle)
    local p = Vector((center.x + radius * math.cos(math.rad(angle))),
    (center.y + radius* math.sin(math.rad(angle))));

    return p;
end

function game:init()
    mainCam:lookAt(0, 0)

    for i = 1, chain.count do 
        table.insert(chain, i, {pos = Vector(5, 5)})
    end

    InsertLeft(chain)
    InsertRight(chain)
end

function game:enter()

end

function game:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    local worldX, worldY = mainCam:worldCoords(mouseX, mouseY)
    chain[1].pos = Vector(worldX, worldY)
    for i = 2, chain.count do
        if(dist(chain[i].pos, chain[i-1].pos) >= chain.gap) then 
            chain[i].pos = ConstrainDistance(chain[i].pos, chain[i-1].pos, chain.gap)
        end
    end
   for i = 1, #chain do
        left[i] = getPosition(chain[i].pos, 16, 180)
        right[i] = getPosition(chain[i].pos, 16, 360)
   end
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function DrawEyes(centerPos) 
    local right = getPosition(centerPos, 8, 340)
    local left = getPosition(centerPos, 8, 200)
    love.graphics.circle("fill", right.x, right.y, 4)
    love.graphics.circle("fill", left.x, left.y, 4)
end

function InsertLeft(centers) 
    for i = 1, #centers do 
        table.insert(left, getPosition(centers[i].pos, 16, 180))
    end
end

function InsertRight(centers) 
    for i = 1, #centers do 
        table.insert(right, getPosition(centers[i].pos, 16, 360))
    end
end

function game:draw()
    mainCam:attach()
        -- for i = 1, chain.count do
        --     if(i == 1) then 
        --         DrawEyes(chain[i].pos)
        --     end
        --     love.graphics.setColor(1,1,1)
        --     love.graphics.circle("line", chain[i].pos.x, chain[i].pos.y, 16)
        --     love.graphics.setColor(1,0,0)
        --     for j = 0, 360, 180 do 
        --         local pos = getPosition(chain[i].pos, 16, j)
        --         love.graphics.circle("fill", pos.x, pos.y, 4)
        --     end
        -- end
        DrawEyes(chain[1].pos)
        love.graphics.setColor(1,0,0)

        for i = 1, chain.count - 1 do 
            love.graphics.line(left[i].x, left[i].y, left[i +1].x, left[i +1].y)
            love.graphics.line(right[i].x, right[i].y, right[i +1].x, right[i +1].y)
        end
        for i = 1, chain.count - 1 do 
            love.graphics.line(chain[i].pos.x, chain[i].pos.y, chain[i +1].pos.x, chain[i +1].pos.y)
        end
    mainCam:detach()
end


return game

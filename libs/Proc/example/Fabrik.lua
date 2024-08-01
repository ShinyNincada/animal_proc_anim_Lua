local game = {}
local mainCam = Camera(0, 0)

local chain = {}
chain.count = 50



function ConstrainDistance(point, anchor, distance) 
    return ((point - anchor).normalize() * distance) + anchor;
end

function game:init()
    mainCam:lookAt(0, 0)

    for i = 1, chain.count do 
        table.insert(chain, {pos = Vector(5, 5)})
    end
end

function game:enter()

end

function game:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    local worldX, worldY = mainCam:worldCoords(mouseX, mouseY)
    chain[1].pos = Vector(worldX, worldY)
    for i = 2, chain.count do 
        if(dist(chain[i].pos, chain[i-1].pos) >= 16) then 
            chain[i].pos = ConstrainDistance(chain[i].pos, chain[i-1].pos, 16)
        end
    end

    chain[chain.count].pos = Vector(0,0)
    for i = chain.count - 1, 1, -1 do 
        if(dist(chain[i].pos, chain[i+1].pos) >= 16) then 
            chain[i].pos = ConstrainDistance(chain[i].pos, chain[i+1].pos, 16)
        end
    end
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    mainCam:attach()
        for i = 1, chain.count do 
            love.graphics.circle("fill", chain[i].pos.x, chain[i].pos.y, 16)
        end
        for i = 1, chain.count - 1 do 
            love.graphics.line(chain[i].pos.x, chain[i].pos.y, chain[i +1].pos.x, chain[i +1].pos.y)
        end
    mainCam:detach()
end


return game

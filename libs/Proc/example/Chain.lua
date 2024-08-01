function init()
    for i = 1, chain.count do 
        table.insert(chain, {pos = Vector(5, 5)})
    end
end

function update(dt)
    chain[1].pos = Vector(love.mouse.getPosition())
    for i = 2, chain.count do 
        if(dist(chain[i].pos, chain[i-1].pos) >= 100) then 
            chain[i].pos = ConstrainDistance(chain[i].pos, chain[i-1].pos, 100)
        end
    end
end

function draw() 
    for i = 1, chain.count do 
        love.graphics.setColor(0,0,0)
        love.graphics.circle("fill", chain[i].pos.x, chain[i].pos.y, 16)
        love.graphics.setColor(1,0,0)
        love.graphics.circle("line", chain[i].pos.x + 8, chain[i].pos.y, 4)
        love.graphics.circle("line", chain[i].pos.x - 8, chain[i].pos.y, 4)
    end
end
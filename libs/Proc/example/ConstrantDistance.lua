local a = {pos = Vector(5, 5)}
local b = {pos = Vector(0, 0)}


function update(dt)
    a.pos = Vector(love.mouse.getPosition())
    if(dist(a.pos, b.pos) >= 100) then 
        b.pos = ConstrainDistance(b.pos, a.pos, 100)
    end
end

function draw() 
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", a.pos.x, a.pos.y, 16)

    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", b.pos.x, b.pos.y, 16)
end
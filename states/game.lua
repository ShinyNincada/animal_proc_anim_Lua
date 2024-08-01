local game = {}


-- local chain = Chain.new(100, Vector(0,0), 360)
local chain = Snake.new(16, Vector(0,0), 360)
function game:init()
    mainCam:lookAt(0, 0)
    chain:init()
end

function game:enter()

end

function game:update(dt)
    chain:update(dt)
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    mainCam:attach()
        chain:draw()
    mainCam:detach()

end


return game

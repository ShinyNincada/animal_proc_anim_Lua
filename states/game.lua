local game = {}
local snakeSegments = {12, 20, 20, 16, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}

-- local chain = Chain.new(100, Vector(0,0), 360)
local chain = Snake.new(16, Vector(0,0), 360)
function game:init()
    mainCam:lookAt(0, 0)
    chain:Init(snakeSegments)
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

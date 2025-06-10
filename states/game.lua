local game = {}
ScreenWidth = 1280               -- The window width (number)
ScreenHeight = 720
BlobPoint = require '.libs.Procedural.Softbody.blobpoint'
Blob = require ".libs.Procedural.Softbody.blob"
Limb = require ".libs.Procedural.Softbody.limb"
ThisFrog = require ".libs.Procedural.Softbody.frog"     -- from your previous blob.lua
-- require "vec2"

function game:init()
    mainCam:lookAt(0, 0)
    love.graphics.setBackgroundColor(1,1,1)
    frog = ThisFrog:new(Vector(400,300))
end

function game:enter()

end

function game:update(dt)
    local mx, my = love.mouse.getPosition()
    frog:update(love.graphics.getWidth(), love.graphics.getHeight(), mx, my, love.mouse.isDown(1))
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    if mainCam then
        mainCam:attach()
    end

    frog:draw()
    -- Limb:display(frog.position)
    if mainCam then
        mainCam:detach()
    end
end


return game

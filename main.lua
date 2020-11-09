push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load() 
    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text & graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')
    love.graphics.printf(
        "Hello Pong!",
        0,
        VIRTUAL_HEIGHT/2 - 6,
        VIRTUAL_WIDTH,
        'center')
    push:apply('end')
end
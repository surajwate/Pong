push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load() 
    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text & graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- add new retro font
    smallFont = love.graphics.newFont('font.ttf', 8) 

    -- set new font as LOVE2D's active font
    love.graphics.setFont(smallFont)

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
    -- begin rendering at virtual level
    push:apply('start')

    -- clear the screen with specific color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- draw welcome text towards the top of screen
    love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    
    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball at center
    love.graphics.rectangle('fill', VIRTUAL_WIDTH /2 - 2, VIRTUAL_HEIGHT /2 - 2, 4, 4)

    push:apply('end')
end
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

function love.load() 
    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text & graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- add new retro font
    smallFont = love.graphics.newFont('font.ttf', 8) 

    -- larger font for the scores
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set new font as LOVE2D's active font
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false
    })

    -- initialize the scores of players
    player1Score = 0
    player2Score = 0

    -- paddle positions on the Y axis
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    love.graphics.setFont(smallFont)
    love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    -- switch the font
    -- draw the score 
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    
    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- render ball at center
    love.graphics.rectangle('fill', VIRTUAL_WIDTH /2 - 2, VIRTUAL_HEIGHT /2 - 2, 4, 4)

    push:apply('end')
end
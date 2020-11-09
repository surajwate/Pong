push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

function love.load() 
    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text & graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- use current time to generate seed for randome number
    math.randomseed(os.time())

    -- add new retro font
    smallFont = love.graphics.newFont('font.ttf', 8) 

    -- larger font for the scores
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set new font as LOVE2D's active font
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize the scores of players
    player1Score = 0
    player2Score = 0

    -- paddle positions on the Y axis
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- ball position
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- game state variable used to transition between different parts of the game
    -- (used for beginning, menus, main game, high score list, etc.)
    -- we will use this to determine behavior during render and update
    gameState = 'start'
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2.dy = PADDLE_SPEED
    else 
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    -- if we press enter during the start state of the game, we'll go into play mode
    -- during play mode, the ball will move in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            
            -- ball's new reset method
            ball:reset()
        end
    end
end

function love.draw()
    -- begin rendering at virtual level
    push:apply('start')

    -- clear the screen with specific color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- draw welcome text towards the top of screen
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf("Hello Start State!", 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf("Hello Play State!", 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    -- render paddle, now using their class's render method 
    player1:render()
    player2:render()

    ball:render()

    -- new function just to demonstrate how to see FPS in LÖVE2D
    displayFPS()

    push:apply('end')
end

--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
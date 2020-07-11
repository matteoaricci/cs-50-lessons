push = require("push")
Class = require "class"
require 'Ball'
require 'Pipe'
require 'PipePair'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual res dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- we gotta add in images
-- here's background and parallax
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

-- here's ground and parallax
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

-- parallax speeds
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- looping points, images must be set up properly for looping
local BACKGROUND_LOOPING_POINT = 413

-- create Ball
local ball = Ball()

local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- calls this functin when it initializes on love2d
function love.load(  )
    -- set up filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    love.window.setTitle("I'm Learning Lua. Let's Fucin GO")

    -- initialize our virtual res
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync= true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

-- lets the user resize it
function love.resize(w, h)
    push:resize(w, h)
end

-- lets us easily quit
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then 
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then

        local y = math.max( -PIPE_HEIGHT,... )
        table.insert( pipes, Pipe())
        spawnTimer = 0
    end

    ball:update(dt)

    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then 
            table.remove(pipes, k)
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw( )
    push:start()

    -- draw background starting at top left (0, 0)
    love.graphics.draw(background, -backgroundScroll, 0)

    -- render the pipes
    for k,pipe in pairs(pipes) do
        pipe:render()
    end

    -- draw the ground on top of the background, toward the bottom of the screen
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- render the ball
    ball:render()

    push:finish()
end
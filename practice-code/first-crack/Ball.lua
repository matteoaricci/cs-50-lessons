Ball = Class{}

local GRAVITY = 10

function Ball:init()
    self.image = love.graphics.newImage('lure-ball-logo.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Ball:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Ball:update(dt)
    self.dy = self.dy + GRAVITY * dt  

    if love.keyboard.wasPressed('space') then 
        self.dy = -5
    end

    self.y = self.y + self.dy
end
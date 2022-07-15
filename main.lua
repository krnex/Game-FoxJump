local toon = require"toon"
local platform = require"platform"
local ground = require"ground"
local platformGenerator = require "platGenerator"
local HC = require "hardoncollider"

_WIDTH, _HEIGHT = 600, 800
_GRAVITY = 25


collider = HC.new(100)
player = toon()
ground = ground()
platGen = platGenerator()
platGen:load(_WIDTH, _HEIGHT, 20)
platformArray = platGen:getPlatArray()

platformTimer = love.timer.getTime()
platformYTimer = 0
platformRate = 100

gameOver, gameOverPossible  = false, false

screenPos = 0

function love.load()
    love.window.setTitle("Fox Jump")
    love.window.setMode(_WIDTH, _HEIGHT)

    player:load(_WIDTH / 2, _HEIGHT - 100, 50, 50, collider)
    ground:load(0, (_HEIGHT+10), _WIDTH * 2, 100, collider)
end

function love.update(dt)

    --updates the position of the platform and removes them if it gets below the screen
    for key,value in pairs(platformArray) do
        platformArray[key]:update(screenPos)

        if platformArray[key]:getY() > _HEIGHT then
            platformArray = platGen:removePlat(key, collider)
        end
    end

    --Adds another platform on a timer or when the player goes up a certain amount
    if love.timer.getTime() - platformTimer >= platGen:getSpawnRate() or screenPos + platformRate < platformYTimer then
        platformTimer = love.timer.getTime()
        platGen:addPlatform(platform(), collider, screenPos)
        DEBUG = platformTimer
        platformYTimer = screenPos
    end

    ground:update(screenPos)

    player:pre_update(_GRAVITY,dt)
    screenPos = screenPos + player:checkY(_HEIGHT)
    player:update(ground:getY(screenPos))

    collision()

end

function love.draw()
    for key,value in pairs(platformArray) do
        platformArray[key]:draw()
    end

    ground:draw()
    player:draw()

    love.graphics.print("Score: "..player:getScore(),10,10)

    if gameOver == true then
        love.graphics.print("GAME OVER. YOU HAVE A SCORE OF "..player:getScore(),_WIDTH/4, _HEIGHT/2)
    end
end

function collision()

    local groundCol = ground:getColl()
    local playerCol = player:getColl()

    if playerCol:collidesWith(groundCol) then
        player:setGround(true)

        if gameOverPossible == true then
            gameOver = true
        end
    else
        player:setGround(false)
    end

    for key,value in pairs(platformArray) do
        if playerCol:collidesWith(platformArray[key]:getColl()) and gameOver == false then
            platformArray = platGen:removePlat(key, collider)
            platGen:scoreAddition()
            player:scoreAdd(platGen:platformPoints())
            player:jump()

            gameOverPossible = true
            break
        end
    end


end

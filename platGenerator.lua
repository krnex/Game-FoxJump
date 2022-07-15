function platGenerator()
    local obj = {}
    local x, y, platformArray, platWidth, platHeight, width, height, spawnRate, platNum, pointsPer, maxHeight

    function obj:load(WIDTH, HEIGHT, size)
        width, height = WIDTH, HEIGHT
        maxHeight = 0
        platWidth, platHeight = size, size
        x = math.random(width)
        y = 0
        spawnRate = 3
        platNum, pointsPer = 0, 10
        platformArray = {}
    end

    function obj:addPlatform(platform, collider, addY)

        if addY < maxHeight then
            maxHeight = addY
        end

        local playformGenerated = platform:load(x, y, platWidth, platHeight, collider, maxHeight)

        x = math.random(width)

        table.insert(platformArray, platform)
        maxHeight = addY
    end

    function obj:removePlat(key, collider)

        table.remove(platformArray, key)

        return platformArray
    end

    function obj:scoreAddition()
        platNum = platNum + 1

    end

    function obj:getPlatArray() return platformArray end
    function obj:getSpawnRate() return spawnRate end
    function obj:platformPoints() return platNum * pointsPer end

    return obj
end

return platGenerator()

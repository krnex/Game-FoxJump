function toon()
    local obj = {}
    local w,h,x,y,speed,collider,color,yAcc, grounded, jSpeed, debug, score, pointsPer

    function obj:load(X, Y, width, height, Collider)
        x, y, w, h = X, Y, width, height
        color = {255,255,0}
        speed = 500
        grounded = false
        yAcc = 0
        jSpeed = 15
        debug = ""
        collider = Collider:rectangle(x,y,w,h)
        score, pointsPer = 0
    end

    function obj:draw()
        love.graphics.setColor(color)
        collider:draw('fill')
    end

    function obj:movement(dt)
        if love.mouse.getX() > x then
            if love.mouse.getX() < x+speed*dt then
                x = love.mouse.getX()
            else
                x = x + speed * dt
            end
        elseif love.mouse.getX() < x then
            if(love.mouse.getX() > x-speed*dt) then
                x = love.mouse.getX()
            else
                x = x - speed * dt
            end
        end

        if love.mouse.isDown(1) and grounded == true then
            obj:jump()
        end
    end

    function obj:pre_update(grav,dt)
        obj:movement(dt)
        obj:applyGrav(grav,dt)
    end

    function obj:update(groundY)

        if y > groundY then
            y = groundY
        end

        collider:moveTo(x,y)
    end

    function obj:applyGrav(grav,dt)
        if grounded == false then
            yAcc = yAcc + grav*dt
        elseif grounded == true and yAcc > 0 then
            yAcc = 0
        end
        y = y + yAcc
    end

    function obj:jump()
        yAcc = -jSpeed
    end

    function obj:checkY(height)

        local addCheck = 0

        if y < height/2 then
            addCheck = y - height/2
            y = height / 2
        elseif y > height then
            addCheck = y - height
            y = height
        end

        return addCheck
    end

    function obj:scoreAdd(points)
        score = score + points
    end

    function obj:setGround(x) grounded = x end
    function obj:getColl() return collider end
    function obj:getDebug() return debug end
    function obj:getScore() return score end

    return obj
end


return toon

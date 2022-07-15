function platform()
    local obj = {}
    local w,h,x,y,collider,color, speed, spawn

    function obj:load(X, Y, width, height, Collider, addY)
        spawn = addY
        x, y, w, h = X, Y, width, height
        speed = 1
        color = {255,255,100}
        collider = Collider:rectangle(x,y,w,h)
    end

    function obj:update(addY)
        y = y + speed

        collider:moveTo(x,y - addY + spawn)
    end

    function obj:draw()
        love.graphics.setColor(color)
        collider:draw('fill')
    end

    function obj:getColl() return collider end
    function obj:getY() return y + spawn end

    return obj
end

return platform

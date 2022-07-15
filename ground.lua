function ground()
    local obj = {}
    local w,h,x,y,collider,color

    function obj:load(X, Y, width, height, Collider)
        x, y, w, h = X, Y, width, height
        color = {0,255,100}
        collider = Collider:rectangle(x,y,w,h)
    end

    function obj:draw()
        love.graphics.setColor(color)
        collider:draw('fill')
    end

    function obj:update(addY)
        collider:moveTo(x,y - addY)
    end

    function obj:getColl() return collider end
    function obj:getY(addY) return (y - h/2) - addY end







    return obj
end

return ground

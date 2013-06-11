rainbowGlow = love.graphics.newShader [[
    vec4 effect(vec4 colour, Image img, vec2 txy, vec2 sxy)
    {
       return vec4(pow(cos((sxy.x-sxy.y)/20),2),
       	pow(sin((sxy.y+sxy.x)/20),2),
       	abs(1/(1+tan(length(sxy/20)))),
       	colour.a);
    }
]]
local miss = 0
local missleft = 25
function onCreate()
    makeLuaText('missesleft', 'Misses Left:', 500, 500, 500)
    setTextSize('missesleft', 50.5, 50.5)
    addLuaText('missesleft', true)
    
    makeLuaText('misses', missleft, 500, 700, 500)
    setTextSize('misses', 50.5, 50.5)
    addLuaText('misses', true)
end

function noteMiss()

    makeLuaText('misse', missleft, 500, 700, 500)
    setTextSize('misse', 50.5, 50.5)
    addLuaText('misse', true)

    if miss == 1 then
        removeLuaText('misses', true)
    end
    
    missleft = missleft - 1
    miss = miss + 1

    if miss == 27 then
        setProperty('health', 0)
    end
end

function noteMissPress()
    missleft = missleft -1
    miss = miss + 1

    if miss == 1 then
        removeLuaText('misses', true)
    end

    if miss == 27 then
        setProperty('health', 0)
    end
end
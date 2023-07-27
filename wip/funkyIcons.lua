local icos = {'', '', ''}
local vOffset = 0
local lastHeldDirection = {0, 0, 0}
local lastWasSus = {false, false, false}
function onCreatePost()
    icos[1] = getProperty('boyfriend.healthIcon')
    icos[2] = getProperty('dad.healthIcon')
    icos[3] = getProperty('gf.healthIcon')

    scaleObject('healthBarBG', 1.79, 9)
    scaleObject('healthBar', 2.16, 67.8)

    screenCenter('healthBar', 'x')
    screenCenter('healthBarBG', 'x')

    if downscroll then
        setProperty('healthBar.y', getProperty('healthBar.y') - 107)
        setProperty('healthBarBG.y', getProperty('healthBar.y'))
        vOffset = 50
    else
        setProperty('healthBar.y', getProperty('healthBar.y') - 670)
        setProperty('healthBarBG.y', getProperty('healthBar.y') - 10)
    end

    setObjectOrder('healthBar', getObjectOrder('timeBarBG') - 1)
    setObjectOrder('healthBarBG', getObjectOrder('timeBarBG') - 2)

    --setObjectOrder('iconP1', getObjectOrder('healthBar') + 1)
    --setObjectOrder('iconP2', getObjectOrder('healthBar') + 2)

    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)

    for i = 1, #icos do
        if i == 3 and icos[3] == icos[2] then else
        makeLuaSprite('iconP'..i..'F', 'icons/icon-' .. icos[i], 100, 100) end
        setObjectCamera('iconP'..i..'F', 'hud')
        if stringEndsWith(icos[i], '-pixel') then setProperty('iconP'..i..'F.antialiasing', false) end
        setObjectOrder('iconP'..i..'F', getObjectOrder('healthBar') + i)
        if i == 1 or i == 3 then setProperty('iconP'..i..'F.flipX', true) end

        -- stole this from ralt
        setProperty("iconP"..i.."F._frame.frame.x", 0)
        setProperty("iconP"..i.."F._frame.frame.y", 0)
        setProperty("iconP"..i.."F._frame.frame.width", 150)
        setProperty("iconP"..i.."F._frame.frame.height", 150)

        addLuaSprite('iconP'..i..'F')
    end
end

local rayman = { -- bf and gf
    {x = 320,  y = 150}, -- left
    {x = 215,  y = 150}, -- down
    {x = 215,  y = 150}, -- up
    {x = 120,  y = 150}, -- right
}

local origins = { -- dad
    {x = 150, y = 150},
    {x = 75,  y = 150}, 
    {x = 75,  y = 150}, 
    {x = 0,   y = 150},
}

local directionScales = {
    {x = 1.4, y = 1},
    {x = 1.4, y = 0.5},
    {x = 0.8, y = 1.4},
    {x = 1.4, y = 1}
}

function onCountdownTick(c)
    if c % 2 == 0 then
        for i = 1, #icos do
            if i ~= 2 then
            setProperty('iconP'..i..'F.origin.x', rayman[2].x)
            setProperty('iconP'..i..'F.origin.y', rayman[2].y)
            else
                setProperty('iconP'..i..'F.origin.x', origins[2].x)
                setProperty('iconP'..i..'F.origin.y', origins[2].y)
            end
            setProperty('iconP'..i..'F.scale.x', 1.2)
            setProperty('iconP'..i..'F.scale.y', 0.7)
        end
    end
end

function onUpdate(elapsed)
    if lastWasSus[1] then
        if getProperty("boyfriend.holdTimer") > 0 then
            setProperty('iconP1F.scale.x', directionScales[lastHeldDirection[1] + 1].x)
            setProperty('iconP1F.scale.y', directionScales[lastHeldDirection[1] + 1].y)
        elseif (getProperty("boyfriend.holdTimer") > getPropertyFromClass("Conductor", "stepCrochet") * 0.0011 * getProperty("boyfriend.singDuration")) then
            setProperty("boyfriend.holdTimer", 0)
        end
    end

    if lastWasSus[2] then
        if getProperty("dad.holdTimer") > 0 then
            setProperty('iconP2F.scale.x', directionScales[lastHeldDirection[2] + 1].x)
            setProperty('iconP2F.scale.y', directionScales[lastHeldDirection[2] + 1].y)
        end
    end

    if lastWasSus[3] then
        if getProperty("gf.holdTimer") > 0 then
            setProperty('iconP3F.scale.x', directionScales[lastHeldDirection[3] + 1].x)
            setProperty('iconP3F.scale.y', directionScales[lastHeldDirection[3] + 1].y)
        end
    end

    for i = 1, #icos do
        setProperty('iconP'..i..'F.scale.x', math.lerp(1, getProperty('iconP'..i..'F.scale.x'), fakeBoundTo(1 - (elapsed * 9), 0, 1)))
        setProperty('iconP'..i..'F.scale.y', math.lerp(1, getProperty('iconP'..i..'F.scale.y'), fakeBoundTo(1 - (elapsed * 9), 0, 1)))
    end

    if getProperty('healthBar.percent') > 80 then
        adjustIcon('iconP2F', false) else
        adjustIcon('iconP2F', true) end
    
    if getProperty('healthBar.percent') < 20 then
        adjustIcon('iconP1F', false)
        adjustIcon('iconP3F', false)
    else
        adjustIcon('iconP1F', true)
        adjustIcon('iconP3F', true)
    end
end

function onUpdatePost(elapsed)
    setProperty('iconP1F.x', (screenWidth / 2.25))
    setProperty('iconP2F.x', (screenWidth / 3.15))

    setProperty('iconP1F.y', (getProperty('healthBar.y') + 400) - vOffset)
    setProperty('iconP2F.y', (getProperty('healthBar.y') + 400) - vOffset)

    setProperty('iconP3F.x', (screenWidth / 2.25) - getProperty('iconP3F.width') / 2)
    setProperty('iconP3F.y', (getProperty('healthBar.y') + 250) - vOffset)
end

function onBeatHit()
    if not singnG and getProperty('gf.holdTimer') <= 0 then
        if curBeat % 2 == 0 then
            setProperty('iconP3F.origin.x', rayman[2].x - 150)
            setProperty('iconP3F.origin.y', rayman[2].y)
            setProperty('iconP3F.scale.x', 1.2)
            setProperty('iconP3F.scale.y', 0.7)
        else
            setProperty('iconP3F.origin.x', rayman[2].x + 150)
            setProperty('iconP3F.origin.y', rayman[2].y)
            setProperty('iconP3F.scale.x', 1.2)
            setProperty('iconP3F.scale.y', 0.7)
        end
    end

    if not singn and getProperty('boyfriend.holdTimer') <= 0 then
        setProperty('iconP1F.origin.x', rayman[2].x)
        setProperty('iconP1F.origin.y', rayman[2].y)
        setProperty('iconP1F.scale.x', 1.2)
        setProperty('iconP1F.scale.y', 0.7)
    end

    if not singnOp and getProperty('dad.holdTimer') <= 0 then
        setProperty('iconP2F.origin.x', origins[2].x)
        setProperty('iconP2F.origin.y', origins[2].y)
        setProperty('iconP2F.scale.x', 1.2)
        setProperty('iconP2F.scale.y', 0.7)
    end
end

function onStepHit() -- only checks every step if there is a new character icon
    check = {getProperty('boyfriend.healthIcon'), getProperty('dad.healthIcon'), getProperty('gf.healthIcon')}
    for i = 1, 3 do
        if check[i] ~= icos[i] then
            icos[i] = check[i]

            makeLuaSprite('iconP'..i..'F', 'icons/icon-' .. icos[i], 100, 100)
            setObjectCamera('iconP'..i..'F', 'hud')
            setObjectOrder('iconP'..i..'F', getObjectOrder('healthBar') + i)
            if i == 1 or i == 3 then setProperty('iconP'..i..'F.flipX', true) end

            setProperty("iconP"..i.."F._frame.frame.x", 0)
            setProperty("iconP"..i.."F._frame.frame.y", 0)
            setProperty("iconP"..i.."F._frame.frame.width", 150)
            setProperty("iconP"..i.."F._frame.frame.height", 150)

            addLuaSprite('iconP'..i..'F')
        end
    end
end

function goodNoteHit(i, d, ntype, sus)
    if ntype ~= 'GF Sing' or not gfSection then -- guh
        --if  then
            lastWasSus[1] = false
            singn = true

            setProperty('iconP1F.origin.x', rayman[d+1].x)
            setProperty('iconP1F.origin.y', rayman[d+1].y)
            
            setProperty('iconP1F.scale.x', directionScales[d+1].x)
            setProperty('iconP1F.scale.y', directionScales[d+1].y)

            runTimer('a', crochet/2500)

            lastHeldDirection[1] = d;
            lastWasSus[1] = sus;
            -- sus!
        --else gfSec(d) end
    else gfSec(d, sus) end
end


function opponentNoteHit(i, d, ntype, sus)
    if ntype ~= 'GF Sing' then -- idk man
        if not gfSection then
            singnOp = true
            lastWasSus[2] = false

            setProperty('iconP2F.origin.x', origins[d+1].x)
            setProperty('iconP2F.origin.y', origins[d+1].y)

            setProperty('iconP2F.scale.x', directionScales[d+1].x)
            setProperty('iconP2F.scale.y', directionScales[d+1].y)

            runTimer('aO', crochet/2500)

            lastHeldDirection[2] = d;
            lastWasSus[2] = sus;
            -- sus (again)!
        else gfSec(d, sus) end
    else gfSec(d, sus) end

end

function gfSec(ay, sus)
    lastWasSus[3] = false -- not sus
    singnG = true

    setProperty('iconP3F.origin.x', rayman[ay+1].x)
    setProperty('iconP3F.origin.y', rayman[ay+1].y)

    setProperty('iconP3F.scale.x', directionScales[ay+1].x)
    setProperty('iconP3F.scale.y', directionScales[ay+1].y)

    runTimer('aG', crochet/2500)

    lastHeldDirection[3] = ay;
    lastWasSus[3] = sus -- sus
end

function adjustIcon(icon, based)
    if not based then
        setProperty(icon .. "._frame.frame.x", 150)
        setProperty(icon .. "._frame.frame.y", 0)
        setProperty(icon .. "._frame.frame.width", 150)
        setProperty(icon .. "._frame.frame.height", 150)
    elseif based then
        setProperty(icon .. "._frame.frame.x", 0)
        setProperty(icon .. "._frame.frame.y", 0)
        setProperty(icon .. "._frame.frame.width", 150)
        setProperty(icon .. "._frame.frame.height", 150)
    end
end

function onTimerCompleted(t, l, ll)
    if t == 'a' then singn = false end
    if t == 'aO' then singnOp = false end
    if t == 'aG' then singnG = false end
end

function math.lerp(a, b, t)
    return (b - a) * t + a;
end

function fakeBoundTo(v, min, max)
    return math.max(min, math.min(max, v))
end
local icos = {'', '', ''}
local char = {'boyfriend', 'dad', 'gf', curIcon = {'', '', ''}}

local vOffset = 0
local normalHealthBar = false -- use normal sized healthbar
local endOfBars = false -- for normalHealthBar | the icons will be around the edges

local idleType = {'idle', 'idle', 'dance'} -- bf, dad, gf
local danced   = {false,  false,  false} -- for dance idles
local bopEvery = {1, 1, nil}  -- gf's icon is based on gfSpeed

local winWidth = 450 -- if image width is greater or equal to this, then there is a win icon
local hasWin = {false, false, false}

function onCreatePost()
    for i = 1, 3 do -- null icon check (only really for the gf icon, god help you if there's others)
        idleType[i] = getProperty(char[i]..'.danceIdle') and 'dance' or 'idle'
        icos[i] = getProperty(char[i]..'.healthIcon')
        char.curIcon[i] = icos[i]

        if icos[i] == char[i]..'.healthIcon' or icos[i] == '' then table.remove(icos, i) end
    end

    if downscroll then
        vOffset = (normalHealthBar and -40 or 50)
        setProperty('scoreTxt.y', getProperty('scoreTxt.y') + (normalHealthBar and 30 or 0))
    end

    setObjectOrder('healthBarBG', getObjectOrder('strumLineNotes') - 3)
    setObjectOrder('healthBar', getObjectOrder('strumLineNotes') - 2)

    setObjectOrder('timeBarBG', getObjectOrder('healthBar') + 1)
    setObjectOrder('timeBar', getObjectOrder('healthBar') + 2)
    setObjectOrder('timeTxt', getObjectOrder('healthBar') + 4)

    setProperty('healthBar.numDivisions', 1000)
    -- makes the icons, if gf and the dad's name are the exact same, then it hopefully skips making the 3rd icon
    for i = 1, #icos do
        local iconName = getIcon(icos[i])

        if i == 3 then
            if gfName == dadName and iconName == getIcon(icos[2]) then break end
        end

        makeAnimatedLuaSprite('iconP'..i..'F', nil, getProperty('healthBar.x'), getProperty('iconP1.y'))
        loadGraphic('iconP'..i..'F', iconName)
    
        hasWin[i] = getProperty('iconP'..i..'F.width') >= winWidth 
        
        loadGraphic('iconP'..i..'F', iconName, getProperty('iconP'..i..'F.width') / (hasWin[i] and 3 or 2))
        addAnimation('iconP'..i..'F', iconName, (hasWin[i] and {0, 1, 2} or {0, 1}), 0, true)
        setObjectCamera('iconP'..i..'F', 'hud')
        
        setProperty('iconP'..i..'F.antialiasing', not stringEndsWith(icos[i], '-pixel'))
        setObjectOrder('iconP'..i..'F', getObjectOrder('healthBar') + (i ~= 3 and i or 1))

        setProperty('iconP'..i..'F.flipX', (i == 1 or i == 3))

        addLuaSprite('iconP'..i..'F')
    end
end

local rayman = {
    {x = 150, y = 150},
    {x = 75,  y = 150}, 
    {x = 75,  y = 150}, 
    {x = 0,   y = 150}
}

local directionScales = {
    {x = 1.4, y = 1},
    {x = 1.4, y = 0.5},
    {x = 0.8, y = 1.4},
    {x = 1.4, y = 1}
}

local lockPosition = true -- when you miss
local missVelocities = {
    {x = -80, y = 20,   angle = -20},
    {x = 2,   y = 100,  angle = -50},
    {x = 2,   y = -200, angle = 50},
    {x = 80,  y = 20,   angle = 20}
}

function onCountdownTick(c)
    for i = 1, #icos do
        if c % 2 == 0 and idleType[i] == 'idle' then
            dance(i, idleType[i])
        else
            dance(i, idleType[i])
        end
    end
end

local ico1X = 0
local frm1, frm2
local normalBarOffset = 0
function onUpdatePost(elapsed)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    
    bopEvery[3] = getProperty('gfSpeed')
    normalBarOffset = (not normalHealthBar and -400 or 90)
    local missed = stringEndsWith(anim('boyfriend', 'name'), 'miss')

    for i = 1, #icos do
        if not anim(char[i], 'name'):find('sing') and getProperty(char[i]..'.holdTimer') ~= 0 then
            setProperty(char[i]..'.holdTimer', 0) -- for a stupid thing
        end

        if char.curIcon[i] ~= getProperty(char[i]..'.healthIcon') then
            char.curIcon[i] = getProperty(char[i]..'.healthIcon')
            updateIcon(i, char.curIcon[i])
        end

        if luaSpriteExists('iconP'..i..'F') then
            local isSinging = anim(char[i], 'name'):find('sing')
            if (getProperty(char[i]..'.holdTimer') == 0 and not isSinging) or (isSinging and anim(char[i], 'curFrame') > 1) or getProperty(char[i]..'.specialAnim') then
                local el = (1 - (elapsed * 9 * playbackRate))
                setProperty('iconP'..i..'F.scale.x', math.lerp(1, getProperty('iconP'..i..'F.scale.x'), bound(el, 0, 1)))
                setProperty('iconP'..i..'F.scale.y', math.lerp(1, getProperty('iconP'..i..'F.scale.y'), bound(el, 0, 1)))
            end
        end
    end

    if (getProperty('boyfriend.holdTimer') > (stepCrochet * 0.0011 * getProperty('boyfriend.singDuration')) / playbackRate) and not missed and bopEvery[1] > 1 then
        dance(1, idleType[1])
    end

    local hp = getProperty('healthBar.percent')
    if hp > 80 then 
        frm1, frm2 = (hasWin[1] and 2 or 0), 1
    elseif hp < 20 then 
        frm1, frm2 = 1, (hasWin[2] and 2 or 0)
    else 
        frm1, frm2 = 0, 0 
    end

    setProperty('iconP1F.animation.curAnim.curFrame', missed and 1 or frm1)
    setProperty('iconP2F.animation.curAnim.curFrame', frm2)

    if not missed and not lockPosition then resetP1() end

    ico1X = (screenWidth / 1.8)
    ico2X = (screenWidth / 3)
    if normalHealthBar and endOfBars then
        ico1X = (getProperty('healthBar.x') + getProperty('healthBar.width')) - (getProperty('iconP1F.width') / 2)
        ico2X = getProperty('healthBar.x') - (getProperty('iconP2F.width') / 2)
    end

    if lockPosition then 
        setProperty('iconP1F.x', ico1X) -- fuck it, we gettin specific now
        setProperty('iconP1F.y', (getProperty('healthBar.y') - normalBarOffset) - vOffset)
    end 

    setProperty('iconP2F.x', ico2X)
    setProperty('iconP2F.y', (getProperty('healthBar.y') - normalBarOffset) - vOffset)

    if icos[3] ~= nil and luaSpriteExists('iconP3F') then
        screenCenter('iconP3F', 'x')
        setProperty('iconP3F.y', (getProperty('healthBar.y') - (not normalHealthBar and -250 or 140)) - vOffset) 
        setProperty('iconP3F.alpha', getProperty('gf.alpha'))
        setProperty('iconP3F.visible', getProperty('gf.visible'))
    end

    if normalHealthBar then
        screenCenter('healthBar', 'x')
        screenCenter('healthBarBG', 'x')
    else
        setProperty('healthBarBG.visible', false)
        scaleObject('healthBar', 2.16 / getProperty('camHUD.zoom'), 67.8 / getProperty('camHUD.zoom'))
        screenCenter('healthBar', 'xy')
        screenCenter('healthBarBG', 'xy')
        setProperty('camGame.alpha', 0)
    end
end

function onBeatHit()
    for i = 1, #icos do
        if curBeat % bopEvery[i] == 0 then
            if not anim(char[i], 'name'):find('sing') then
                dance(i, idleType[i])
            end
        end
    end
end

function updateIcon(icon, newIcon)
    idleType[icon] = getProperty(char[icon]..'.danceIdle') and 'dance' or 'idle'

    if newIcon == char[icon]..'.healthIcon' then -- this might work, it might not
        table.remove(icos, icon) 
        return debugPrint('null icon! | iconP'..icon..'F')
    else icos[icon] = newIcon end
    
    local iconName = getIcon(icos[icon])
    --debugPrint(iconName)

    if icon == 3 then
        if gfName == dadName and iconName == getIcon(icos[2]) then return end
    end

    loadGraphic('iconP'..icon..'F', iconName)
    hasWin[icon] = getProperty('iconP'..icon..'F.width') >= winWidth 
 
    loadGraphic('iconP'..icon..'F', iconName, getProperty('iconP'..icon..'F.width') / (hasWin[icon] and 3 or 2))
    addAnimation('iconP'..icon..'F', iconName, (hasWin[icon] and {0, 1, 2} or {0, 1}), 0, true)

    setProperty('iconP'..icon..'F.antialiasing', not stringEndsWith(icos[icon], '-pixel'))
end

function goodNoteHit(i, d, t, s)
    if not getPropertyFromGroup('notes', i, 'gfNote') then
        if not lockPosition then resetP1() end
        sing(1, d)
    else gfSec(d) end
end


function opponentNoteHit(i, d, t, s)
    if not getPropertyFromGroup('notes', i, 'gfNote') then
        sing(2, d)
    else gfSec(d) end
end

function gfSec(ay)
    setProperty('iconP3F.angle', 0)
    sing(3, ay)
end

function sing(icon, d)
    setProperty('iconP'..icon..'F.origin.x', rayman[d+1].x)
    setProperty('iconP'..icon..'F.origin.y', rayman[d+1].y)

    setProperty('iconP'..icon..'F.scale.x', directionScales[d+1].x)
    setProperty('iconP'..icon..'F.scale.y', directionScales[d+1].y)
end

function anim(thing, toGet)
    return getProperty(thing..'.animation.curAnim.'..toGet)
end

function noteMiss(i, d)
    if getProperty('boyfriend.hasMissAnimations') then
        sing(1, d) -- to do the funny scaling
        if not lockPosition then resetP1() end

        lockPosition = false
        setProperty('iconP1F.color', getColorFromHex('666666'))
        
        setProperty('iconP1F.velocity.x', missVelocities[d+1].x)
        setProperty('iconP1F.velocity.y', missVelocities[d+1].y)
        setProperty('iconP1F.angularVelocity', missVelocities[d+1].angle)
        setProperty('iconP1F.acceleration.x', (d ~= 0 and (curBpm / 2) or -(curBpm / 2)))
        setProperty('iconP1F.acceleration.y', curBpm)
    end
end

function noteMissPress(d) noteMiss(nil, d) end

function onGameOver()
   setProperty('camGame.alpha', 1)
end

function math.lerp(a, b, t)
    return (b - a) * t + a;
end

function bound(v, min, max)
    return math.max(min, math.min(max, v))
end

function getIcon(icon) -- better icon getter
    local possibleNames = {'icon-', 'icons-', '', '-icons', '-icon'} -- possible prefixes and suffixes an icon can have
    local exists = false
    local iconAsset = 'icons/icon-face' -- default, no more haxe logo hopefully

    for j = 1, #possibleNames do
        iconAssetCheck = checkFileExists('assets/images/icons/' .. ((j > (#possibleNames / 2) and icon .. possibleNames[j] or possibleNames[j] .. icon) .. '.png'), true)
        iconModCheck = checkFileExists('images/icons/' .. ((j > (#possibleNames / 2) and icon .. possibleNames[j] or possibleNames[j] .. icon) .. '.png'))

        if iconAssetCheck or iconModCheck then 
            exists = true
            iconAsset = 'icons/' .. (j > (#possibleNames / 2) and icon .. possibleNames[j] or possibleNames[j] .. icon) 
            break
        end
    end
    return iconAsset, not exists and debugPrint('Can\'t find "'..icon..'"! icon-face used instead')
end

function dance(icon, type)
    if icon == 1 and not lockPosition then 
        lockPosition = true
        resetP1()
    end

    local oriX = 0
    if type == 'idle' then
        oriX = rayman[2].x
    elseif type == 'dance' then
        danced[icon] = not danced[icon]
        oriX = rayman[2].x + (icon == 3 and 0 or (not danced[icon] and -150 or 150))
    end
    setProperty('iconP'..icon..'F.origin.x', oriX)
    setProperty('iconP'..icon..'F.origin.y', rayman[2].y)

    if icon == 3 and type == 'dance' then
        local angle = danced[icon] and -20 or 20
        setProperty('iconP'..icon..'F.angle', angle)
        doTweenAngle('backTo'..icon, 'iconP'..icon..'F', 0, (crochet/500) / playbackRate, 'quartOut')
    end

    setProperty('iconP'..icon..'F.scale.x', 1.2)
    setProperty('iconP'..icon..'F.scale.y', 0.7)
end

function resetP1()
    local thingsToReset = {'angle', 'velocity.x', 'velocity.y', 'acceleration.x', 'acceleration.y', 'angularVelocity'}
    for _,reset in pairs(thingsToReset) do
        setProperty('iconP1F.'..reset, 0) 
    end

    setProperty('iconP1F.color', getColorFromHex('ffffff'))
    setProperty('iconP1F.x', ico1X)
    setProperty('iconP1F.y', (getProperty('healthBar.y') - normalBarOffset) - vOffset)
end
--configs

-- local character = getProperty('boyfriend.imageFile')  --put the name of the character's spritesheet here
--add mods/images behind characters if you are gonna use characters in the mods folder insteador 

--the offsets
-- boyfriend.offset.x/y
-- local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
-- local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y

local xleftoffs = 180 --X
local yleftoffs = 40 --Y

local xdownoffs = 200 --X
local ydownoffs = 80 --Y

local xupoffs = 215 --X
local yupoffs = 0 --Y

local xrightoffs = 215 --X
local yrightoffs = 40 --Y

--the poses in the xml

local idle = 'BF idle dance' --idle

local left = 'BF NOTE RIGHT0' --left

local down = 'BF NOTE UP0' --down

local up = 'BF NOTE DOWN0' --up

local right = 'BF NOTE LEFT0' --right

--miss poses (optional)

local togglemisseanims = false --set this to true if you want miss animations, false to not


local leftmiss = 'BF NOTE LEFT' --left miss

local downmiss = 'BF NOTE DOWN' --down miss

local upmiss = 'BF NOTE UP' --up miss

local rightmiss = 'BF NOTE RIGHT' --right miss

--mislacious

local fps = 24 --24 is the default fps

--the cool script by @Betopia#5677 (and some edits by me, @tek no#6260) on discord

local idling = true
function onCreatePost()
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    local character = getProperty('boyfriend.imageFile') 

    if character == nil then local character = 'characters/BOYFRIEND' end

    makeAnimatedLuaSprite('player3', character, 0, 0)
    setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
    setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
    addAnimationByPrefix('player3', 'idle', idle, fps, false)

    --regular animations

    addAnimationByPrefix('player3', 'left', left, fps, false) 
    addAnimationByPrefix('player3', 'down', down, fps, false)
    addAnimationByPrefix('player3', 'up', up, fps, false) 
    addAnimationByPrefix('player3', 'right', right, fps, false)

    --miss animations

    addAnimationByPrefix('player3', 'leftmiss', leftmiss, fps, false) 
    addAnimationByPrefix('player3', 'downmiss', downmiss, fps, false)
    addAnimationByPrefix('player3', 'upmiss', upmiss, fps, false) 
    addAnimationByPrefix('player3', 'rightmiss', rightmiss, fps, false)

    addLuaSprite('player3', true)
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    idling = false

    if noteData == 0 then
        objectPlayAnimation('player3', 'left', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xleftoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yleftoffs)
    end

    if noteData == 1 then
        objectPlayAnimation('player3', 'down', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xdownoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- ydownoffs)
    end

    if noteData == 2 then
        objectPlayAnimation('player3', 'up', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xupoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yupoffs)
    end

    if noteData == 3 then
        objectPlayAnimation('player3', 'right', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xrightoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yrightoffs)
    end

    runTimer('idle-transition', 1)
end

function noteMiss(id, noteData, noteType, isSustainNote)
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    idling = false
    if togglemisseanims == true then
    if noteData == 0 then
        objectPlayAnimation('player3', 'leftmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
    end

    if noteData == 1 then
        objectPlayAnimation('player3', 'downmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
    end

    if noteData == 2 then
        objectPlayAnimation('player3', 'upmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
    end

    if noteData == 3 then
        objectPlayAnimation('player3', 'rightmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
    end

    runTimer('idle-transition', 1)

end
end

function onCountdownTick(c)
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    if idling and c % 2 == 0 and not string.find(string.lower(getProperty('player3.animation.curAnim.name')), 'left' or 'down' or 'up' or 'right')then
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
        objectPlayAnimation('player3', 'idle')
        idling = true
    end
end
function onBeatHit()
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    if idling and curBeat % 2 == 0 and not string.find(string.lower(getProperty('player3.animation.curAnim.name')), 'left' or 'down' or 'up' or 'right') then
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
        objectPlayAnimation('player3', 'idle')
        idling = true
    end
end
function onTimerCompleted(t, l, ll)
    local xidleoffs = getProperty('boyfriend.offset.x') or 200 --X
    local yidleoffs = getProperty('boyfriend.offset.y') or 40 --Y
    if t == 'idle-transition' then
        idling = true
        setProperty('player3.x', getProperty('boyfriend.x')) -- xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y')) -- yidleoffs)
        objectPlayAnimation('player3', 'idle')
    end
end
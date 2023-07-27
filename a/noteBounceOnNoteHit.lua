local Credits = { -- [[ ik wierd way to do this... I was bored ok? ]] --
	Puro = 'Puro: Script Creator', -- '!Puro!#0001'
	ISH52806 = 'ImaginationSuperHero52806: Basically helped overhaul the entire script', -- 'ImaginationSuperHero52806#2485'
}
--[[Settings... cause why not?]]--

local prefs = {
    enableScript = true,            -- idk I just put this here.
	move = 40,                      -- How much the note should move (if a pixel stage its divided by 2)?
	shouldPixelMove = true,         -- Should pixel have its own stuff?
    opponentHit = true,             -- Should the opponent's move too?
	tween = 'circOut',              -- Pick a tween ig?
	tweenPixel = 'sineOut',         -- Pixel if you want to.
	tweenHeld = 'quadIn',           -- When it returns after being held (doesn't work right now), also no pixel var cause lazy.
	wierdStupidKindaDumb = true,    -- Basically a wierd Countdown thing WIP added.
	onSickHit = true                -- When on when you don't get a sick the tween doesn't play!
}

--[[For new coders I recommend you don't touch the code below!]]--
local strumLineY
local moveAmount
local durationAmount
local easeType
local tweenBackType
local isPixelStage
function onCreatePost()
    HoriScroll = ((HoriScroll == nil or HoriScroll == '') and downscroll)
    isPixelStage = getPropertyFromClass('PlayState', 'isPixelStage')

    if not prefs.enableScript then close(true) end
end

function onUpdatePost(elapsed)
    for i = 0, 3 do
        for ii = 1, 2 do
            local names = {'Player', 'Opponent'}
            strumLineY = _G['default' .. names[ii] .. 'StrumY' .. i]
        end
    end
	tweenBackType = prefs.tweenHeld
    moveAmount = (HoriScroll == true and (isPixelStage and (prefs.move / 2) or prefs.move) or (isPixelStage and (-prefs.move / 2) or -prefs.move))
    durationAmount = (scrollSpeed / curBpm) * (HoriScroll == false and (-moveAmount / 5) or (moveAmount / 5))
    easeType = (isPixelStage and prefs.tweenPixel or prefs.tween)
    tweenBackType = prefs.tweenHeld
    --debugPrint('Move Amount: '..moveAmount, ', Duration Amount: '..durationAmount, ', Ease Type: '..easeType)
end

function onCountdownTick(counter)
    if prefs.wierdStupidKindaDumb then
    	for i = 0, 3 do
        	if counter == 3 then
            	noteTweenY('movePlayer' .. i, i + 4, strumLineY + (moveAmount / 2), durationAmount, easeType)
            	noteTweenY('moveOpponent' .. i, i, strumLineY + (prefs.opponentHit and (moveAmount / 2) or (moveAmount * 0)), durationAmount, easeType)
        	elseif counter == 4 then
            	runTimer('returnPlayer' .. i, durationAmount, 1)
            	runTimer('returnOpponent' .. i, durationAmount, 1)
        	end
    	end
    end
end

local ratingSet
local playerSustain
function goodNoteHit(id, noteData, noteType, isSustainNote)
    playerSustain = isSustainNote
    if not isSustainNote then
        ratingSet = getPropertyFromGroup('notes', id, 'rating')
        -- debugPrint(ratingSet)
    end
    for i = 0, 3 do
        if prefs.onSickHit and ratingSet == 'sick' then
            if noteData == i then
                cancelTween('movePlayer' .. i)
                noteTweenY('movePlayer' .. i, i + 4, strumLineY + moveAmount, durationAmount, easeType)
                runTimer('returnPlayer' .. i, durationAmount, 1)
            end
        end
    end
end

local ratingSetOp
local opponentSustain
function opponentNoteHit(id, noteData, noteType, isSustainNote)
    opponentSustain = isSustainNote
    if not isSustainNote then
        ratingSetOp = getPropertyFromGroup('notes', id, 'rating')
        -- debugPrint(ratingSet)
    end
    for i = 0, 3 do
        if prefs.opponentHit --[[and (prefs.onSickHit and ratingSetOp == 'sick')]] then
            if noteData == i then
                cancelTween('moveOpponent' .. i)
                noteTweenY('moveOpponent' .. i, i, strumLineY + moveAmount, durationAmount, easeType)
                runTimer('returnOpponent' .. i, durationAmount, 1)
            end
        end
    end
end

function onTimerCompleted(tag, loop, loopsLeft)
    for i = 0, 3 do
        if tag == 'returnPlayer' .. i then
            noteTweenY('movePlayer' .. i, i + 4, strumLineY, (playerSustain and (durationAmount * 5) or durationAmount), (playerSustain and tweenBackType or easeType))
        end
        if tag == 'returnOpponent' .. i then
            noteTweenY('moveOpponent' .. i, i, strumLineY, (opponentSustain and (durationAmount * 5) or durationAmount), (opponentSustain and tweenBackType or easeType))
        end
    end
end
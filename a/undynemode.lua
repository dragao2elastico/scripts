
-- MADE BY iwanttokommitdead! please credit if used or modified, thank you!
-- ... or dont, (i dont really mind) but it would be so awesome
-- https://gamebanana.com/members/2028555

-- STILL A WIP AS OF JUNE 03


function onCreate()

	-- black overlay to darken the surroundings
	makeLuaSprite('black', 'undynemode/black', 0, 0)
	setObjectCamera('black', 'hud')
	doTweenAlpha('blackalpha', 'black', 0, 0.1, 'linear')
	screenCenter('black', 0)	
	addLuaSprite('black', false)

	-- makes the soul in the middle
	makeLuaSprite('soul', 'undynemode/soul', 0, 0)
	doTweenColor('soulcol', 'soul', '00a80e', 0.1, 'linear')
	setObjectCamera('soul', 'hud')
	scaleObject('soul', 0.08, 0.08)
	screenCenter('soul', 0)	
	addLuaSprite('soul', true)

	-- circle
	makeLuaSprite('circle', 'undynemode/circle', 0, 0)
	setObjectCamera('circle', 'hud')
	scaleObject('circle', 2, 2)
	doTweenAlpha('circlealpha', 'circle', 0.5, 1, 'linear')
	screenCenter('circle', 0)	
	addLuaSprite('circle', true)

	-- shield thing
	makeLuaSprite('shield', 'undynemode/shield', 0, 0)
	setObjectCamera('shield', 'hud')
	scaleObject('shield', 0.2, 0.25)
	screenCenter('shield', 0)	
	doTweenColor('shieldcol', 'shield', '0048ff', 0.1, 'linear')
	addLuaSprite('shield', true)

	-- side health and score move
	setProperty('scoreTxt.y', 20)
	setTextFont('scoreTxt', 'determination.ttf')
	setProperty('healthBar.angle', 90)
	setProperty('healthBar.x', 930)
	setProperty('healthBar.y', 370)

	-- bye bye dad note
	setPropertyFromGroup('strumLineNotes', 0, 'alpha', 0)
	setPropertyFromGroup('strumLineNotes', 1, 'alpha', 0)
	setPropertyFromGroup('strumLineNotes', 2, 'alpha', 0)
	setPropertyFromGroup('strumLineNotes', 3, 'alpha', 0)

	noteTweenAlpha('dadleft', 0, 0, 0.1, 'linear')
	noteTweenAlpha('daddown', 1, 0, 0.1, 'linear')
	noteTweenAlpha('dadup', 2, 0, 0.1, 'linear')
	noteTweenAlpha('dadright', 3, 0, 0.1, 'linear')
end

function onKeyPress(direction)
	if direction == 0 then
		playAnim("boyfriend", "singLEFT", true);
		doTweenAngle('sleft', 'shield', -90, 0.1, 'easeOut')
		doTweenColor('shieldcolarrows', 'shield', 'ff00d0', 0.01, 'linear')
	elseif direction == 1 then
		playAnim("boyfriend", "singDOWN", true);
		doTweenAngle('sdown', 'shield', 180, 0.1, 'easeOut')
		doTweenColor('shieldcolarrows', 'shield', '00ddff', 0.01, 'linear')
	elseif direction == 2 then
		playAnim("boyfriend", "singUP", true);
		doTweenAngle('sup', 'shield', 0, 0.1, 'easeOut')
		doTweenColor('shieldcolarrows', 'shield', '00ff3c', 0.01, 'linear')
	else
		playAnim("boyfriend", "singRIGHT", true);
		doTweenAngle('sright', 'shield', 90, 0.1, 'easeOut')
		doTweenColor('shieldcolarrows', 'shield', 'ff0000', 0.01, 'linear')
	end

	function onTweenCompleted(tag)
		-- small shield colour delay
		runTimer('shieldcoltimer', 0.3, 1)
	end
	
	function onTimerCompleted(shieldcoltimer)
		-- turns shield back to blue after timer done
		doTweenColor('shieldcolarrows', 'shield', '0048ff', 0.2, 'easeOut')
	end
	-- insert "huh?" sound effect here
end




function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	playSound('ding', 0.3)
end

function noteMiss()
    missSound = string.format('uthurt%i', 1);
    playSound(missSound, 0.5);
end

function onBeatHit()
	if curBeat % 2 == 0 then
		doTweenColor('soulidle', 'soul', 'ffffff', 0.05, 'linear')
	end

	if curBeat % 4 == 0 then
		doTweenColor('soulidle', 'soul', '00a80e', 0.05, 'linear')
	end
end

function onStepHit()
	if curStep == 1 then
		triggerEvent('Add Camera Zoom', '0', '-0.3')
		doTweenAlpha('blackalpha1', 'black', 0.5, 1, 'linear')
	end
end



function onCreatePost() 
	-- hides the time bar and the health icons
	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeTxt.visible', false)
    setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
end

function onSongStart()
	-- left
	noteTweenX('bfleftx', 4, 500, 1, 'sineInOut');
	noteTweenY('bflefty', 4, 308, 1, 'sineInOut');
	noteTweenDirection('bfleftrotate', 4, 360, 1, 'sineInOut')
   	noteTweenAngle('bfleftangle', 4, 360, 1, 'elasticOut')
	-- down
	noteTweenX('bfdownx', 5, 585, 1, 'sineInOut');
	noteTweenY('bfdowny', 5, 398, 1, 'sineInOut');
	noteTweenDirection('bfdownrotate', 5, 270, 1, 'sineInOut')
    noteTweenAngle('bfdownangle', 5, 360, 1, 'elasticOut')
	-- up
	noteTweenX('bfupx', 6, 585, 1, 'sineInOut');
	noteTweenY('bfupy', 6, 228, 1, 'sineInOut');
	noteTweenAngle('bfupangle', 6, 360, 1, 'elasticOut')
	-- right
	noteTweenX('bfrightx', 7, 670, 1, 'sineInOut');
	noteTweenY('bfrighty', 7, 308, 1, 'sineInOut');
	noteTweenDirection('bfrightrotate', 7, 180, 1, 'sineInOut')
    noteTweenAngle('bfrightangle', 7, 360, 1, 'elasticOut')
end

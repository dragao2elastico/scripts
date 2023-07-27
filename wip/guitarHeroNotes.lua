
local DADG = 'no'
					--BF Has Cool Combo Stuff, Dad Does Not 'Cuz I Couldn't Track Dad Combo Lol
local BFG = 'yes'

------------------------------------------------------------------------------------------------------------
--DONT TOUCH THIS!!!                                                                                  Plz?

function onCreate()
	precacheImage('starLighting')
	
	makeAnimatedLuaSprite('bfflames1', 'starLightning', 575, 5)
	setObjectCamera('bfflames1', 'camHUD')
	addAnimationByPrefix('bfflames1', 'flames', 'STAR LIGHTNING', 24, true)
	
	makeAnimatedLuaSprite('bfflames2', 'starLightning', 575, 5)
	setObjectCamera('bfflames2', 'camHUD')
	addAnimationByPrefix('bfflames2', 'flames', 'STAR LIGHTNING', 24, true)
	
	makeAnimatedLuaSprite('bfflames3', 'starLightning', 575, 5)
	setObjectCamera('bfflames3', 'camHUD')
	addAnimationByPrefix('bfflames3', 'flames', 'STAR LIGHTNING', 24, true)
	
	makeAnimatedLuaSprite('bfflames4', 'starLightning', 575, 5)
	setObjectCamera('bfflames4', 'camHUD')
	addAnimationByPrefix('bfflames4', 'flames', 'STAR LIGHTNING', 24, true)
	
		addLuaSprite('bfflames1', false)
		addLuaSprite('bfflames2', false)
		addLuaSprite('bfflames3', false)
		addLuaSprite('bfflames4', false)
		
		setProperty('bfflames1.visible', false)
		setProperty('bfflames2.visible', false)
		setProperty('bfflames3.visible', false)
		setProperty('bfflames4.visible', false)
	
	makeLuaSprite('bfbeat1', 'beatline', 825, -150)
	setObjectCamera('bfbeat1', 'camHUD')
	addLuaSprite('bfbeat1', true)
	scaleObject('bfbeat1', 0.25, 0.25)
	
	makeLuaSprite('bfbeat2', 'beatline', 825, -150)
	setObjectCamera('bfbeat2', 'camHUD')
	addLuaSprite('bfbeat2', true)
	scaleObject('bfbeat2', 0.25, 0.25)
	
	makeLuaSprite('dadbeat1', 'beatline', 200, -150)
	setObjectCamera('dadbeat1', 'camHUD')
	addLuaSprite('dadbeat1', true)
	scaleObject('dadbeat1', 0.25, 0.25)
	
	makeLuaSprite('dadbeat2', 'beatline', 200, -150)
	setObjectCamera('dadbeat2', 'camHUD')
	addLuaSprite('dadbeat2', true)
	scaleObject('dadbeat2', 0.25, 0.25)

end

function onCreatePost()

	if DADG == 'yes' then
		for i = 0, getProperty('opponentStrums.length')-1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_guitar');
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Opponent Sing' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Special Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_guitar');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'guitarSplashes');
			end
		end
		makeLuaSprite('dadhighway', 'fretboard', 75, 55)
		setObjectCamera('dadhighway', 'camHUD')
		scaleObject('dadhighway', 0.5, 0.5)
		addLuaSprite('dadhighway', false)
		
		setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
		setPropertyFromGroup('opponentStrums', 1, 'downScroll', true)
		setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
		setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)
		setPropertyFromGroup('opponentStrums', 0, 'y', 625)
		setPropertyFromGroup('opponentStrums', 1, 'y', 625)
		setPropertyFromGroup('opponentStrums', 2, 'y', 625)
		setPropertyFromGroup('opponentStrums', 3, 'y', 625)
		
		setPropertyFromGroup("strumLineNotes", 0, "x", 75)
		setPropertyFromGroup("strumLineNotes", 1, "x", 202)
		setPropertyFromGroup("strumLineNotes", 2, "x", 324)
		setPropertyFromGroup("strumLineNotes", 3, "x", 445)
		
		setPropertyFromGroup("strumLineNotes", 0, "direction", 97.5)
		setPropertyFromGroup("strumLineNotes", 1, "direction", 92.5)
		setPropertyFromGroup("strumLineNotes", 2, "direction", 87.5)
		setPropertyFromGroup("strumLineNotes", 3, "direction", 85)
	end
	
	if BFG == 'yes' then
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_guitar');
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Opponent Sing' or getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Special Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_guitar');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'guitarSplashes');
			end
		end
		makeLuaSprite('bfhighway', 'fretboard', 700, 55)
		setObjectCamera('bfhighway', 'camHUD')
		scaleObject('bfhighway', 0.5, 0.5)
		addLuaSprite('bfhighway', false)
		
		setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
		setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
		setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
		setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
		setPropertyFromGroup('playerStrums', 0, 'y', 625)
		setPropertyFromGroup('playerStrums', 1, 'y', 625)
		setPropertyFromGroup('playerStrums', 2, 'y', 625)
		setPropertyFromGroup('playerStrums', 3, 'y', 625)
		
		setPropertyFromGroup("strumLineNotes", 4, "x", 700)
		setPropertyFromGroup("strumLineNotes", 5, "x", 827)
		setPropertyFromGroup("strumLineNotes", 6, "x", 949)
		setPropertyFromGroup("strumLineNotes", 7, "x", 1070)

		setPropertyFromGroup("strumLineNotes", 4, "direction", 97.5)
		setPropertyFromGroup("strumLineNotes", 5, "direction", 92.5)
		setPropertyFromGroup("strumLineNotes", 6, "direction", 87.5)
		setPropertyFromGroup("strumLineNotes", 7, "direction", 85)
	end
end

function onUpdatePost()
    songPos = getSongPosition()
    notesLenght = getProperty("notes.length")
    for i = 0,notesLenght,1 do
        songPos = getSongPosition()
        setPropertyFromGroup("notes",i,"angle", 360)
    end
	if BFG == 'yes' then
			if getProperty('combo') == 25 then
				setProperty('bfflames1.visible', true)
				scaleObject('bfflames1', 1, 1)
				doTweenColor('flames1ColorTween', 'bfflames1', '0x40FF7300', 0.01, 'linear')
				runTimer('bfflames1', 0.01, 1)
			end
			if getProperty('combo') == 50 then
				doTweenAlpha('bfflames1TweenA', 'bfflames1', 0, 0.25, 'easeOut')
				setProperty('bfflames2.visible', true)
				scaleObject('bfflames2', 1, 1)
				doTweenColor('flames2ColorTween', 'bfflames2', '0x80FF3100', 0.01, 'linear')
				runTimer('bfflames2', 0.01, 1)
			end
			if getProperty('combo') == 75 then
				doTweenAlpha('bfflames2TweenA', 'bfflames2', 0, 0.25, 'easeOut')
				setProperty('bfflames3.visible', true)
				scaleObject('bfflames3', 1, 1)
				doTweenColor('flames3ColorTween', 'bfflames3', '0x808000FF', 0.01, 'linear')
				runTimer('bfflames3', 0.01, 1)
			end
			if getProperty('combo') == 100 then
				doTweenAlpha('bfflames3TweenA', 'bfflames3', 0, 0.25, 'easeOut')
				setProperty('bfflames4.visible', true)
				scaleObject('bfflames4', 1, 1)
				doTweenColor('flames4ColorTween', 'bfflames4', '0xBF00FFFF', 0.01, 'linear')
				runTimer('bfflames4', 0.01, 1)
			end
		setProperty('songSpeed', curBpm/60)
	end

	if DADG == 'yes' then
		setProperty('songSpeed', curBpm/60)
	end

		setObjectOrder('dadhighway', 1)
		setObjectOrder('bfflames1', 2)
		setObjectOrder('bfflames2', 3)
		setObjectOrder('bfflames3', 4)
		setObjectOrder('bfflames4', 5)
		setObjectOrder('bfhighway', 6)
		setObjectOrder('bfbeat1', 7)
		setObjectOrder('bfbeat2', 8)
		setObjectOrder('dadbeat1', 9)
		setObjectOrder('dadbeat2', 10)
end

function onBeatHit()
	if BFG == 'yes' then
		if curBeat % 2 == 0 then
		setProperty('bfbeat1.y', -150)
		doTweenY('bfbeat1YTween', 'bfbeat1', 645, 120/curBpm, 'linear')
		end
		if curBeat % 2 == 1 then
		setProperty('bfbeat2.y', -150)
		doTweenY('bfbeat2YTween', 'bfbeat2', 645, 120/curBpm, 'linear')
		end
	end
	if DADG == 'yes' then
		if curBeat % 2 == 0 then
		setProperty('dadbeat1.y', -150)
		doTweenY('dadbeat1YTween', 'dadbeat1', 645, 120/curBpm, 'linear')
		end
		if curBeat % 2 == 1 then
		setProperty('dadbeat2.y', -150)
		doTweenY('dadbeat2YTween', 'dadbeat2', 645, 120/curBpm, 'linear')
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'bfflames1' then
		objectPlayAnimation('bfflames1', 'flames', true)
	end
	if tag == 'bfflames2' then
		objectPlayAnimation('bfflames2', 'flames', true)
	end
	if tag == 'bfflames3' then
		objectPlayAnimation('bfflames3', 'flames', true)
	end
	if tag == 'bfflames4' then
		objectPlayAnimation('bfflames4', 'flames', true)
	end
end

function noteMiss()
	if BFG == 'yes' then
		setProperty('combo', 0)
		doTweenAlpha('bfflames1TweenA', 'bfflames1', 0, 0.5, 'easeOut')
		doTweenAlpha('bfflames2TweenA', 'bfflames2', 0, 0.5, 'easeOut')
		doTweenAlpha('bfflames3TweenA', 'bfflames3', 0, 0.5, 'easeOut')
		doTweenAlpha('bfflames4TweenA', 'bfflames4', 0, 0.5, 'easeOut')
	end
end
--made by pedrohiperiq,if you steal this fuck you >:(

--configurate shit here
plushOffset = -100
captionOffset = -100
soundVolume = 2

caption = true
whitebg = true

hidehudplushed = true
hidedadplushed = true
hidegfplushed = true

--please put this in '' or it will break
deathSound = 'onelastpicandiwillbegone' 

--do not touch,or it will break fool (expect the character part in line 30 and on)
absolutelyplushed = false

function onCreatePost()

	makeLuaSprite('whitebg', '', 0, 0)
	setScrollFactor('whitebg', 0, 0)
	makeGraphic('whitebg', 3840, 2160, 'ffffff')
	addLuaSprite('whitebg', false)
	setProperty('whitebg.alpha', 0)
	screenCenter('whitebg', 'xy')

	if getPropertyFromClass('PlayState', 'isPixelStage') then
		makeLuaSprite('gayfurrypornbutpixel', 'plushs/plushbutPixel', getProperty('boyfriend.x') - 100, getProperty('boyfriend.y') + plushOffset)
		addLuaSprite('gayfurrypornbutpixel', true)
		doTweenAlpha('gaypornpixel', 'gayfurrypornbutpixel', 0, 0.1, 'linear')

	else if getProperty(boyfriendName) == 'bf' or getProperty(boyfriendName) == 'bf-car' then

		makeLuaSprite('gayfurryporn', 'plushs/plush', getProperty('boyfriend.x'), getProperty('boyfriend.y') + plushOffset)
		addLuaSprite('gayfurryporn', true)
		doTweenAlpha('gayporn', 'gayfurryporn', 0, 0.1, 'linear')

	else if getProperty(boyfriendName) == 'pico' or getProperty(boyfriendName) == 'pico-player' then

		makeLuaSprite('gayfurryporn', 'plushs/plushBico', getProperty('boyfriend.x'), getProperty('boyfriend.y') + plushOffset)
		addLuaSprite('gayfurryporn', true)
		doTweenAlpha('gayporn', 'gayfurryporn', 0, 0.1, 'linear')
	else if getProperty(boyfriendName) == 'tankman' or getProperty(boyfriendName) == 'tankman-player' then

		makeLuaSprite('gayfurryporn', 'plushs/plushTankman', getProperty('boyfriend.x'), getProperty('boyfriend.y') + plushOffset + 100)
		addLuaSprite('gayfurryporn', true)
		doTweenAlpha('gayporn', 'gayfurryporn', 0, 0.1, 'linear')

	--else if getProperty(boyfriendName) == 'character you want' then
	--makeLuaSprite('gayfurryporn', 'plushs/spriteonplushs', getProperty('boyfriend.x'), getProperty('boyfriend.y') + plushOffset + 100)
	--addLuaSprite('gayfurryporn', true)
	--doTweenAlpha('gayporn', 'gayfurryporn', 0, 0.1, 'linear')
	--end



	--tutorial start

	--take of the '--' of the 5 lines and change "character you want" to the json file
	--change the "spriteonplushs" to the sprite in the plush file with the '' on all of then
	--don't delete the '--' from these lines or it will break (probably) just delete the entirety of this tutorial

	--tutorial end

	else
		makeLuaSprite('gayfurryporn', 'plushs/cartman', getProperty('boyfriend.x'), getProperty('boyfriend.y') + plushOffset + 100)
		addLuaSprite('gayfurryporn', true)
		doTweenAlpha('gayporn', 'gayfurryporn', 0, 0.1, 'linear')
	end
	end
	end
end
end

function onUpdate()
	if absolutelyplushed == true then
		setProperty('vocals.volume', 0)
		setSoundVolume(nil, 0)
		setPropertyFromClass('Conductor', 'songPosition', -10)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
		absolutelyplushed = true
		if getPropertyFromClass('PlayState', 'isPixelStage') then

		doTweenAlpha('gaypornpixel', 'gayfurrypornbutpixel', 1, 2, 'linear')
		doTweenAlpha('boyfriend', 'boyfriend', 0, 2, 'linear')

		else
		doTweenAlpha('gayporn', 'gayfurryporn', 1, 2, 'linear')
		doTweenAlpha('boyfriend', 'boyfriend', 0, 2, 'linear')

		if caption == true then
		makeLuaSprite('captionPlush', 'plushs/caption', getProperty('gayfurryporn.x'), getProperty('gayfurryporn.y') + captionOffset)
		doTweenAlpha('captionPlushporn', 'captionPlush', 0, 0.1, 'linear')
		addLuaSprite('captionPlush', true)
		end
	end

		playSound(deathSound ,soundVolume)
		cameraShake('camGame', 0.015, 0.25);
		runTimer('endSong', 13, 1)

		doTweenAlpha('captionPlushpornbutgaynow', 'captionPlush', 1, 5, 'linear')

		if caption == true then
		doTweenAlpha('whitebgwhynot', 'whitebg', 1, 2, 'linear')
		end
		if hidegfplushed == true then
		doTweenAlpha('gf', 'gf', 0, 2, 'linear')
		end
		if hidedadplushed == true then
		doTweenAlpha('dad', 'dad', 0, 2, 'linear')
		end
		if hidehudplushed == true then
		doTweenAlpha('camHUD', 'camHUD', 0, 2, 'linear')
	end
end

function onTimerCompleted(t)
	if t == 'endSong' then
		endSong()
end
end
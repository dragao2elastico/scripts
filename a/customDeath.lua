local restart = true
tweens = {
	['extraModifiersX2'] = function() 
		removeLuaSprite('youDied')
		removeLuaSprite('songTxt')
		removeLuaSprite('timeDied')
		removeLuaSprite('songDetails')
		removeLuaSprite('exit')
		removeLuaSprite('extraModifiersSection')
		removeLuaSprite('extraModifiers')
		if not restart then endSong() end 
	end
}
sounds = {
	['micDrop'] = function()
		playSound(getPropertyFromClass('GameOverSubstate', 'loopSoundName'), 0, 'deathMusic') 
		soundFadeIn('deathMusic', 2)
	end,
	['deathMusic'] = function() playSound(getPropertyFromClass('GameOverSubstate', 'loopSoundName'), 1, 'deathMusic') end,
	['confirm'] = function() if restart then restartSong() end end
}

substatesCreate = {
	['customDeath'] = function()
		setPropertyFromClass('PlayState', 'deathCounter', getPropertyFromClass('PlayState', 'deathCounter') + 1)
		playSound(getPropertyFromClass('GameOverSubstate', 'deathSoundName'), 1, 'micDrop')
		makeLuaSprite('deathBg')
		makeGraphic('deathBg', screenWidth, screenHeight, '000000')
		addLuaSprite('deathBg')
		setObjectCamera('deathBg', 'other')
		setProperty('deathBg.alpha', 0)
		doTweenAlpha('deathBgAlpha', 'deathBg', 1, 1, 'sineInOut')

		makeLuaText('youDiedTxt', 'You Died!', 0, 10, -100)
		setTextSize('youDiedTxt', 60)
		setTextColor('youDiedTxt', 'FF4444')
		addLuaText('youDiedTxt')
		setObjectCamera('youDiedTxt', 'other')

		makeLuaText('songTxt', 'Song: ' .. songName, 0, 10, -90)
		setTextSize('songTxt', 30)
		setTextColor('songTxt', 'E4DAC7')
		addLuaText('songTxt')
		setObjectCamera('songTxt', 'other')

		makeLuaText('timeDied', formatTime(math.abs(getSongPosition()) - noteOffset) .. ' / ' .. formatTime(songLength), 0, 10, -80)
		setTextSize('timeDied', 30)
		addLuaText('timeDied')
		setObjectCamera('timeDied', 'other')

		makeLuaText('songDetails',
		string.format('Sicks: %s\nGoods: %s\nBads: %s\nShits: %s\nMisses: %s\n\nClear Type: %s\nRanking: %s\n\nScore: %s\nAccuracy: %s', 
		getProperty('sicks'), getProperty('goods'), getProperty('bads'), getProperty('shits'), misses, ratingFC, ratingName, score, round(rating * 100, 2) .. '%'),
		0, -400, 0)
		setTextSize('songDetails', 30)
		setTextAlignment('songDetails', 'left')
		addLuaText('songDetails')
		screenCenter('songDetails', 'y')
		setObjectCamera('songDetails', 'other')

		makeLuaText('exit', 'Press ENTER to retry or ESCAPE to go back.', 0, 10, screenHeight)
		setTextSize('exit', 35)
		setTextColor('exit', 'E4DAC7')
		addLuaText('exit')
		setObjectCamera('exit', 'other')

		makeLuaText('extraModifiersSection', 'Extra Modifiers:', 0, screenWidth - 465, -50)
		setTextSize('extraModifiersSection', 50)
		setTextColor('extraModifiersSection', 'E4DAC7')
		addLuaText('extraModifiersSection')
		setTextAlignment('extraModifiersSection', 'right')
		setObjectCamera('extraModifiersSection', 'other')

		makeLuaText('extraModifiers', 
		'Playback Rate: ' .. playbackRate .. 'x\n\n' .. 
		'Scroll Speed: (' .. string.capitalize(getGameplaySetting('scrolltype', "'multiplicative'")) .. ' : ' .. getGameplaySetting('scrollspeed', 1) .. ')\n\n' .. 
		'Sick Window: ' .. getPropertyFromClass('ClientPrefs', 'sickWindow') .. 'ms\n' .. 
		'Good Window: ' .. getPropertyFromClass('ClientPrefs', 'goodWindow') .. 'ms\n' ..
		'Bad Window: ' .. getPropertyFromClass('ClientPrefs', 'badWindow') .. 'ms\n' .. 
		'Shit Window: ' .. round((getPropertyFromClass('ClientPrefs', 'safeFrames') / 60) * 1000, 2) .. 'ms', 
		1000, 1400, getProperty('extraModifiersSection.y') + 110)
		setTextSize('extraModifiers', 30)
		setTextAlignment('extraModifiers', 'right')
		addLuaText('extraModifiers')
		setObjectCamera('extraModifiers', 'other')

		doTweenY('youDiedY', 'youDiedTxt', 5, 1, 'smootherstepinout')
		doTweenY('songTxtY', 'songTxt', 70, 1, 'smootherstepinout')
		doTweenY('timeDiedY', 'timeDied', 105, 1, 'smootherstepinout')
		doTweenX('songDetailsX', 'songDetails', 10, 1, 'smootherstepinout')
		doTweenY('exitY', 'exit', screenHeight - 45, 1, 'smootherstepinout')
		doTweenY('extraModifiersSectionY', 'extraModifiersSection', 5, 1, 'smootherstepinout')
		doTweenX('extraModifiersX', 'extraModifiers', 270, 1, 'smootherstepinout')
	end
}

local substatesUpdate = {
	['customDeath'] = function()
		if keyboardJustPressed('ENTER') or keyboardJustPressed('ESCAPE') then
			if keyboardJustPressed('ENTER') then restart = true end
			if not luaSoundExists('confirm') then closeDeathState() end
		end
	end
}

local died = false
function onGameOver()
	if died then return Function_Stop end
	openCustomSubstate('customDeath', true)
	died = true
	return Function_Stop
end

function closeDeathState()
	playSound(getPropertyFromClass('GameOverSubstate', 'endSoundName'), 1, 'confirm')
	soundFadeOut('deathMusic', 0.5)
	doTweenY('youDiedY2', 'youDiedTxt', -100, 1, 'smootherstepinout')
	doTweenY('songTxtY2', 'songTxt', -90, 1, 'smootherstepinout')
	doTweenY('timeDiedY2', 'timeDied', -80, 1, 'smootherstepinout')
	doTweenX('songDetailsX2', 'songDetails', -400, 1, 'smootherstepinout')
	doTweenY('exitY2', 'exit', screenHeight, 1, 'smootherstepinout')
	doTweenY('extraModifiersSectionY2', 'extraModifiersSection', -50, 1, 'smootherstepinout')
	doTweenX('extraModifiersX2', 'extraModifiers', 1400, 1, 'smootherstepinout')
end

function onCustomSubstateCreate(t) if substatesCreate[t] then substatesCreate[t]() end end
function onCustomSubstateUpdate(t) if substatesUpdate[t] then substatesUpdate[t]() end end
function onTweenCompleted(t) if tweens[t] then tweens[t]() end end
function onSoundFinished(s) if sounds[s] then sounds[s]() end end
function getGameplaySetting(name, defaultValue) return runHaxeCode("return ClientPrefs.getGameplaySetting('" .. name .. "', " .. defaultValue .. ")") end
function string.capitalize(var) return (var:gsub("^%l", string.upper)) end
function round(num, decimal_places) return math.floor(num * (10 ^ (decimal_places or 0)) + 0.5) / (10 ^ (decimal_places or 0)) end
function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)  
end
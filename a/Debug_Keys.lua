function onUpdatePost(elapsed)
	local check = getProperty('startingSong') or getProperty('endingSong')
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F1') then
		restartSong(true)
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F2') and not check then
		setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + 10000) 
		--setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + 5000) 
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
	elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.F3') and not check then
		debugPrint('curStep:', curStep)
		debugPrint('curBeat:', curBeat)
		debugPrint('curSec:', getPropertyFromClass('Conductor', 'songPosition') / 1000)
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F4') then
		setProperty('cpuControlled', not getProperty('cpuControlled'))
		setProperty('botplayTxt.visible', not getProperty('botplayTxt.visible'))
		debugPrint(getProperty('cpuControlled') and "botPlay On" or "botPlay Off")
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F5') then
		debugPrint("scrollSpeed = ", getProperty('songSpeed'))
		setProperty('songSpeed', getProperty('songSpeed') + 0.1)
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F6') then
		debugPrint("scrollSpeed = ", getProperty('songSpeed'))
		setProperty('songSpeed', getProperty('songSpeed') - 0.1)
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F7') then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.1)
		doTweenZoom('c', 'camGame', getProperty('defaultCamZoom'), 0.05, 'linear')
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F8') then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.1)
		doTweenZoom('c', 'camGame', getProperty('defaultCamZoom'), 0.05, 'linear')
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F9') then
		endSong(true)
	end
end
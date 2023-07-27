paused = false
inDebug = false
selected = 0

function onPause()
	return Function_Stop
end

function onUpdate()
	if keyboardJustPressed('ENTER') and not paused and not inGameOver then
		openCustomSubstate('pause', true)
	end
end

-- substate 
function onCustomSubstateCreate(tag)
	if tag == 'pause' then
		paused = true
		
		playSound('scrollMenu')
		setProperty('camOther.alpha', 0)
		doTweenAlpha('otherIn', 'camOther', 1, 0.5)
		
		makeLuaSprite('bg', '', 0, 0)
		setObjectCamera('bg', 'other')
		makeGraphic('bg', screenWidth, screenHeight, '000000')
		setProperty('bg.alpha', 0.4)
		addLuaSprite('bg')	
					
		makeLuaText('resume', 'Resume', 512, 30, 95)
		setTextAlignment('resume', 'left')
		setObjectCamera('resume', 'other')
		setTextSize('resume', 60)
		addLuaText('resume')	
		makeLuaText('restart', 'Restart', 512, 60, 195)
		setTextAlignment('restart', 'left')
		setObjectCamera('restart', 'other')
		setTextSize('restart', 60)
		addLuaText('restart')		
		makeLuaText('debug', 'Debug Panel', 512, 90, 295)
		setTextAlignment('debug', 'left')
		setObjectCamera('debug', 'other')
		setTextSize('debug', 60)
		addLuaText('debug')		
		makeLuaText('exit', 'Exit', 512, 120, 395)
		setTextAlignment('exit', 'left')
		setObjectCamera('exit', 'other')
		setTextSize('exit', 60)
		addLuaText('exit')

		makeLuaText('song', songName, 512, 760, 10)
		setTextAlignment('song', 'right')
		setObjectCamera('song', 'other')
		setTextSize('song', 35)
		addLuaText('song')
		makeLuaText('difficulty', difficultyName, 512, 760, 55)
		setTextAlignment('difficulty', 'right')
		setObjectCamera('difficulty', 'other')
		setTextSize('difficulty', 35)
		addLuaText('difficulty')
		makeLuaText('blueballed', 'Blueballed: '..getPropertyFromClass('PlayState', 'deathCounter'), 512, 760, 100)
		setTextAlignment('blueballed', 'right')
		setObjectCamera('blueballed', 'other')
		setTextSize('blueballed', 35)
		addLuaText('blueballed')
	end
	if tag == 'debug' then
		inDebug = true
		doTweenAlpha('otherIn', 'camOther', 1, 0.5)
		
		makeLuaSprite('bg', '', 0, 0)
		setObjectCamera('bg', 'other')
		makeGraphic('bg', screenWidth, screenHeight, '000000')
		setProperty('bg.alpha', 0.4)
		addLuaSprite('bg')	
		
		makeLuaText('bf', 'Boyfriend X/Y:\n'..getProperty('boyfriend.x')..'\n'..getProperty('boyfriend.y'), 512, 10, 50)
		setTextAlignment('bf', 'left')
		setObjectCamera('bf', 'other')
		setTextSize('bf', 35)
		addLuaText('bf')
		
		makeLuaText('gf', 'GF X/Y:\n'..getProperty('gf.x')..'\n'..getProperty('gf.y'), 512, 0, 50)
		setTextAlignment('gf', 'center')
		setObjectCamera('gf', 'other')
		setTextSize('gf', 35)
		screenCenter('gf', 'X')
		addLuaText('gf')
		
		makeLuaText('dad', 'Dad X/Y:\n'..getProperty('dad.x')..'\n'..getProperty('dad.y'), 512, 1100, 50)
		setTextAlignment('dad', 'left')
		setObjectCamera('dad', 'other')
		setTextSize('dad', 35)
		addLuaText('dad')
	end
end

function onCustomSubstateUpdate(tag)
	if tag == 'pause' then
		menuCheck()
		if keyboardJustPressed('ENTER') and paused then
			selectedCheck()
		end
		if keyJustPressed('down') then
			selected = selected + 1
			playSound('scrollMenu')
		elseif keyJustPressed('up') then 
			selected = selected - 1
			playSound('scrollMenu')
		end
	end
	if tag == 'debug' then
		if keyboardJustPressed('ESCAPE') and inDebug and not inGameOver then
			inDebug = false
			closeCustomSubstate()
			doTweenAlpha('otherOutDebug', 'camOther', 0, 0.5)
		end
	end
end

function onCustomSubstateDestroy(tag)
	if tag == 'pause' then
		paused = false
		if selected ~= 1 and selected ~= 3 or selected == 2 then
			doTweenAlpha('otherOut', 'camOther', 0, 0.5)
		end
	end
end

-- other shit
function menuCheck()
	if selected == 0 then
		setProperty('resume.alpha', 1)
	elseif selected ~= 0 then
		setProperty('resume.alpha', 0.7)
	end
	if selected == 1 then
		setProperty('restart.alpha', 1)
	elseif selected ~= 1 then
		setProperty('restart.alpha', 0.7)
	end
	if selected == 2 then
		setProperty('debug.alpha', 1)
	elseif selected ~= 2 then
		setProperty('debug.alpha', 0.7)
	end
	if selected == 3 then
		setProperty('exit.alpha', 1)
	elseif selected ~= 3 then
		setProperty('exit.alpha', 0.7)
	end
------------------------
	if selected < 0 then
		selected = 3
	elseif selected > 3 then
		selected = 0
	end
end

function selectedCheck()
	if selected == 0 then
		closeCustomSubstate()
	elseif selected == 1 then
		restartSong()
	elseif selected == 2 then
		closeCustomSubstate()
	elseif selected == 3 then
		exitSong()
	end
end

function onTweenCompleted(tag)
	if tag == 'otherOut' and selected == 2 then
		removeLuaSprite('bg')
		removeLuaText('resume')
		removeLuaText('restart')
		removeLuaText('debug')
		removeLuaText('exit')
		removeLuaText('song')
		removeLuaText('difficulty')
		removeLuaText('blueballed')
		openCustomSubstate('debug', true)
	end
	if tag == 'otherOutDebug' then
		removeLuaSprite('bg')
		removeLuaText('bf')
		removeLuaText('dad')
		removeLuaText('gf')
		openCustomSubstate('pause', true)
	end
end

-- ig since it's an example script i'll list (what i think are) all of the functions related to lua substates
-- openCustomSubstate(name:String, pauseGame:Bool = false) - makes a new substate with the name String
-- closeCustomSubstate() - closes a substate
-- onCustomSubstateCreate(tag) - called when you create a substate, put ur code shits in there
-- onCustomSubstateCreatePost(tag) - onCreatePost but for substates
-- onCustomSubstateUpdate(tag) - onUpdate but for substates
-- onCustomSubstateUpdatePost(tag) - onUpdatePost but for substates
-- onCustomSubstateDestroy(tag) - called after using closeCustomSubstate()
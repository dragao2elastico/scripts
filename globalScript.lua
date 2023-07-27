-- function goodNoteHit() 
--     if noteData == 0 then
--     setProperty('sprite.color', getColorFromHex('color shit in hex'))
--     end
-- end

function onCountdownTick(counter)
    -- if counter == 3 then
    --     triggerEvent('Play Animation','hey','bf')
    -- end
end


function onUpdate()
    addHaxeLibrary('Lib', 'openfl')
    addHaxeLibrary('Paths')
    addHaxeLibrary('Matrix', 'openfl.geom')
    addHaxeLibrary('Rectangle', 'openfl.geom')
    addHaxeLibrary('Sprite', 'openfl.display')
    addHaxeLibrary("CoolUtil");
    addHaxeLibrary("Application", "lime.app")
    
    -- setPropertyFromClass('openfl.Lib','application.window.fullscreen', true)
end



function onDestroy()
    setPropertyFromClass('openfl.Lib','application.window.fullscreen', false)
end

function onGameOver()
    setPropertyFromClass('openfl.Lib','application.window.fullscreen', false)
end

function onCreatePost()
    setTextString('timeTxt', 'hi :)')
end

function onStartCountdown()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
    setTextString('botplayTxt', '[Botplay]')
    setTextFont('botplayTxt', "Comic Sans MS");
    -- setTextColor('botplayTxt', '0, 0, 0')
    -- triggerEvent('Opponent Fade', '9999', '2')
end

function onSongStart()
    -- setProperty('cameraSpeed', 3)

    -- setPropertyFromClass('openfl.Lib','application.window.fullscreen', true)

    -- setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
    -- setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
    -- setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
    -- setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
    -- setPropertyFromGroup('playerStrums', 0, 'y', 625)
    -- setPropertyFromGroup('playerStrums', 1, 'y', 625)
    -- setPropertyFromGroup('playerStrums', 2, 'y', 625)
    -- setPropertyFromGroup('playerStrums', 3, 'y', 625)
    
    -- setPropertyFromGroup("strumLineNotes", 4, "x", 700)
    -- setPropertyFromGroup("strumLineNotes", 5, "x", 827)
    -- setPropertyFromGroup("strumLineNotes", 6, "x", 949)
    -- setPropertyFromGroup("strumLineNotes", 7, "x", 1070)

    -- setPropertyFromGroup("strumLineNotes", 4, "direction", 97.5)
    -- setPropertyFromGroup("strumLineNotes", 5, "direction", 92.5)
    -- setPropertyFromGroup("strumLineNotes", 6, "direction", 87.5)
    -- setPropertyFromGroup("strumLineNotes", 7, "direction", 85)


    -- setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
	-- setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
	-- setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
	-- setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)
	-- setPropertyFromGroup('opponentStrums', 0, 'y', 625)
	-- -- setPropertyFromGroup('opponentStrums', 1, 'y', 625)
	-- setPropertyFromGroup('opponentStrums', 2, 'y', 625)
	-- -- setPropertyFromGroup('opponentStrums', 3, 'y', 625)
		
	-- setPropertyFromGroup("strumLineNotes", 0, "x", 75)
	-- -- setPropertyFromGroup("strumLineNotes", 1, "x", 202)
	-- setPropertyFromGroup("strumLineNotes", 2, "x", 324)
	-- -- setPropertyFromGroup("strumLineNotes", 3, "x", 445)
		
	-- setPropertyFromGroup("strumLineNotes", 0, "direction", 97.5)
	-- -- setPropertyFromGroup("strumLineNotes", 1, "direction", 92.5)
	-- setPropertyFromGroup("strumLineNotes", 2, "direction", 87.5)
	-- -- setPropertyFromGroup("strumLineNotes", 3, "direction", 85)
end

-- function onUpdate() 
--     if keysJustPressed == 'f' then
--         setProperty('camHUD.flipX', true)
--     end
--     if keyJustPressed == 'f' then
--         setProperty('camHUD.flipY', true)
--         -- end
--     end
-- end

-- function goodNoteHit()
    
--     setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 0, 'y', 625)
--     setPropertyFromGroup('playerStrums', 1, 'y', 625)
--     setPropertyFromGroup('playerStrums', 2, 'y', 625)
--     setPropertyFromGroup('playerStrums', 3, 'y', 625)
    
--     setPropertyFromGroup("strumLineNotes", 4, "x", 700)
--     setPropertyFromGroup("strumLineNotes", 5, "x", 827)
--     setPropertyFromGroup("strumLineNotes", 6, "x", 949)
--     setPropertyFromGroup("strumLineNotes", 7, "x", 1070)

--     setPropertyFromGroup("strumLineNotes", 4, "direction", 97.5)
--     setPropertyFromGroup("strumLineNotes", 5, "direction", 92.5)
--     setPropertyFromGroup("strumLineNotes", 6, "direction", 87.5)
--     setPropertyFromGroup("strumLineNotes", 7, "direction", 85)


--     setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
-- 	setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
-- 	setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
-- 	setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)
-- 	setPropertyFromGroup('opponentStrums', 0, 'y', 625)
-- 	-- setPropertyFromGroup('opponentStrums', 1, 'y', 625)
-- 	-- setPropertyFromGroup('opponentStrums', 2, 'y', 625)
-- 	setPropertyFromGroup('opponentStrums', 3, 'y', 625)
		
-- 	setPropertyFromGroup("strumLineNotes", 0, "x", 75)
-- 	-- setPropertyFromGroup("strumLineNotes", 1, "x", 202)
-- 	-- setPropertyFromGroup("strumLineNotes", 2, "x", 324)
-- 	setPropertyFromGroup("strumLineNotes", 3, "x", 445)
		
-- 	setPropertyFromGroup("strumLineNotes", 0, "direction", 97.5)
-- 	-- setPropertyFromGroup("strumLineNotes", 1, "direction", 92.5)
-- 	-- setPropertyFromGroup("strumLineNotes", 2, "direction", 87.5)
-- 	setPropertyFromGroup("strumLineNotes", 3, "direction", 85)

--     -- triggerEvent('Change Scrolltype', 'off', '')
-- end

-- function opponentNoteHit()
    
--     setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
--     setPropertyFromGroup('playerStrums', 0, 'y', 625)
--     setPropertyFromGroup('playerStrums', 1, 'y', 625)
--     setPropertyFromGroup('playerStrums', 2, 'y', 625)
--     setPropertyFromGroup('playerStrums', 3, 'y', 625)
    
--     setPropertyFromGroup("strumLineNotes", 4, "x", 700)
--     setPropertyFromGroup("strumLineNotes", 5, "x", 827)
--     setPropertyFromGroup("strumLineNotes", 6, "x", 949)
--     setPropertyFromGroup("strumLineNotes", 7, "x", 1070)

--     setPropertyFromGroup("strumLineNotes", 4, "direction", 97.5)
--     setPropertyFromGroup("strumLineNotes", 5, "direction", 92.5)
--     setPropertyFromGroup("strumLineNotes", 6, "direction", 87.5)
--     setPropertyFromGroup("strumLineNotes", 7, "direction", 85)


--     setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
-- 	setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
-- 	setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
-- 	setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)
-- 	setPropertyFromGroup('opponentStrums', 0, 'y', 625)
-- 	-- setPropertyFromGroup('opponentStrums', 1, 'y', 625)
-- 	-- setPropertyFromGroup('opponentStrums', 2, 'y', 625)
-- 	setPropertyFromGroup('opponentStrums', 3, 'y', 625)
		
-- 	setPropertyFromGroup("strumLineNotes", 0, "x", 75)
-- 	-- setPropertyFromGroup("strumLineNotes", 1, "x", 202)
-- 	-- setPropertyFromGroup("strumLineNotes", 2, "x", 324)
-- 	setPropertyFromGroup("strumLineNotes", 3, "x", 445)
		
-- 	setPropertyFromGroup("strumLineNotes", 0, "direction", 97.5)
-- 	-- setPropertyFromGroup("strumLineNotes", 1, "direction", 92.5)
-- 	-- setPropertyFromGroup("strumLineNotes", 2, "direction", 87.5)
-- 	setPropertyFromGroup("strumLineNotes", 3, "direction", 85)

--     -- triggerEvent('Change Scrolltype', 'off', '')
-- end
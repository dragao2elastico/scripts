-- function onCreate()
--     makeLuaSprite('back', 'backNOTES', 400, 0)

--     addLuaSprite('back', false)
--     scaleObject('back', 0.47, 0.4)
--     setObjectCamera('back', 'hud')
-- 	setProperty('back.alpha', 0.5)
-- end

local keepScroll = false
function onUpdate() --onCreate()
	setProperty('camHUD.visible',true)
	setProperty('notes.cameras',true)
	setProperty('strumLineNotes.cameras',true)
	setProperty('gf.alpha', 1)
	setProperty('doof.cameras',true)

	if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
		keepScroll = true;
	elseif getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		setPropertyFromClass('ClientPrefs', 'middleScroll', true);
	end
end

function onDestroy()
	if keepScroll == false then
		setPropertyFromClass('ClientPrefs', 'middleScroll', false);
	elseif keepScroll == true then
		keepScroll = false;
	end
end

function onUpdate() --onCreatePost()
	if botplay == false then
		setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 0, 'y', 570)
		setPropertyFromGroup('opponentStrums', 1, 'y', 570)
		setPropertyFromGroup('opponentStrums', 2, 'y', 570)
		setPropertyFromGroup('opponentStrums', 3, 'y', 570)
	end

	if botplay == true then
		setPropertyFromGroup('boyfriendStrums', 4, 'downScroll', false)
		setPropertyFromGroup('boyfriendStrums', 5, 'downScroll', false)
		setPropertyFromGroup('boyfriendStrums', 6, 'downScroll', false)
		setPropertyFromGroup('boyfriendStrums', 7, 'downScroll', false)
		setPropertyFromGroup('boyfriendStrums', 4, 'y', 570)
		setPropertyFromGroup('boyfriendStrums', 5, 'y', 570)
		setPropertyFromGroup('boyfriendStrums', 6, 'y', 570)
		setPropertyFromGroup('boyfriendStrums', 7, 'y', 570)
	end
end

function onUpdate()
	if botplay == false then
		if getPropertyFromClass('opponentStrums', 'downScroll') then
			setPropertyFromClass("opponentStrums", "downScroll", false)
			setProperty("opponentStrums.y", 50)
		end
	end

	-- if botplay == true then
	-- 	if getPropertyFromClass('boyfriendStrums', 'downScroll') then
	-- 		setPropertyFromClass("boyfriendStrums", "downScroll", false)
	-- 		setProperty("boyfriendStrums.y", 50)
	-- 	end
	-- end
end

function onSongStart()
	if botplay == false then
		noteTweenX("Nota1", 0, 412, 0.1, cubeInOut)
		noteTweenX("Nota2", 1, 524, 0.1, cubeInOut)
		noteTweenX("Nota3", 2, 636, 0.1, cubeInOut)
		noteTweenX("Nota4", 3, 748, 0.1, cubeInOut)

		runTimer('NoteWait', 1, 0.1)

		setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)
		setPropertyFromGroup('opponentStrums', 0, 'y', 570)
		setPropertyFromGroup('opponentStrums', 1, 'y', 570)
		setPropertyFromGroup('opponentStrums', 2, 'y', 570)
		setPropertyFromGroup('opponentStrums', 3, 'y', 570)
	end

	-- if botplay == true then
	-- 	noteTweenX("Nota1", 0, 412, 0.1, cubeInOut)
	-- 	noteTweenX("Nota2", 1, 524, 0.1, cubeInOut)
	-- 	noteTweenX("Nota3", 2, 636, 0.1, cubeInOut)
	-- 	noteTweenX("Nota4", 3, 748, 0.1, cubeInOut)

	-- 	runTimer('NoteWait', 1, 0.1)

	-- 	setPropertyFromGroup('boyfriendStrums', 0, 'downScroll', false)
	-- 	setPropertyFromGroup('boyfriendStrums', 1, 'downScroll', false)
	-- 	setPropertyFromGroup('boyfriendStrums', 2, 'downScroll', false)
	-- 	setPropertyFromGroup('boyfriendStrums', 3, 'downScroll', false)
	-- 	setPropertyFromGroup('boyfriendStrums', 0, 'y', 570)
	-- 	setPropertyFromGroup('boyfriendStrums', 1, 'y', 570)
	-- 	setPropertyFromGroup('boyfriendStrums', 2, 'y', 570)
	-- 	setPropertyFromGroup('boyfriendStrums', 3, 'y', 570)
	-- end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'NoteWait' then
		noteTweenY("Nota1", 0, 40, 0.1, cubeInOut)
		noteTweenY("Nota2", 1, 40, 0.1, cubeInOut)
		noteTweenY("Nota3", 2, 40, 0.1, cubeInOut)
		noteTweenY("Nota4", 3, 40, 0.1, cubeInOut)
	end
end

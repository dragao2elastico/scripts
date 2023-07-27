--Script by Dusty (https://www.youtube.com/@CorEra)
function onUpdatePost()
	setProperty('iconP1.x', screenWidth - 350)
	setProperty('iconP2.x', 220)
end

function onUpdate(elapsed)
	if getProperty('health') < 1 then
		setProperty('health', 0)
	end
end

fadeinTime = 1

function onCreate()
	makeLuaSprite('Juke2Box', ' ', 635, 643)
	makeGraphic('Juke2Box', 303, 15, '000000')
	setObjectCamera('Juke2Box', 'other')
	setProperty('Juke2Box.alpha', 0)
	addLuaSprite('Juke2Box', true)

	makeLuaSprite('JukeBox', ' ', 635, 635)
	makeGraphic('JukeBox', 5, 30, 'FF0000')
	setObjectCamera('JukeBox', 'other')
	setProperty('JukeBox.alpha', 0)
	addLuaSprite('JukeBox', true)
end

function onStartCountdown()
	if not introTextShown then
		doTweenAlpha('JukeBoxShow', 'JukeBox', 1, fadeinTime)

	    doTweenAlpha('Juke2BoxShow', 'Juke2Box', 0.8, fadeinTime)
    end
end
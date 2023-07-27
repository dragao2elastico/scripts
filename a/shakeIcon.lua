function onUpdate(elapsed)


	local lol = math.random(1,2)

	if (lol >= 1) then
	
		doTweenAngle('tt', 'iconP2', -3, stepCrochet*0.00000000009, 'circOut')
	end

	if (lol >= 2) then

		doTweenAngle('tt', 'iconP2', 3, stepCrochet*0.00000000009, 'circOut')
	end

	setTextString('healthText', 'Health: ' .. math.floor(getProperty("health") * 50))


    local songPos = getPropertyFromClass('Conductor', 'songPosition') / 800 --How long it will take.


	if curBeat >= 214 and curBeat < 351 then
		setProperty("camGame.angle", spin * math.sin(songPos))
    end

	if curBeat == 744 then
		addLuaSprite('aaa',true)
        setProperty("camHUD.angle", 0)
		setProperty("camGame.angle", 0)
		cameraFade('game', '000000', 2, true);
		cameraShake('camGame', 0.01, 0.02)
    end
    
    if curBeat == 352 then
        setProperty("camGame.angle", 0)
    end


	if curBeat >= 667 and curBeat < 744 then
		
		setProperty("camGame.angle", spun * math.sin(songPos))
    end


	
	if curBeat >= 667 and curBeat < 744 then
	
		setProperty("camHUD.angle", spon * math.sin(songPos))
    end


	if curBeat >= 501 and curBeat < 641 then
		setProperty("camGame.angle", spin * math.sin(songPos))
    end
	if curBeat == 642 then
        setProperty("camHUD.angle", 0)
    end
end
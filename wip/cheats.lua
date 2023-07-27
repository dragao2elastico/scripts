local time_reverted = 0.5

function onCreate(id, noteType, noteData, isSustainNote)
    misses = getProperty('songMisses')

    if keyJustPressed('left') then
        setProperty('songMisses', misses - 5)
        addScore(-10)
        setProperty('health', getProperty('health') +0.0475)

        if flashingLights then
            cameraFlash('game', 'ffffff', 0.1)
        end
        
        setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 100)
    end

    if keyJustPressed('right') then
        addScore(10)
        setProperty('health', getProperty('health') +0.0475)
        if flashingLights then
            cameraFlash('game', 'ffffff', 0.1)
        end

        setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition') + time_reverted * 100)
    end
end

function noteMiss(id, noteType, noteData, isSustainNote)
    setProperty('songMisses', 0)
    addScore(10)
    setProperty('health', getProperty('health') +0.0475)
    if flashingLights then
        cameraFlash('game', 'ffffff', 0.1)
    end
end

function onUpdate()
    health = getProperty('health');
    

    -- if characterPlayAnim('boyfriend', 'hey', true) then 
    --     if getProperty('health') > -1 then
    --         setProperty('health', health+ 0.2);
    --     end
    -- end
    
    if keyJustPressed('space') then -- Defalth: space
        characterPlayAnim('boyfriend', 'hey', true)
        characterPlayAnim('boyfriend', 'hi', true)
        setProperty('boyfriend.specialAnim', true)
        playSound('hey') -- the volume goes from 1-5 and the sound file has to be in mods/sounds 
    end
    
    if keyJustPressed('space') then -- Defalth: space
        characterPlayAnim('dad', 'hey', true)
        setProperty('dad.specialAnim', true)
    end

    if keyJustPressed('space') then -- Defalth: space
        characterPlayAnim('girlfriend', 'hey', true)
        setProperty('girlfriend.specialAnim', true)
    end

    
    -- if characterPlayAnim('boyfriend', 'hey', true) then 
    --     setInterval(function()
    --         characterPlayAnim('boyfriend', 'idle', true)
    --         setProperty('boyfriend.specialAnim', false)
    --     end, 5000)
    --     process:loop()
    -- end
    
    if keyJustPressed('space') then -- Defalth: space
        if getProperty('health') > -1 then
            setProperty('health', health+ 0.2);
        end
    end
end

-- function goodNoteHit() 
--     playSound('hey', 5)
-- end


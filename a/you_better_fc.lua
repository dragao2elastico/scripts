local time_reverted = 0.5 -- How much time (in seconds) it reverts. Default is 0.5
local on = false

function noteMiss(id, noteType, noteData, isSustainNote)
    setProperty('songMisses', 0)
    addScore(10)
    setProperty('health', getProperty('health') +0.0475)
    if flashingLights then
        cameraFlash('game', 'ffffff', 0.1)
    end
    if on == true then
        setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 1000)
        setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition') - time_reverted * 100)
    end
    
end
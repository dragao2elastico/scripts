local defaultNotePos = {};

local timerDelay = 0.01 -- breaks if this is zero i think beacuase of lag

function onSongStart()
    runTimer("modchart1", 0, 1)
end
function onUpdatePost(e)
    defaultNotePos = {}
    for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
        table.insert(defaultNotePos, {x,y})
    end
    for i = 0,getProperty('notes.length') - 1 do 
            setPropertyFromGroup('notes', i, 'y', (defaultNotePos[getPropertyFromGroup('notes', i, 'noteData')][2] - (getSongPosition() - getPropertyFromGroup('notes', i, 'strumTime')) * (0.45 * getProperty("songSpeed"))))
            --setPropertyFromGroup('notes', i, 'y', (defaultNotePos[getPropertyFromGroup('notes', i, 'noteData')][2] - (getSongPosition() - getPropertyFromGroup('notes', i, 'strumTime')) * (0.45 * math.floor(getProperty("songSpeed")))))
            --daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "modchart1" then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'y', 0)
            runTimer("modchart2", 0, 1)
        end
    elseif tag == "modchart2" then
        for i = 0,7 do
            noteTweenY(i, i, 700, (0.865 / (getProperty("songSpeed") / 1.8)), linear)
            --750 / 50 = 15
            --15 * 0.0615385 = 0.9230775
            runTimer("modchart1", ((0.865 / (getProperty("songSpeed") / 1.8)) + timerDelay), 1)
        end
    end
end
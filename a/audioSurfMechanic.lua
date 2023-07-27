local audioSurfMechanic = true --Active AudioSurf Mechanic
local audioSurfColor = 'ffffff' --Your Audiosurf Color
local audioSurfSoundVolume = 0 --Sound effect Audiosurf
local audioSurfColumn = 5 --How Many Colums TheAudiosurf Grid(Default:5)(Warning More High Value More Lagging :skull:)

--Dont Edit This Bottom Code

local audioSurfGrid_1 = 0
local audioSurfGrid_2 = 0
local audioSurfGrid_3 = 0
local audioSurfGrid_4 = 0

function iff(test, if_true, if_false)--Test:trigger Script if_true:result code if true, if_false:result code if true
    if test then
        return if_true
    else
        return if_false
    end
end

function onCreatePost()
    if audioSurfMechanic then--note grid,audiosurf grid
        for i=1,audioSurfColumn do
            for j=1,4 do
                makeLuaSprite('audioSurfGrid_' .. j .. '_' .. i, '', 0, 0)
                makeGraphic('audioSurfGrid_' .. j .. '_' .. i, 80, 60, '505050')
                addLuaSprite('audioSurfGrid_' .. j .. '_' .. i, false)
                setObjectCamera('audioSurfGrid_' .. j .. '_' .. i, 'hud')
                makeLuaSprite('audioSurfGrid_' .. j .. '_' .. i .. 'B', '', 0, 0)
                makeGraphic('audioSurfGrid_' .. j .. '_' .. i .. 'B', 80, 60, audioSurfColor)
                addLuaSprite('audioSurfGrid_' .. j .. '_' .. i .. 'B', false)
                setObjectCamera('audioSurfGrid_' .. j .. '_' .. i .. 'B', 'hud')
                setProperty('audioSurfGrid_' .. j .. '_' .. i .. 'B.alpha', 0)
            end
        end
    end
end

function onUpdate(elapsed)
    note_1_Off = getPropertyFromGroup('playerStrums', 0, 'x') - 5
    note_2_Off = getPropertyFromGroup('playerStrums', 1, 'x') - 5
    note_3_Off = getPropertyFromGroup('playerStrums', 2, 'x') - 5
    note_4_Off = getPropertyFromGroup('playerStrums', 3, 'x') - 5
    note_1_OffY = getPropertyFromGroup('playerStrums', 0, 'y')
    note_2_OffY = getPropertyFromGroup('playerStrums', 1, 'y')
    note_3_OffY = getPropertyFromGroup('playerStrums', 2, 'y')
    note_4_OffY = getPropertyFromGroup('playerStrums', 3, 'y')
    if audioSurfMechanic then
        audioSurfGridTotal = audioSurfGrid_1 + audioSurfGrid_2 + audioSurfGrid_3 + audioSurfGrid_4
        for i=1,audioSurfColumn do
            --Grid 1
            setProperty('audioSurfGrid_1_' .. i .. '.x', note_1_Off+20)
            setProperty('audioSurfGrid_1_' .. i .. 'B.x', note_1_Off+20)
            setProperty('audioSurfGrid_1_' .. i .. '.y', iff(downscroll, note_1_OffY+25-(75*i), note_1_OffY+400-(375-(75*i))))
            setProperty('audioSurfGrid_1_' .. i .. 'B.y', iff(downscroll, note_1_OffY+25-(75*i), note_1_OffY+400-(375-(75*i))))
            --Grid 2
            setProperty('audioSurfGrid_2_' .. i .. '.x', note_2_Off+20)
            setProperty('audioSurfGrid_2_' .. i .. 'B.x', note_2_Off+20)
            setProperty('audioSurfGrid_2_' .. i .. '.y', iff(downscroll, note_2_OffY+25-(75*i), note_2_OffY+400-(375-(75*i))))
            setProperty('audioSurfGrid_2_' .. i .. 'B.y', iff(downscroll, note_2_OffY+25-(75*i), note_2_OffY+400-(375-(75*i))))
            --Grid 3
            setProperty('audioSurfGrid_3_' .. i .. '.x', note_3_Off+20)
            setProperty('audioSurfGrid_3_' .. i .. 'B.x', note_3_Off+20)
            setProperty('audioSurfGrid_3_' .. i .. '.y', iff(downscroll, note_3_OffY+25-(75*i), note_3_OffY+400-(375-(75*i))))
            setProperty('audioSurfGrid_3_' .. i .. 'B.y', iff(downscroll, note_3_OffY+25-(75*i), note_3_OffY+400-(375-(75*i))))
            --Grid 4
            setProperty('audioSurfGrid_4_' .. i .. '.x', note_4_Off+20)
            setProperty('audioSurfGrid_4_' .. i .. 'B.x', note_4_Off+20)
            setProperty('audioSurfGrid_4_' .. i .. '.y', iff(downscroll, note_4_OffY+25-(75*i), note_4_OffY+400-(375-(75*i))))
            setProperty('audioSurfGrid_4_' .. i .. 'B.y', iff(downscroll, note_4_OffY+25-(75*i), note_4_OffY+400-(375-(75*i))))
        end
        for i=1, audioSurfColumn do
            if audioSurfGrid_1 >= i then
                setProperty('audioSurfGrid_1_' .. i .. 'B.alpha', 1)
                setProperty('audioSurfGrid_1_' .. i .. '.alpha', 0)
            else
                setProperty('audioSurfGrid_1_' .. i .. 'B.alpha', 0)
                setProperty('audioSurfGrid_1_' .. i .. '.alpha', 1)
            end
            if audioSurfGrid_2 >= i then
                setProperty('audioSurfGrid_2_' .. i .. 'B.alpha', 1)
                setProperty('audioSurfGrid_2_' .. i .. '.alpha', 0)
            else
                setProperty('audioSurfGrid_2_' .. i .. 'B.alpha', 0)
                setProperty('audioSurfGrid_2_' .. i .. '.alpha', 1)
            end
            if audioSurfGrid_3 >= i then
                setProperty('audioSurfGrid_3_' .. i .. 'B.alpha', 1)
                setProperty('audioSurfGrid_3_' .. i .. '.alpha', 0)
            else
                setProperty('audioSurfGrid_3_' .. i .. 'B.alpha', 0)
                setProperty('audioSurfGrid_3_' .. i .. '.alpha', 1)
            end
            if audioSurfGrid_4 >= i then
                setProperty('audioSurfGrid_4_' .. i .. 'B.alpha', 1)
                setProperty('audioSurfGrid_4_' .. i .. '.alpha', 0)
            else
                setProperty('audioSurfGrid_4_' .. i .. 'B.alpha', 0)
                setProperty('audioSurfGrid_4_' .. i .. '.alpha', 1)
            end
        end
        if audioSurfGrid_1 >= audioSurfColumn+1 then
            if not botPlay then
                setProperty('songScore', getProperty('songScore') + (350*audioSurfGridTotal-1))
                debugPrint('+' .. 100*audioSurfGridTotal-1)
            end
            audioSurfGrid_1 = 1
            audioSurfGrid_2 = 0
            audioSurfGrid_3 = 0
            audioSurfGrid_4 = 0
            playSound('confirmMenu', audioSurfSoundVolume/100)
        end
        if audioSurfGrid_2 >= audioSurfColumn+1 then
            if not botPlay then
                setProperty('songScore', getProperty('songScore') + (350*audioSurfGridTotal-1))
                debugPrint('+' .. 100*audioSurfGridTotal-1)
            end
            audioSurfGrid_1 = 0
            audioSurfGrid_2 = 1
            audioSurfGrid_3 = 0
            audioSurfGrid_4 = 0
            playSound('confirmMenu', audioSurfSoundVolume/100)
        end
        if audioSurfGrid_3 >= audioSurfColumn+1 then
            if not botPlay then
                setProperty('songScore', getProperty('songScore') + (350*audioSurfGridTotal-1))
                debugPrint('+' .. 100*audioSurfGridTotal-1)
            end
            audioSurfGrid_1 = 0
            audioSurfGrid_2 = 0
            audioSurfGrid_3 = 1
            audioSurfGrid_4 = 0
            playSound('confirmMenu', audioSurfSoundVolume/100)
        end
        if audioSurfGrid_4 >= audioSurfColumn+1 then
            if not botPlay then
                setProperty('songScore', getProperty('songScore') + (350*audioSurfGridTotal-1))
                debugPrint('+' .. 100*audioSurfGridTotal-1)
            end
            audioSurfGrid_1 = 0
            audioSurfGrid_2 = 0
            audioSurfGrid_3 = 0
            audioSurfGrid_4 = 1
            playSound('confirmMenu', audioSurfSoundVolume/100)
        end
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if audioSurfMechanic then
        runTimer('blockFunc', 1.5, 1)
        if not isSustainNote then
            if noteData == 0 then
                audioSurfGrid_1 = audioSurfGrid_1 + 1
            end
            if noteData == 1 then
                audioSurfGrid_2 = audioSurfGrid_2 + 1
            end
            if noteData == 2 then
                audioSurfGrid_3 = audioSurfGrid_3 + 1
            end
            if noteData == 3 then
                audioSurfGrid_4 = audioSurfGrid_4 + 1
            end
        end
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'blockFunc' then
        if audioSurfGridTotal >= 4 and not botPlay then
            playSound('confirmMenu', audioSurfSoundVolume/100)
            debugPrint('+' .. 100*audioSurfGridTotal)
            audioSurfGrid_1 = 0
            audioSurfGrid_2 = 0
            audioSurfGrid_3 = 0
            audioSurfGrid_4 = 0
        end
    end
end
local bfArrow = 0
local dadArrow = 0
local noteTexture = 'NOTE_assets'

function iff(test, if_true, if_false)
	if test then
		return if_true
	else
		return if_false
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
        bfArrow = bfArrow + 1
        makeAnimatedLuaSprite('bfArrow' .. bfArrow, iff(getPropertyFromGroup('notes', id, 'texture') == '', iff(noteType == 'Hurt Note', 'HURTNOTE_assets', noteTexture), getPropertyFromGroup('notes', id,  'texture')), getProperty('boyfriend.x')+getProperty('boyfriend.width')*math.random(0,100)*0.01, getProperty('boyfriend.y')-100)
        addAnimationByPrefix('bfArrow' .. bfArrow, '0', 'purple0', 24, false)
        addAnimationByPrefix('bfArrow' .. bfArrow, '1', 'blue0', 24, false)
        addAnimationByPrefix('bfArrow' .. bfArrow, '2', 'green0', 24, false)
        addAnimationByPrefix('bfArrow' .. bfArrow, '3', 'red0', 24, false)
        setProperty('bfArrow' .. bfArrow .. '.scale.x', getPropertyFromGroup('notes', id, 'scale.x'))
        setProperty('bfArrow' .. bfArrow .. '.scale.y', getPropertyFromGroup('notes', id, 'scale.y'))
        addLuaSprite('bfArrow' .. bfArrow, true)
        doTweenY('bfArrowY' .. bfArrow, 'bfArrow' .. bfArrow, getProperty('boyfriend.y')+100, 2)
        doTweenAlpha('bfArrowAlpha' .. bfArrow,  'bfArrow' .. bfArrow, 0, 1)
        for i=0,3 do
            if noteData == i then
                objectPlayAnimation('bfArrow'..bfArrow, i, false)
            end
        end
    end
end
function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
        dadArrow = dadArrow + 1
        makeAnimatedLuaSprite('dadArrow' .. dadArrow, iff(getPropertyFromGroup('notes', id,  'texture') == '', iff(noteType == 'Hurt Note', 'HURTNOTE_assets', noteTexture), getPropertyFromGroup('notes', id, 'texture')), getProperty('dad.x')+getProperty('dad.width')*math.random(0,100)*0.01, getProperty('dad.y')-100)
        addAnimationByPrefix('dadArrow' .. dadArrow, '0', 'purple0', 24, false)
        addAnimationByPrefix('dadArrow' .. dadArrow, '1', 'blue0', 24, false)
        addAnimationByPrefix('dadArrow' .. dadArrow, '2', 'green0', 24, false)
        addAnimationByPrefix('dadArrow' .. dadArrow, '3', 'red0', 24, false)
        setProperty('dadArrow' .. dadArrow .. '.scale.x', getPropertyFromGroup('notes', id, 'scale.x'))
        setProperty('dadArrow' .. dadArrow .. '.scale.y', getPropertyFromGroup('notes', id, 'scale.y'))
        addLuaSprite('dadArrow' .. dadArrow, true)
        doTweenY('dadArrowY' .. dadArrow, 'dadArrow' .. dadArrow, getProperty('dad.y')+100, 2)
        doTweenAlpha('dadArrowAlpha' .. dadArrow,  'dadArrow' .. dadArrow, 0, 2)
        for i=0,3 do
            if noteData == i then
                objectPlayAnimation('dadArrow'..dadArrow, i, false)
            end
        end
    end
end

function onTweenCompleted(tag)
    for i=0, bfArrow do
        if tag == 'bfArrowY' .. i then
            removeLuaSprite('bfArrow' .. i, true)
         end
    end
    for i=0, dadArrow do
        if tag == 'dadArrowY' .. i then
            removeLuaSprite('dadArrow' .. i, true)
         end
    end
end
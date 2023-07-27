local fakeNote = 1
local lol = 0

local fakeNoteCol = {
	[0] = 'purple',
	[1] = 'blue',
	[2] = 'green',
	[3] = 'red'
}
function onCreatePost()
    luaDebugMode = false
    for i = 0,getProperty('unspawnNotes.length') do
        if not getPropertyFromGroup('unspawnNotes',i,'mustPress') then
            setPropertyFromGroup('unspawnNotes',i,'visible',false)
        end
    end
end

function opponentNoteHit(id, dir, nt, sus)
	if sus then
		if getPropertyFromGroup('notes',id,'animation.curAnim.name'):find('Scroll') then
			spawnFakeNote(dir)
		end
		if getPropertyFromGroup('notes',id,'animation.curAnim.name'):find('hold') then
			spawnFakeSusNote(dir)
		end
		if getPropertyFromGroup('notes',id,'animation.curAnim.name'):find('holdend') then
			spawnFakeSusNoteEnd(dir)
		end
    else
		spawnFakeNote(dir)
	end
end

-- // eeeeeeeeeeeeeeeeeehhhhhhhhhhhhheeeeeeeeeeeeeeeeeeeee \\--
function spawnFakeNote(dir)
	fakeNote = fakeNote + 1
		makeAnimatedLuaSprite('fakeNote' .. fakeNote, getPropertyFromGroup('opponentStrums',1,'texture'))
		addAnimationByPrefix('fakeNote' .. fakeNote, fakeNoteCol[dir] .. 'Scroll', fakeNoteCol[dir] .. '0', 24, true)
		addLuaSprite('fakeNote' .. fakeNote)
		setProperty('fakeNote' .. fakeNote .. '.alpha', 1)
			setProperty('fakeNote' .. fakeNote .. '.x', getPropertyFromGroup('opponentStrums', dir, 'x'))
            setProperty('fakeNote' .. fakeNote .. '.y', getPropertyFromGroup('opponentStrums', dir, 'y'))
            setProperty('fakeNote' .. fakeNote .. '.velocity.y', (downscroll and -500 or 500 )* getProperty('songSpeed'))

		scaleObject('fakeNote'.. fakeNote, 0.7, 0.7)
		setObjectCamera('fakeNote' .. fakeNote, 'hud')
		setObjectOrder('fakeNote' .. fakeNote, getObjectOrder('opponentStrums') + 2)
end
function spawnFakeSusNote(dir)
	lol = lol + 1
		makeAnimatedLuaSprite(lol..'fakeNoteS' .. fakeNote,getPropertyFromGroup('opponentStrums',1,'texture'))
		addAnimationByPrefix(lol..'fakeNoteS' .. fakeNote, fakeNoteCol[dir] .. 'Scroll', fakeNoteCol[dir] .. ' hold piece0', 24, true)
		addLuaSprite(lol..'fakeNoteS' .. fakeNote)
		setProperty(lol..'fakeNoteS' .. fakeNote .. '.alpha', 1)
			setProperty(lol..'fakeNoteS' .. fakeNote .. '.x', getPropertyFromGroup('opponentStrums', dir, 'x')+37)
            setProperty(lol..'fakeNoteS' .. fakeNote .. '.y', getPropertyFromGroup('opponentStrums', dir, 'y') + (downscroll and 40 or -40))
            setProperty(lol..'fakeNoteS' .. fakeNote .. '.velocity.y',(downscroll and -500 or 500 )* getProperty('songSpeed'))
			setProperty(lol..'fakeNoteS' .. fakeNote .. '.alpha', 0.5)

		scaleObject(lol..'fakeNoteS'.. fakeNote, 0.7, getProperty('songSpeed')*1.7)
		setObjectCamera(lol..'fakeNoteS' .. fakeNote, 'hud')
		setObjectOrder(lol..'fakeNoteS' .. fakeNote, getObjectOrder('opponentStrums') + 1)
end
function spawnFakeSusNoteEnd(dir)
	lol = lol + 1

		makeAnimatedLuaSprite(lol..'fakeNoteSE' .. fakeNote, getPropertyFromGroup('opponentStrums',1,'texture'))
		if dir == 0 then
			addAnimationByPrefix(lol..'fakeNoteSE' .. fakeNote, fakeNoteCol[dir] .. 'End', 'pruple end hold0', 24, true)
		else
			addAnimationByPrefix(lol..'fakeNoteSE' .. fakeNote, fakeNoteCol[dir] .. 'End', fakeNoteCol[dir] .. ' hold end0', 24, true)
		end
		addLuaSprite(lol..'fakeNoteSE' .. fakeNote)
		setProperty(lol..'fakeNoteSE' .. fakeNote .. '.alpha', 1)
			setProperty(lol..'fakeNoteSE' .. fakeNote .. '.x', getPropertyFromGroup('opponentStrums', dir, 'x')+35)
            setProperty(lol..'fakeNoteSE' .. fakeNote .. '.y', getPropertyFromGroup('opponentStrums', dir, 'y') + (downscroll and 240 or -240))
			setProperty(lol..'fakeNoteSE' .. fakeNote .. '.alpha', 0.5)
			setProperty(lol..'fakeNoteSE' .. fakeNote .. '.flipY',not downscroll)

            setProperty(lol..'fakeNoteSE' .. fakeNote .. '.velocity.y',(downscroll and -500 or 500 )* getProperty('songSpeed'))

		scaleObject(lol..'fakeNoteSE'.. fakeNote, 0.7, 0.7)
		setObjectCamera(lol..'fakeNoteSE' .. fakeNote, 'hud')
		setObjectOrder(lol..'fakeNoteSE' .. fakeNote, getObjectOrder('opponentStrums') + 1)
end
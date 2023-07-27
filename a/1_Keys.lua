
function onSpawnNote(id, noteData, noteType, isSus)
    setPropertyFromGroup('notes', id, 'noteData', 2)
    if getPropertyFromGroup('notes', id, 'isSustainNote') then
    	--the note direction is Perfectly if retexture Through Script
    	if getPropertyFromGroup('notes', id, 'animation.curAnim.name'):find('holdend') then--ignore Me Please ;-;
    		setPropertyFromGroup('notes', id, 'animation.curAnim.name', 'greenholdend')
    	else
    		setPropertyFromGroup('notes', id, 'animation.curAnim.name', 'greenhold')
    	end
    else
    	setPropertyFromGroup('notes', id, 'animation.curAnim.name', 'greenScroll')
    --debugPrint(getPropertyFromGroup('notes', id, 'animation'))
    end
end
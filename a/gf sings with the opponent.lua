function opponentNoteHit(id, noteData, noteType, isSustainNote)
        if noteData == 0 then
        triggerEvent('Play Animation','singLEFT', 'gf')
end
		if noteData == 1 then
        triggerEvent('Play Animation','singDOWN', 'gf')
end
		if noteData == 2 then
        triggerEvent('Play Animation','singUP', 'gf')
end
		if noteData == 3 then
        triggerEvent('Play Animation','singRIGHT', 'gf')
	end
end
--Script by SkylarSays#2679
--touching these "spin" variables will just fuck with the first spin so
--if you really want that to happen go for it i guess
spin1 = 1
spin2 = 1
spin3 = 1
spin4 = 1
spin5 = 1
spin6 = 1
spin7 = 1
spin8 = 1

--edit these tho

tweenType = linear --you can find every tween on the psych wiki i think
tweenTime = 0.5 --warning hold notes are a little funky
tweenAmount = 360 --i recomend you make this a multiple of 360

-- function goodNoteHit(id, direction, noteType, isSustainNote)
-- 	if direction == 0 then
-- 		noteTweenAngle('playrotate0', 4, tweenAmount * spin1, tweenTime, tweenType)
-- 		spin1 = spin1 + 1
-- 	elseif direction == 1 then
-- 		noteTweenAngle('playrotate1', 5, tweenAmount * spin2, tweenTime, tweenType)
-- 		spin2 = spin2 + 1
-- 	elseif direction == 2 then
-- 		noteTweenAngle('playrotate2', 6, tweenAmount * spin3, tweenTime, tweenType)
-- 		spin3 = spin3 + 1
-- 	elseif direction == 3 then
-- 		noteTweenAngle('playrotate4', 7, tweenAmount * spin4, tweenTime, tweenType)
-- 		spin4 = spin4 + 1
-- 	end
-- end

-- function opponentNoteHit(id, direction, noteType, isSustainNote)
-- 	if direction == 0 then
-- 		noteTweenAngle('opprotate0', 0, tweenAmount * spin5, tweenTime, tweenType)
-- 		spin5 = spin5 + 1
-- 	elseif direction == 1 then
-- 		noteTweenAngle('opprotate1', 1, tweenAmount * spin6, tweenTime, tweenType)
-- 		spin6 = spin6 + 1
-- 	elseif direction == 2 then
-- 		noteTweenAngle('opprotate2', 2, tweenAmount * spin7, tweenTime, tweenType)
-- 		spin7 = spin7 + 1
-- 	elseif direction == 3 then
-- 		noteTweenAngle('opprotate4', 3, tweenAmount * spin8, tweenTime, tweenType)
-- 		spin8 = spin8 + 1
-- 	end
-- end


function goodNoteHit(id, direction, noteType, isSustainNote)
		if direction == 0 then
            noteTweenAngle('playrotate0', 4, tweenAmount % spin1, tweenTime, tweenType)
			spin1 = spin1 + 1
		elseif direction == 1 then
            noteTweenAngle('playrotate1', 5, tweenAmount % spin2, tweenTime, tweenType)
			spin2 = spin2 + 1
		elseif direction == 2 then
            noteTweenAngle('playrotate2', 6, tweenAmount % spin3, tweenTime, tweenType)
			spin3 = spin3 + 1
		elseif direction == 3 then
            noteTweenAngle('playrotate4', 7, tweenAmount % spin4, tweenTime, tweenType)
			spin4 = spin4 + 1
		end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
		if direction == 0 then
            noteTweenAngle('opprotate0', 0, tweenAmount % spin5, tweenTime, tweenType)
			spin5 = spin5 + 1
		elseif direction == 1 then
            noteTweenAngle('opprotate1', 1, tweenAmount % spin6, tweenTime, tweenType)
			spin6 = spin6 + 1
		elseif direction == 2 then
            noteTweenAngle('opprotate2', 2, tweenAmount % spin7, tweenTime, tweenType)
			spin7 = spin7 + 1
		elseif direction == 3 then
            noteTweenAngle('opprotate4', 3, tweenAmount % spin8, tweenTime, tweenType)
			spin8 = spin8 + 1
		end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if direction == 0 then
		noteTweenAngle('playrotate0', 4, tweenAmount * spin1, tweenTime, tweenType)
		spin1 = spin1 - 1
	elseif direction == 1 then
		noteTweenAngle('playrotate1', 5, tweenAmount * spin2, tweenTime, tweenType)
		spin2 = spin2 - 1
	elseif direction == 2 then
		noteTweenAngle('playrotate2', 6, tweenAmount * spin3, tweenTime, tweenType)
		spin3 = spin3 - 1
	elseif direction == 3 then
		noteTweenAngle('playrotate4', 7, tweenAmount * spin4, tweenTime, tweenType)
		spin4 = spin4 - 1
	end
end
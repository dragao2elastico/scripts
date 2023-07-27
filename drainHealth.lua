function opponentNoteHit()
   health = getProperty('health')
   if getProperty('health') > 0.2 then
      setProperty('health', health- 0.02);
   -- elseif getProperty('health') <= 0.2 then
   --    setProperty('health', health+ 0.2);
	end
end     
function onCreatePost()
   setProperty('health', 0.5)
end

function onStartCountdown()
	return Function_Stop;
end

function onStartCountdown()
   setProperty('health', 1.0);
	return Function_Continue;
end

-- function onSongStart()
-- end
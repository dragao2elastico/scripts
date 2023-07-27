local bf = 'ralsei-player'

function onSongStart()
    triggerEvent('Change Character', 'BF', bf)
end

function onStartCountdown()
	return Function_Stop;
end

function onStartCountdown()
	if difficultyName == "hard" then 
		if songName == "1corekiller-hank" or songName == "anger-of-god-hank" then
			return Function_Continue
		end
	else
		triggerEvent('Change Character', 'BF', bf)
		return Function_Continue
	end
end
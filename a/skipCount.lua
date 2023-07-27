-- Custom skipCountdown script by Kevin Kuntz
function onCreate() -- bulk o work
	setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + getPropertyFromClass('Conductor', 'crochet') * 2) -- skip the time
	setProperty('skipArrowStartTween', true) -- skip the start tween
end

function onCreatePost()
	setProperty('skipArrowStartTween', true)
	setProperty('startTimer.finished', true)
end

function onCountdownStarted() -- without this, GF's head constantly bops to the left.
	setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + getPropertyFromClass('Conductor', 'crochet') * 2)
	for _,character in pairs({'gf',"boyfriend","dad"}) do
		if string.find(getProperty(character..'.animation.curAnim.name'), 'idle') or string.find(getProperty(character..'.animation.curAnim.name'), 'dance') then
			characterDance(character)
		end
	end
	runTimer('fakebop', crochet / 1000, 3)
end

function onTimerCompleted(t)
	if t == 'fakebop' then
		for _,character in pairs({'gf',"boyfriend","dad"}) do
			if string.find(getProperty(character..'.animation.curAnim.name'), 'idle') or string.find(getProperty(character..'.animation.curAnim.name'), 'dance') then
				characterDance(character)
			end
		end
	end
end
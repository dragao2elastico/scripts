winbarlength = 10
barempty = '-'
barfill = '='
timeOffset = 0
targetTimeOffset = 0
timeOffsetLerp = 1

function onEvent(name,v1,v2)
	if name == 'Change_Time_Offset' then
		targetTimeOffset = v1
		timeOffsetLerp = v2
	end
end
function lerp(a, b, t)
	return a + (b - a) * t
end

snog=false
function onCreatePost()
	bitlestring = getPropertyFromClass("openfl.Lib", "application.window.title"); --timmy turner! how dare you poop on the screen while we were watching the lego movie
end
function onSongStart()
	snog=true
end
function onUpdatePost()
if snog then

	local songPersent = math.floor(winbarlength*((getSongPosition())/((getProperty('songLength')+timeOffset)))) --srry if bad
	local titlestring = bitlestring..' - '..songName..' '
	titlestring = titlestring..'[' --wel freaking come to the krusty freaking freaking freaking freaking freaking krab. how the hell may i help you
	for i=1,winbarlength,1 do
		if i <= songPersent then
			titlestring = titlestring..barfill
		else
			titlestring = titlestring..barempty
		end
	end
	titlestring = titlestring..']' --first of freaking all, i am not here to get any of those greasy buffoons you call krabby patties
	if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Time Left' then
		titlestring = titlestring..' '..convert_to_time(math.floor((getProperty('songLength')+timeOffset)-getSongPosition()))
	elseif getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Time Elapsed' then
		titlestring = titlestring..' '..convert_to_time(math.floor(getSongPosition()))
	end
	setPropertyFromClass("openfl.Lib", "application.window.title", titlestring);
	timeOffset = lerp(timeOffset,targetTimeOffset,timeOffsetLerp)
end

end
function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin\': Psych Engine");
end
function convert_to_time(tenths)
	local sex = tenths/1000
	local ss = sex % 60
	sex = sex/60
	local mm = sex % 60

	return string.format("%01d:%02d", mm, ss)
end

function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
	if keyJustPressed('space') then
		playSound("Yeah");
		characterPlayAnim("boyfriend", "hey", true);
	end
end

function onGhostTap(direction)
	--playSound("BeatBoxOne");
	if direction == 0 then
		playSound("BeatBoxOne");
		characterPlayAnim("boyfriend", "singLEFT", true);
	elseif direction == 1 then
		playSound("BeatBoxOne");
		characterPlayAnim("boyfriend", "singDOWN", true);
	elseif direction == 2 then
		playSound("BeatBoxTwo");
		characterPlayAnim("boyfriend", "singUP", true);
	else 
		playSound("Go");
		characterPlayAnim("boyfriend", "singRIGHT", true);
	end
end
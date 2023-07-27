-- credits
-- Brayan GD - FUCKING WHOLE SCRIPT (dont remove this)

-- settings
local showJudgements = false
local judgementColors = {
	sick = "00FFFF",
	good = "00FF00",
	ok = "FFFF00",
	bad = "FF0000"
}

local songColors = {
	"Violently Lucky",
	"Bopeebo",
	"Fresh",
	"Dad Battle"
}

function onCreate()
	-- engine version on the corner
	makeLuaText('engineVersion', "V" .. version, 600, screenWidth - 650, screenHeight - 50);
	addLuaText('engineVersion');
	setTextSize('engineVersion', 26);
	setTextAlignment('engineVersion', 'right');
	-- judgements stuff
	if showJudgements then
	makeLuaText('judgements_Text', 'Judgements: ', 600, screenWidth - 600, screenHeight - 450)
	addLuaText('judgements_Text');
	setTextSize('judgements_Text', 20);
	setTextAlignment('judgements_Text', 'right');
	makeLuaText('judgements_minusSpam_Text', '------------', 600, screenWidth - 600, screenHeight - 425)
	addLuaText('judgements_minusSpam_Text');
	setTextSize('judgements_minusSpam_Text', 20);
	setTextAlignment('judgements_minusSpam_Text', 'right');
	makeJudgementText('Sick', screenWidth - 600, screenHeight - 400)
	makeJudgementText('Good', screenWidth - 600, screenHeight - 375)
	makeJudgementText('Ok', screenWidth - 600, screenHeight - 350)
	makeJudgementText('Bad', screenWidth - 600, screenHeight - 325)
	end
	-- song name
	makeLuaText('songNameText', '', 700, 0, 0);
	setTextAlignment('songNameText', 'right');
	local choosedSongColor = ""
	for i, checkedSong in ipairs(songColors) do
		if songName == checkedSong then
			choosedSongColor = returnSongHexColor(checkedSong)
		end
	end
	setTextColor('songNameText', choosedSongColor);
	setTextString('songNameText', songName)
	addLuaText('songNameText');
	setTextSize('songNameText', 26);
	-- difficulty thing
	makeLuaText('difficultyNameText', '', 700, 700, 0)
	local choosedDifficultyColor = ""
	choosedDifficultyColor = returnDifficultyHexColor(tostring(difficultyName))
	setTextColor('difficultyNameText', choosedDifficultyColor)
	setTextString('difficultyNameText', "(" .. difficultyName .. ")")
	addLuaText('difficultyNameText')
	setTextSize('difficultyNameText', 26);
	setTextAlignment('difficultyNameText', 'left');
	-- Time Stuff
	makeLuaText('timeText_MMM', '[]', 600, 350, 30)
	addLuaText('timeText_MMM')
	setTextSize('timeText_MMM', 26);
end

function onStartCountdown()
	setProperty('timeBarBG.visible', false);
	setProperty('timeBar.visible', false);
	setProperty('timeTxt.visible', false);
end

function returnSongHexColor(song)
	local songColorReturning = {
		["Violently Lucky"] = function()
			return "999999"
		end,
		["Bopeebo"] = function()
			return "FF0000"
		end,
		["Fresh"] = function()
			return "FF0000"
		end,
		["Dad Battle"] = function()
			return "FF0000"
		end,
	}
	return songColorReturning[song]()
end

function returnDifficultyHexColor(difficultyName)
	local difficultyColorReturning = {
		["Easy"] = function()
			return "00FF00"
		end,
		["Normal"] = function()
			return "FFFF00"
		end,
		["Hard"] = function()
			return "FF0000"
		end,
		["Harder"] = function()
			return "C40000"
		end,
		["Insane"] = function()
			return "FF32FF"
		end,
	}
	return difficultyColorReturning[difficultyName]()
end

local songStarted = false

function onUpdate()
	if songStarted then
		local timeShit = convertMillisecondsToTime(songLength - getPropertyFromClass("Conductor", "songPosition"))
		setTextString('timeText_MMM',"[" .. timeShit .. "]")
		setTextString('scoreTxt', tostring("Score: " .. score .. " | Misses: " .. misses .. " | Accuracy: " .. roundToTwoDecimalPlaces(rating * 100) .. "% | Combo: " .. hits))
		if showJudgements then
			setTextString('SickJudgementText','Sick: ' .. getProperty('sicks'));
			setTextString('GoodJudgementText','Good: ' .. getProperty('goods'));
			setTextString('OkJudgementText','Ok: ' .. getProperty('bads'));
			setTextString('BadJudgementText','Sick: ' .. getProperty('shits'));
		end
	end
end

function onSongStart()
	songStarted = true
	if showJudgements then
		setTextColor('SickJudgementText', judgementColors.sick)
		setTextColor('GoodJudgementText', judgementColors.good)
		setTextColor('OkJudgementText', judgementColors.ok)
		setTextColor('BadJudgementText', judgementColors.bad)
	end
end

function onCountdownTick(counter)
	if counter == 0 then
		setTextString('timeText_MMM','[-]')
	end
	if counter == 1 then
		setTextString('timeText_MMM','[-:]')
	end
	if counter == 2 then
		setTextString('timeText_MMM','[-:-]')
	end
	if counter == 3 then
		setTextString('timeText_MMM','[-:--]')
	end
end

function convertMillisecondsToTime(milliseconds)
	local totalSeconds = math.floor(milliseconds / 1000)
	local minutes = math.floor(totalSeconds / 60)
	local seconds = totalSeconds % 60
	
	return minutes .. ":" .. string.format("%02d", seconds)
end

function roundToTwoDecimalPlaces(num)
	local roundedNum = tonumber(string.format("%.2f", num))
	return roundedNum
end

function makeJudgementText(judgement,posx,posy)
	makeLuaText(judgement .. 'JudgementText', judgement .. ": 0", 600, posx,posy);
	addLuaText(judgement .. 'JudgementText');
	setTextSize(judgement .. 'JudgementText', 20);
	setTextAlignment(judgement .. 'JudgementText', 'right');
end
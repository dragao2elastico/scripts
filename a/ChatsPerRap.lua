local opponentChatText = {'Im Pro :J', 'He-he-he-ha!', 'Bro, you so bad', 'get good lol', 'NOOB!!', 'wow', 'You got some skills', 'I dont want to lose'} -- you can change le text for opponent
local opponentHitNoteForText = 0
local opponentNeedToHitNote = -1
local opponentIsShocked = 0
local opponentChatTextIsNeedToBeShow = false
local playerChatText = {'Im Pro', 'NICE!', 'Look at my score', 'crap', 'O_o', 'You Hacker!!', 'This modchart SUCKS', 'I HATE SPAM', 'Not Bad', 'Good Combo Bro!', 'How did you not miss?'} -- you can change le text for bf
local playerHitNoteForText = 0
local playerNeedToHitNote = -1
local playerIsShocked = 0
local playerChatTextIsNeedToBeShow = false

-- so, opponent hit has 2 phrase, opponent insults you 3 and opponent shocked 3
-- player hit has 3 phrase, player insults you 5 and player shocked 3
-- you can add new pharases BUT you need to change something
-- go to line where you can see setTextString and getRandomInt and change last number to another (im bad in explaining so is better to just edit exist phrases)
function onCreate()
    makeLuaText('opponentName', ''..dadName..':', 0, 0, 640)
	setTextSize('opponentName', 25)
	setTextColor('opponentName', 'FF0000')
	addLuaText('opponentName', true)
	setObjectCamera('opponentName', 'Other')
    makeLuaText('opponentTextChat', 'just joined server', 0, getProperty('opponentName.width')+ 5, 640)
	setTextSize('opponentTextChat', 25)
	addLuaText('opponentTextChat', true)
	setObjectCamera('opponentTextChat', 'Other')
	
    makeLuaText('playerName', ''..boyfriendName..':', 0, 0, 680)
	setTextSize('playerName', 25)
	setTextColor('playerName', '00FFFF')
	addLuaText('playerName', true)
	setObjectCamera('playerName', 'Other')	
    makeLuaText('playerTextChat', 'just joined server', 0, getProperty('playerName.width')+ 5, 680)
	setTextSize('playerTextChat', 25)
	addLuaText('playerTextChat', true)
	setObjectCamera('playerTextChat', 'Other')	
	
end
function onSongStart()
  opponentNeedToHitNote = getRandomInt(5,50)
  playerNeedToHitNote = getRandomInt(5,50)  
  runTimer('hideOpponentChatText', 0.5, 1)
  runTimer('hidePlayerChatText', 0.5, 1)  
end

function onUpdate()
 if opponentChatTextIsNeedToBeShow == true then
    cancelTimer('hideOpponentChatText')
    setProperty('opponentName.alpha', 1)
    setProperty('opponentTextChat.alpha', 1)	 
    runTimer('hideOpponentChatText', 1, 1)	  
    opponentChatTextIsNeedToBeShow = false	
 end
 
 if playerChatTextIsNeedToBeShow == true then 
    cancelTimer('hidePlayerChatText')
    setProperty('playerName.alpha', 1)
    setProperty('playerTextChat.alpha', 1)	 
    runTimer('hidePlayerChatText', 1, 1)	
	playerChatTextIsNeedToBeShow = false
 end	

 if opponentHitNoteForText == opponentNeedToHitNote then
	opponentChatTextIsNeedToBeShow = true 	 
    setTextString('opponentTextChat', opponentChatText[getRandomInt(1,2)]) 
	opponentHitNoteForText = 0
    opponentNeedToHitNote = getRandomInt(5,50)
 end
 if playerHitNoteForText == playerNeedToHitNote then
	playerChatTextIsNeedToBeShow = true 
    setTextString('playerTextChat', playerChatText[getRandomInt(1,3)]) 
	playerHitNoteForText = 0
    playerNeedToHitNote = getRandomInt(5,50)  	
 end 
 if opponentIsShocked == 5 then
	opponentChatTextIsNeedToBeShow = true 	
    setTextString('opponentTextChat', opponentChatText[getRandomInt(6,8)]) 
	opponentIsShocked = 0
 end
 if playerIsShocked == 5 then
	playerChatTextIsNeedToBeShow = true 	 
    setTextString('playerTextChat', playerChatText[getRandomInt(9,11)]) 
	playerIsShocked = 0
 end 
end

function onEvent(name, value1, value2)
  if name == 'Change Character' then
    setTextString('opponentName', ''..dadName..':')
	setProperty('opponentTextChat.x', getProperty('opponentName.width')+ 5)
   if value1 == 'Dad' or value1 == '1' then
  	 opponentChatTextIsNeedToBeShow = true 
     setTextString('opponentTextChat', 'just joined server') 	 
   end      
    setTextString('playerName', ''..boyfriendName..':')	
	setProperty('playerTextChat.x', getProperty('playerName.width')+ 5)	
   if value1 == 'BF' then
	 playerChatTextIsNeedToBeShow = true  
     setTextString('playerTextChat', 'just joined server') 		 
   end  	
  end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
  if not isSustainNote then
    opponentHitNoteForText = opponentHitNoteForText + 1
	playerIsShocked = getRandomInt(1,250) 
  end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
  if not isSustainNote then
    playerHitNoteForText = playerHitNoteForText + 1
	opponentIsShocked = getRandomInt(1,250)	
  end
end
function noteMiss(id, direction, noteType, isSustainNote)
  if not isSustainNote then
    whatTextNeedToBeShow = getRandomInt(1,3)
    setTextString('opponentTextChat', opponentChatText[getRandomInt(3,5)]) 
    setTextString('playerTextChat', playerChatText[getRandomInt(4,8)]) 	
	playerHitNoteForText = 0
  if whatTextNeedToBeShow == 1 or whatTextNeedToBeShow == 3 then	
	playerChatTextIsNeedToBeShow = true 
  end	
  if whatTextNeedToBeShow == 2 or whatTextNeedToBeShow == 3 then	
	opponentChatTextIsNeedToBeShow = true 
  end  
  end
end
function onTimerCompleted(tag, loops, loopsLeft)
  if tag == 'hideOpponentChatText' then
    doTweenAlpha('opponentChatTextIStransparent1', 'opponentTextChat', 0, 0.5, 'linear')
    doTweenAlpha('opponentChatTextIStransparent2', 'opponentName', 0, 0.5, 'linear')	
  end
  if tag == 'hidePlayerChatText' then
    doTweenAlpha('playerChatTextIStransparent1', 'playerTextChat', 0, 0.5, 'linear')
    doTweenAlpha('playerChatTextIStransparent2', 'playerName', 0, 0.5, 'linear')	
  end  
end
-- this script is the funniest i ever made, try it on spam songs
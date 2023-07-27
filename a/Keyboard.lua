-- Script by Scarlet Eye

-- Your "HEX" Color )
-- >
local bgCOLOR = 'FFFFFF'
local bgCOLORor = '000000'
local colorLEFT = 'C24B99'
local colorUP = '12FA05'
local colorDOWN = '00FFFF'
local colorRIGHT = 'F9393F'
local colorSPACE = 'FFFFFF'
local colorMISS = '000000'
local pressButton = '000000'
local pressButtonAWSD = 'FF0000'
local stopButtonAWSD = 'FFFFFF'
-- <

--Your Setup Keyboard(Specify here the buttons that you will click on)
-- >
local A = 'C'
local W = 'N'
local S = 'V'
local D = 'M'
local SP = 'SPACE'
local LEFT = 'keys.justPressed.C'
local UP = 'keys.justPressed.N'
local DOWN = 'keys.justPressed.V'
local RIGHT = 'keys.justPressed.M'
local SPACE = 'keys.justPressed.SPACE'
-- <

-- My Setup Keyboard :D
-- >
--local A = 'D'
--local W = 'UP'
--local S = 'F'
--local D = 'RI'
--local SP = 'SPACE'
--local LEFT = 'keys.justPressed.D'
--local UP = 'keys.justPressed.UP'
--local DOWN = 'keys.justPressed.F'
--local RIGHT = 'keys.justPressed.RIGHT'
--local SPACE = 'keys.justPressed.SPACE'
-- <

-- Shows the color of the buttons, you clicked
-- <
local clicks = true -- true = yes, false = no
clickPLUS = "+"
clickMINUS = "-"
clickPP = "++"
-- >

function onCreatePost()
	setProperty('ArrowLeftBG.color', getColorFromHex('000000'))
	setProperty('ArrowDownBG.color', getColorFromHex('000000'))
	setProperty('ArrowUpBG.color', getColorFromHex('000000'))
	setProperty('ArrowRightBG.color', getColorFromHex('000000'))
	setProperty('SpaceBG.color', getColorFromHex('000000'))
end

function onCreate()
	if not botPlay then
		makeLuaSprite('ArrowLeftBG', nil, 10, 630)
		makeGraphic('ArrowLeftBG', 70, 70, bgCOLOR)
		setObjectCamera('ArrowLeftBG', 'other')
		addLuaSprite('ArrowLeftBG', false)

		makeLuaSprite('ArrowLeft', nil, 15, 635)
		makeGraphic('ArrowLeft', 60, 60, colorLEFT)
		setObjectCamera('ArrowLeft', 'other')
		addLuaSprite('ArrowLeft', false)

		makeLuaText('A-LEFT', A, 0, 30, 650)
		setObjectCamera('A-LEFT', 'other')
		scaleObject('A-LEFT', 1.5, 1.5)
		addLuaText('A-LEFT', true)

		makeLuaSprite('ArrowUpBG', nil, 90, 550)
		makeGraphic('ArrowUpBG', 70, 70, bgCOLOR)
		setObjectCamera('ArrowUpBG', 'other')
		addLuaSprite('ArrowUpBG', false)

		makeLuaSprite('ArrowUp', nil, 95, 555)
		makeGraphic('ArrowUp', 60, 60, colorUP)
		setObjectCamera('ArrowUp', 'other')
		addLuaSprite('ArrowUp', false)

		makeLuaText('W-UP', W, 0, 110, 570)
		setObjectCamera('W-UP', 'other')
		scaleObject('W-UP', 1.5, 1.5)
		addLuaText('W-UP', true)

		makeLuaSprite('ArrowDownBG', nil, 90, 630)
		makeGraphic('ArrowDownBG', 70, 70, bgCOLOR)
		setObjectCamera('ArrowDownBG', 'other')
		addLuaSprite('ArrowDownBG', false)

		makeLuaSprite('ArrowDown', nil, 95, 635)
		makeGraphic('ArrowDown', 60, 60, colorDOWN)
		setObjectCamera('ArrowDown', 'other')
		addLuaSprite('ArrowDown', false)

		makeLuaText('S-DOWN', S, 0, 110, 650)
		setObjectCamera('S-DOWN', 'other')
		scaleObject('S-DOWN', 1.5, 1.5)
		addLuaText('S-DOWN', true)

		makeLuaSprite('ArrowRightBG', nil, 170, 630)
		makeGraphic('ArrowRightBG', 70, 70, bgCOLOR)
		setObjectCamera('ArrowRightBG', 'other')
		addLuaSprite('ArrowRightBG', false)

		makeLuaSprite('ArrowRight', nil, 175, 635)
		makeGraphic('ArrowRight', 60, 60, colorRIGHT)
		setObjectCamera('ArrowRight', 'other')
		addLuaSprite('ArrowRight', false)

		makeLuaText('D-RIGHT', D, 0, 190, 650)
		setObjectCamera('D-RIGHT', 'other')
		scaleObject('D-RIGHT', 1.5, 1.5)
		addLuaText('D-RIGHT', true)

		makeLuaSprite('SpaceBG', nil, 10, 470)
		makeGraphic('SpaceBG', 230, 70, bgCOLOR)
		setObjectCamera('SpaceBG', 'other')
		addLuaSprite('SpaceBG', false)

		makeLuaSprite('Space', nil, 15, 475)
		makeGraphic('Space', 220, 60, colorSPACE)
		setObjectCamera('Space', 'other')
		addLuaSprite('Space', false)

		makeLuaText('Space-SPACE', SP, 0, 90, 490)
		setObjectCamera('Space-SPACE', 'other')
		scaleObject('Space-SPACE', 1.5, 1.5)
		addLuaText('Space-SPACE', true)

		makeLuaText('Click', '', 0, 10, 10)
		setObjectCamera('Click', 'other')
		addLuaText('Click', true)
	end
end

function onUpdate()
	if not inGameOver then
		setObjectOrder('ArrowLeftBG', 790)
		setObjectOrder('ArrowLeft', 870)
		setObjectOrder('A-LEFT', 999)
		setObjectOrder('ArrowUpBG', 790)
		setObjectOrder('ArrowUp', 870)
		setObjectOrder('W-UP', 999)
		setObjectOrder('ArrowDownBG', 790)
		setObjectOrder('ArrowDown', 870)
		setObjectOrder('S-DOWN', 999)
		setObjectOrder('ArrowRightBG', 790)
		setObjectOrder('ArrowRight', 870)
		setObjectOrder('D-RIGHT', 999)
		setObjectOrder('SpaceBG', 790)
		setObjectOrder('Space', 870)
		setObjectOrder('Space-SPACE', 999)
		setObjectOrder('Click', 999)
	end
	keyBoard()
end

function onTimerCompleted(objects)
	doTweenColor('ColorL-BG', 'ArrowLeftBG', bgCOLORor, 0.1, 'linear')
	doTweenColor('ColorL', 'ArrowLeft', colorLEFT, 0.1, 'linear')
	doTweenColor('ColorL-A', 'A-LEFT', stopButtonAWSD, 0.1, 'linear')
	scaleObject('ArrowLeftBG', 1.0, 1.0)
	scaleObject('ArrowLeft', 1.0, 1.0)
	scaleObject('A-LEFT', 1.5, 1.5)
	doTweenColor('ColorD-BG', 'ArrowDownBG', bgCOLORor, 0.1, 'linear')
	doTweenColor('ColorD', 'ArrowDown', colorDOWN, 0.1, 'linear')
	doTweenColor('ColorL-D', 'S-DOWN', stopButtonAWSD, 0.1, 'linear')
	scaleObject('ArrowDownBG', 1.0, 1.0)
	scaleObject('ArrowDown', 1.0, 1.0)
	scaleObject('S-DOWN', 1.5, 1.5)
	doTweenColor('ColorU-BG', 'ArrowUpBG', bgCOLORor, 0.1, 'linear')
	doTweenColor('ColorU', 'ArrowUp', colorUP, 0.1, 'linear')
	doTweenColor('ColorU-U', 'W-UP', stopButtonAWSD, 0.1, 'linear')
	scaleObject('ArrowUpBG', 1.0, 1.0)
	scaleObject('ArrowUp', 1.0, 1.0)
	scaleObject('W-UP', 1.5, 1.5)
	doTweenColor('ColorR-BG', 'ArrowRightBG', bgCOLORor, 0.1, 'linear')
	doTweenColor('ColorR', 'ArrowRight', colorRIGHT, 0.1, 'linear')
	doTweenColor('ColorR-D', 'D-RIGHT', stopButtonAWSD, 0.1, 'linear')
	scaleObject('ArrowRightBG', 1.0, 1.0)
	scaleObject('ArrowRight', 1.0, 1.0)
	scaleObject('D-RIGHT', 1.5, 1.5)
	doTweenColor('ColorW-BG', 'SpaceBG', bgCOLORor, 0.1, 'linear')
	doTweenColor('ColorW', 'Space', colorSPACE, 0.1, 'linear')
	doTweenColor('ColorW-SPACE', 'Space-SPACE', stopButtonAWSD, 0.1, 'linear')
	scaleObject('SpaceBG', 1.0, 1.0)
	scaleObject('Space', 1.0, 1.0)
	scaleObject('Space-SPACE', 1.5, 1.5)
	if clicks then
		doTweenAlpha('+-', 'Click', 0.0, 0.1, 'linear');
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteMiss then
		cameraShake('hud', 0.005, 0.1);
		if clicks then
			setTextString('Click', 'Click : ' ..clickMINUS)
			setProperty('Click.color', getColorFromHex(colorMISS))
			doTweenAlpha('-', 'Click', 1.0, 0.05, 'linear')

			runTimer('objects', 0.1)
		end
	end
end


function keyBoard(A, W, S, D)
	if getPropertyFromClass('flixel.FlxG', LEFT) then
		doTweenColor('ColorL-BG', 'ArrowLeftBG', colorLEFT, 0.05, 'linear')
		doTweenColor('ColorL', 'ArrowLeft', pressButton, 0.05, 'linear')
		doTweenColor('ColorL-A', 'A-LEFT', pressButtonAWSD, 0.05, 'linear')
		scaleObject('ArrowLeftBG', 0.95, 0.95)
		scaleObject('ArrowLeft', 0.95, 0.95)
		scaleObject('A-LEFT', 1.3, 1.3)
		runTimer('objects', 0.1)
		if clicks then
			setTextString('Click', 'Click : ' ..clickPLUS)
			setProperty('Click.color', getColorFromHex(colorLEFT))
			doTweenAlpha('+', 'Click', 1.0, 0.05, 'linear')
		end
	end
	if getPropertyFromClass('flixel.FlxG', DOWN) then
		doTweenColor('ColorD-BG', 'ArrowDownBG', colorDOWN, 0.05, 'linear')
		doTweenColor('ColorD', 'ArrowDown', pressButton, 0.05, 'linear')
		doTweenColor('ColorD-D', 'S-DOWN', pressButtonAWSD, 0.05, 'linear')
		scaleObject('ArrowDownBG', 0.95, 0.95)
		scaleObject('ArrowDown', 0.95, 0.95)
		scaleObject('S-DOWN', 1.3, 1.3)
		runTimer('objects', 0.1)
		if clicks then
			setTextString('Click', 'Click : ' ..clickPLUS)
			setProperty('Click.color', getColorFromHex(colorDOWN))
			doTweenAlpha('+', 'Click', 1.0, 0.05, 'linear')
		end
	end
	if getPropertyFromClass('flixel.FlxG', UP) then
		doTweenColor('ColorU-BG', 'ArrowUpBG', colorUP, 0.05, 'linear')
		doTweenColor('ColorU', 'ArrowUp', pressButton, 0.05, 'linear')
		doTweenColor('ColorU-U', 'W-UP', pressButtonAWSD, 0.05, 'linear')
		scaleObject('ArrowUpBG', 0.95, 0.95)
		scaleObject('ArrowUp', 0.95, 0.95)
		scaleObject('W-UP', 1.3, 1.3)
		runTimer('objects', 0.1)
		if clicks then
			setTextString('Click', 'Click : ' ..clickPLUS)
			setProperty('Click.color', getColorFromHex(colorUP))
			doTweenAlpha('+', 'Click', 1.0, 0.05, 'linear')
		end
	end
	if getPropertyFromClass('flixel.FlxG', RIGHT) then
		doTweenColor('ColorR-BG', 'ArrowRightBG', colorRIGHT, 0.05, 'linear')
		doTweenColor('ColorR', 'ArrowRight', pressButton, 0.05, 'linear')
		doTweenColor('ColorR-D', 'D-RIGHT', pressButtonAWSD, 0.05, 'linear')
		scaleObject('ArrowRightBG', 0.95, 0.95)
		scaleObject('ArrowRight', 0.95, 0.95)
		scaleObject('D-RIGHT', 1.3, 1.3)
		runTimer('objects', 0.1)
		if clicks then
			setTextString('Click', 'Click : ' ..clickPLUS)
			setProperty('Click.color', getColorFromHex(colorRIGHT))
			doTweenAlpha('+', 'Click', 1.0, 0.05, 'linear')
		end
	end
	if getPropertyFromClass('flixel.FlxG', SPACE) then
		doTweenColor('ColorW-BG', 'SpaceBG', colorSPACE, 0.05, 'linear')
		doTweenColor('ColorW', 'Space', pressButton, 0.05, 'linear')
		doTweenColor('ColorW-SPACE', 'Space-SPACE', pressButtonAWSD, 0.05, 'linear')
		scaleObject('SpaceBG', 0.95, 0.95)
		scaleObject('Space', 0.95, 0.95)
		scaleObject('Space-SPACE', 1.3, 1.3)
		runTimer('objects', 0.1)
		if clicks then
			setTextString('Click', 'Click : ' ..clickPP)
			setProperty('Click.color', getColorFromHex(colorSPACE))
			doTweenAlpha('+', 'Click', 1.0, 0.05, 'linear')
		end
	end
end
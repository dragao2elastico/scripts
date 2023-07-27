local songsList = {}
local curSelected = 1
local onYes = true
local resetting = false
local canPressKeys = true
function getTableLength(T) --https://stackoverflow.com/questions/2705793/how-to-get-number-of-entries-in-a-lua-table lmfao
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
function onStartCountdown()
    return Function_Stop
end
function onCreate()
    makeLuaSprite('bg', 'menuDesat', 0, 0)
    addLuaSprite('bg', false)
    setScrollFactor('bg', 0, 0)
    setProperty('camGame.zoom', 1)
    setProperty('defaultCamZoom', 1)
end
function onCreatePost()
    --+ EDIT DIFFICULTIES HERE!!!!!!!!!!!!!!!!!!!!! for now it only allows one though
    addHaxeLibrary('CoolUtil')
    runHaxeCode([[
        CoolUtil.difficulties = ['hard'];
    ]])
    -- ADD YOUR SONGS HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- data name (as in the .json file of the song), display name (what actually appears), icon, bg color, if unlocked or not, custom font (if needed)
    addSong('tutorial', 'Tutorial', 'gf', 'a5004d', true)
    addSong('bopeebo', 'Bopeebo', 'dad', '9271fd', true)
    addSong('fresh', 'Fresh', 'dad', '9271fd', true)
    addSong('dad-battle', 'Dad Battle', 'dad', '9271fd', true)
    addSong('spookeez', 'Spookeez', 'spooky', '223344', true)
    addSong('south', 'South', 'spooky', '223344', true)
    addSong('monster', 'Monster', 'monster', '223344', true)
    addSong('pico', 'Pico', 'pico', '941653', true)
    addSong('philly-nice', 'Philly Nice', 'pico', '941653', true)
    addSong('blammed', 'Blammed', 'pico', '941653', true)
    addSong('satin-panties', 'Satin Panties', 'mom', 'fc96d7', true)
    addSong('high', 'High', 'mom', 'fc96d7', true)
    addSong('milf', 'Milf', 'mom', 'fc96d7', true)
    addSong('cocoa', 'Cocoa', 'parents', 'a0d1ff', true)
    addSong('eggnog', 'Eggnog', 'parents', 'a0d1ff', true)
    addSong('winter-horrorland', 'Winter Horrorland', 'monster', 'a0d1ff', true)
    addSong('senpai', 'Senpai', 'senpai-pixel', 'ff78bf', true)
    addSong('roses', 'Roses', 'senpai-pixel', 'ff78bf', true)
    addSong('thorns', 'Thorns', 'spirit-pixel', 'ff78bf', true)
    addSong('ugh', 'Ugh', 'tankman', 'f6b604', true)
    addSong('guns', 'Guns', 'tankman', 'f6b604', true)
    addSong('stress', 'Stress', 'tankman', 'f6b604', true)

    -- NO TOUCHY FROM HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!! :rage:
    setProperty('cameraSpeed', math.pi)

    makeLuaSprite('scoreBlackBG', nil, 0, 0)
    makeGraphic('scoreBlackBG', 1, 48, '000000')
    addLuaSprite('scoreBlackBG')
    setProperty('scoreBlackBG.alpha', 0.6)
    setObjectCamera('scoreBlackBG', 'camHUD')

    makeLuaText('score', '', -1, screenWidth * 0.7, 5)
    setTextSize('score', 32)
    setTextBorder('score', 0, '0x00000000')
    setProperty('score.antialiasing', true)
    addLuaText('score')

    setProperty('dad.visible', false)
    setProperty('boyfriend.visible', false)
    setProperty('gf.visible', false)

    changeSelection(0)
    doTweenColor('bgColorTween', 'bg', songsList[curSelected][4], 0.001, 'linear')

    runTimer('ae', 0.4)
end
function addSong(name, displayName, icon, color, unlocked, customFont)
    if unlocked == nil then
        unlocked = true
    end
    if customFont == nil then
        customFont = 'vcr'
    end
    table.insert(songsList, {name, displayName, icon, color, unlocked, customFont})
    local id = getTableLength(songsList)
    local dnFinal = displayName
    if not unlocked then
        dnFinal = '???'
    end
    makeLuaText('display'..id, dnFinal, -1, 230, (150 * id))
    setTextFont('display'..id, customFont..'.ttf')
    setTextSize('display'..id, 64)
    setTextBorder('display'..id, 4, '000000')
    setObjectCamera('display'..id, 'camGame')
    setScrollFactor('display'..id, 1, 1)
    setProperty('display'..id..'.antialiasing', true)
    setProperty('display'..id..'.scrollFactor.x', 1)
    setProperty('display'..id..'.scrollFactor.y', 1)
    addLuaText('display'..id)
    if #icon ~= 0 then
        makeLuaSprite('icon'..id, '', 80, (150 * id) - 20)
        loadGraphic('icon'..id, 'icons/icon-'..icon)
        loadGraphic('icon'..id, 'icons/icon-'..icon, getProperty('icon'..id..'.width') / 2, getProperty('icon'..id..'.height'))
        addAnimation('icon'..id, 'icon', {0, 1}, 0, true)
        setProperty('icon'..id..'.animation.curAnim.curFrame', 0)
        setScrollFactor('icon'..id, 1, 1)
        setProperty('icon'..id..'.x', 228 - (getProperty('icon'..id..'.width')))
        setProperty('icon'..id..'.y', getProperty('display'..id..'.y') - (getProperty('icon'..id..'.height') / 2) + (getProperty('display'..id..'.height') / 2))
        setProperty('icon'..id..'.antialiasing', true)
        addLuaSprite('icon'..id)
        if not unlocked then
            doTweenColor('icon'..id..'ColorTween', 'icon'..id, '000000', 0.001, 'linear')
        end
        setProperty('icon'..id..'.alpha', 0.6)
    end
    setProperty('display'..id..'.alpha', 0.6)
end
function round(num, decimals) --https://wiki.multitheftauto.com/wiki/Math.round
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end
function changeSelection(amount)
    curSelected = curSelected + amount
	if curSelected < 1 then 
        curSelected = getTableLength(songsList)
	elseif curSelected > getTableLength(songsList) then 
        curSelected = 1
	end
    playSound('scrollMenu', 0.4)
    triggerEvent('Camera Follow Pos', 640, getProperty('display'..curSelected..'.y') + (getProperty('display'..curSelected..'.height') / 2))
    for id = 1, getTableLength(songsList) do
        setProperty('display'..id..'.alpha', 0.6)
        setProperty('icon'..id..'.alpha', 0.6)
        if id == curSelected then
            setProperty('display'..id..'.alpha', 1)
            setProperty('icon'..id..'.alpha', 1)
        end
    end

    doTweenColor('bgColorTween', 'bg', songsList[curSelected][4], 1, 'linear')

    addHaxeLibrary('Highscore')
    runHaxeCode([[
        var songName = ']]..songsList[curSelected][1]..[[';
        var intendedScore = Highscore.getScore(songName, 0);
		var intendedRating = Highscore.getRating(songName, 0);
        setVar('thej', game.modchartTexts.get('score'));
        //game.addTextToDebug(songName + ', ' + intendedScore + ', ' + Highscore.floorDecimal(intendedRating * 100, 2), 0xFFFFFFFF);
        game.modchartTexts.get('score').text = 'PERSONAL BEST: ' + intendedScore + ' (' + Highscore.floorDecimal(intendedRating * 100, 2) + '%)';
    ]])
    --setProperty('score.text', 'Personal Best: '..funnyscore..' ('..round(funnyrating, 2)..'%)')
end
function onGameOver()
    return Function_Stop
end
function startResetThing()
    resetting = true
    playSound('scrollMenu', 0.4)
    makeLuaSprite('resetBlackBG', nil, 0, 0)
    makeGraphic('resetBlackBG', screenWidth * 2, screenHeight * 2, '000000')
    addLuaSprite('resetBlackBG', true)
    setProperty('resetBlackBG.alpha', 0)
    setObjectCamera('resetBlackBG', 'camHUD')
    doTweenAlpha('resetBlackBGAlphaTween', 'resetBlackBG', 0.6, 0.5, 'linear')

    makeLuaText('resetifgay', 'reset score and rating?', -1, 0, (screenHeight / 3))
    setTextSize('resetifgay', 48)
    setTextBorder('resetifgay', 4, '000000')
    setObjectCamera('resetifgay', 'camHUD')
    setScrollFactor('resetifgay', 1, 1)
    setTextAlignment('resetifgay', 'center')
    setProperty('resetifgay.antialiasing', true)
    setProperty('resetifgay.scrollFactor.x', 1)
    setProperty('resetifgay.scrollFactor.y', 1)
    addLuaText('resetifgay')
    screenCenter('resetifgay', 'x')
    setProperty('resetifgay.alpha', 0)
    doTweenAlpha('resetAlphaTween', 'resetifgay', 1, 0.25, 'linear')

    makeLuaText('yes', 'yes', -1, 0, screenHeight / 2)
    setTextSize('yes', 48)
    setTextBorder('yes', 4, '000000')
    setObjectCamera('yes', 'camHUD')
    setScrollFactor('yes', 1, 1)
    setTextAlignment('yes', 'center')
    setProperty('yes.antialiasing', true)
    setProperty('yes.scrollFactor.x', 1)
    setProperty('yes.scrollFactor.y', 1)
    setProperty('yes.alpha', 0)
    addLuaText('yes')
    screenCenter('yes', 'x')
    setProperty('yes.x', getProperty('yes.x') - 200)
    doTweenAlpha('yesAlphaTween', 'yes', 1, 0.5, 'linear')

    makeLuaText('no', 'no', -1, 0, screenHeight / 2)
    setTextSize('no', 48)
    setTextBorder('no', 4, '000000')
    setObjectCamera('no', 'camHUD')
    setScrollFactor('no', 1, 1)
    setTextAlignment('no', 'center')
    setProperty('no.antialiasing', true)
    setProperty('no.scrollFactor.x', 1)
    setProperty('no.scrollFactor.y', 1)
    setProperty('no.alpha', 0)
    addLuaText('no')
    screenCenter('no', 'x')
    setProperty('no.x', getProperty('no.x') + 200)
    doTweenAlpha('noAlphaTween', 'no', 1, 0.5, 'linear')
    onYes = true
    changeYes()
end
function changeYes()
    onYes = not onYes
    playSound('scrollMenu', 0.4)
    if onYes then
        doTweenAlpha('yesAlphaTween', 'yes', 1, 0.25, 'linear')
        doTweenAlpha('noAlphaTween', 'no', 0.6, 0.25, 'linear')
    else
        doTweenAlpha('yesAlphaTween', 'yes', 0.6, 0.25, 'linear')
        doTweenAlpha('noAlphaTween', 'no', 1, 0.25, 'linear')
    end
end
local holdTime = 0
local changeAmt = 1
function onUpdatePost(elapsed)
    setProperty('scoreTxt.visible', false)
    setProperty('sgbsTxt.visible', false)
    setProperty('botplayTxt.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('camZooming', true)

    if getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
		changeAmt = 3
    else
        changeAmt = 1
    end
    if canPressKeys then
        if getProperty('controls.RESET') then
            if not resetting then
                startResetThing()
            end
        end
        if not resetting then
	        if getProperty('controls.UI_UP_P') or getPropertyFromClass('flixel.FlxG', 'mouse.wheel') == 1 then
                holdTime = 0
	        	changeSelection(-changeAmt)
            end
	        if getProperty('controls.UI_DOWN_P') or getPropertyFromClass('flixel.FlxG', 'mouse.wheel') == -1 then
                holdTime = 0
	        	changeSelection(changeAmt)
            end
            if getProperty('controls.UI_UP') then
                local checkLastHold = math.floor((holdTime - 0.5) * 10)
	        	holdTime = holdTime + elapsed
                local checkNewHold = math.floor((holdTime - 0.5) * 10)
                if holdTime > 0.5 and checkNewHold - checkLastHold > 0 then
                    changeSelection((checkNewHold - checkLastHold) * -changeAmt)
                end
            end
            if getProperty('controls.UI_DOWN') then
                local checkLastHold = math.floor((holdTime - 0.5) * 10)
	        	holdTime = holdTime + elapsed
                local checkNewHold = math.floor((holdTime - 0.5) * 10)
                if holdTime > 0.5 and checkNewHold - checkLastHold > 0 then
                    changeSelection((checkNewHold - checkLastHold) * changeAmt)
                end
            end
            if getProperty('controls.BACK') then
                endSong()
            end
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
                if songsList[curSelected][5] then
                    loadSong(songsList[curSelected][1], -1)
                    --runHaxeCode([[
                    --    var funny = "]]..songsList[curSelected][1]..[[";
                    --    game.addTextToDebug(Paths.formatToSongPath(funny), 0xFFFFFFFF);
                    --]])
                else
                    playSound('deny', 1)
                    cameraFlash('camHUD', '0x36FF0000', 0.4, true)
                    cameraShake('camGame', 0.005, 0.13)
                    triggerEvent('Add Camera Zoom', '', '')
                end
            end
        else
            if getProperty('controls.UI_LEFT_P') or getProperty('controls.UI_RIGHT_P') then
                changeYes()
            end
            if getProperty('controls.BACK') then
                resetting = false
                cooldown(0.25)
                playSound('cancelMenu', 0.6)
                doTweenAlpha('yesAlphaTween', 'yes', 0, 0.25, 'linear')
                doTweenAlpha('noAlphaTween', 'no', 0, 0.25, 'linear')
                doTweenAlpha('resetAlphaTween', 'resetifgay', 0, 0.25, 'linear')
                doTweenAlpha('resetBlackBGAlphaTween', 'resetBlackBG', 0, 0.25, 'linear')
            end
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
                resetting = false
                cooldown(0.25)
                playSound('cancelMenu', 0.6)
                doTweenAlpha('yesAlphaTween', 'yes', 0, 0.25, 'linear')
                doTweenAlpha('noAlphaTween', 'no', 0, 0.25, 'linear')
                doTweenAlpha('resetAlphaTween', 'resetifgay', 0, 0.25, 'linear')
                doTweenAlpha('resetBlackBGAlphaTween', 'resetBlackBG', 0, 0.25, 'linear')
                if onYes then
                    addHaxeLibrary('Highscore')
                    runHaxeCode([[
                        var theSong = "]]..songsList[curSelected][1]..[[";
                        Highscore.resetSong(theSong, 0);
                    ]]) -- so it actually does it
                    changeSelection(0)
                end
            end
        end
    end
    setProperty('score.x', screenWidth - getProperty('score.width') - 6)
    setProperty('scoreBlackBG.scale.x', screenWidth - getProperty('score.x') + 6)
    setProperty('scoreBlackBG.x', screenWidth - (getProperty('scoreBlackBG.scale.x') / 2))
end
local timesLooped = 0
function cooldown(time)
    canPressKeys = false
    runTimer('asd', time)
end
function onTimerCompleted(t, l, ll)
    if t == 'ae' then
        playMusic('breakfast', 0.75, true)
    end
    if t == 'asd' then
        canPressKeys = true
    end
end
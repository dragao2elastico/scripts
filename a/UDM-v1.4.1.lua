--minecraft f3 moment
--Script version: v1.4.1
--for seeing the full info just scroll down

--[Script Settings]
local enableBoxs = true --if true, boxes will be enabled, false for disable them (useful for optimization)
local boxsAlpha = 0.6 --boxes alpha, 0.6 is the default value
local infoFont = 'vcr' --dont add .ttf at the end
local enableSounds = true --if true, sounds will be enabled, false for disable them
local customWarnText = 'You are on Debug Mode!' --the debug warn text if you wanna customize it
local tweenAnimation = true --if true, tween animations will be displayed when enabling/disabling the debug mode, false for disable them
local versionWarns = true --if true, old psych versions warns will be displayed, false for disable them (not recommended)

--[Editable Keys]--
local enableDebugKey = 'F1' --enable debug mode
local showInfoKey = 'F12' --shows the debug info help
local fullscreenKey = 'F11' --enable fullscreen
local enableBotplayKey = 'B' --enable botplay
local enablePracticeKey = 'G' --enable practice mode
local hideHudKey = 'C' --hide hud
local changeCharKeys = {
    [0] = 'F5', --previous
    [1] = 'F6' --next
}
local moveCharKeys = {
    [0] = 'LEFT', --left
    [1] = 'DOWN', --down
    [2] = 'UP', --up
    [3] = 'RIGHT', --right
    [4] = 'F4' --reset char pos
}
local songFuncKeys = {
    [0] = 'F9', --Restart song
    [1] = 'F10' --Exit Song
}
local zoomKeys = {
    [0] = 'Q', --increase
    [1] = 'E', --decrease
    [2] = 'T' --reset (same for the move cam reset)
}
local moveCamKeys = {
    [0] = 'J', --left
    [1] = 'K', --down
    [2] = 'I', --up
    [3] = 'L' --right
}
local playbackKeys = {
    [0] = 'N', --increase
    [1] = 'M', --decrease
    [2] = 'U' --reset
}
local skipTimeKeys = {
    [0] = 'F7', --decrease
    [1] = 'F8' --increase
}
local scrollSpeedKeys = {
    [0] = 'F2', --decrease
    [1] = 'F3', --increase
    [2] = 'Y' --reset
}



--Script Shit (Don't edit)



local debugMode = false
local playHits = 0
local oppHits = 0
local zoom = 0
local camX = 0
local camY = 0
local skipAble = false
local curTime = 0
local isPaused = false
local textVisible = false
local showInfo = false
local selChar = 'boyfriend'
local originalboyfriendX
local originalboyfriendY
local originaldadX
local originaldadY
local originalgfX
local originalgfY

function onCreatePost()
    luaDeprecatedWarnings = true
    luaDebugMode = true
    setPropertyFromClass('PlayState', 'chartingMode', true)

    --Precache Sounds
    precacheSound('cancelMenu')
    precacheSound('confirmMenu')
    precacheSound('scrollMenu')

    --Texts
    makeLuaText('debugText1', '', 0, -1000, 50)
    setTextSize('debugText1', 18)
    setTextAlignment('debugText1', 'Left')
    setObjectCamera('debugText1', 'other')

    makeLuaText('debugText2', '', 0, -1000, 468)
    setTextSize('debugText2', 18)
    setTextAlignment('debugText2', 'Left')
    setObjectCamera('debugText2', 'other')

    makeLuaText('debugText3', '', 0, 0, -1000)
    setTextSize('debugText3', 18)
    setTextAlignment('debugText3', 'Center')
    setObjectCamera('debugText3', 'other')

    makeLuaText('debugWarn', '['..customWarnText..']', 0, 0, -25)
    setTextSize('debugWarn', 15)
    setTextBorder('debugWarn', 1, '000000')
    setTextColor('debugWarn', 'FF0000')
    setTextAlignment('debugWarn', 'Center')
    setObjectCamera('debugWarn', 'other')

    makeLuaText('healthTxt', '', 0, 10, -25)
    setTextSize('healthTxt', 20)
    setTextAlignment('healthTxt', 'Center')
    setObjectCamera('healthTxt', 'other')

    makeLuaText('dadInfo', '', screenWidth-20, 1000, 10)
    setTextSize('dadInfo', 18)
    setTextAlignment('dadInfo', 'Right')
    setTextBorder('dadInfo', 1, '000000')
    setObjectCamera('dadInfo', 'other')

    makeLuaText('gfInfo', '', screenWidth-20, 1000, 60)
    setTextSize('gfInfo', 18)
    setTextAlignment('gfInfo', 'Right')
    setTextBorder('gfInfo', 1, '000000')
    setObjectCamera('gfInfo', 'other')

    makeLuaText('bfInfo', '', screenWidth-20, 1000, 110)
    setTextSize('bfInfo', 18)
    setTextAlignment('bfInfo', 'Right')
    setTextBorder('bfInfo', 1, '000000')
    setObjectCamera('bfInfo', 'other')

    makeLuaText('selCharTxt', '', screenWidth-20, 1000, 160)
    setTextSize('selCharTxt', 18)
    setTextBorder('selCharTxt', 1, '000000')
    setTextAlignment('selCharTxt', 'Right')
    setObjectCamera('selCharTxt', 'other')

    makeLuaText('practiceTxt', 'Practice Mode', screenWidth-5, 0, 0)
    setTextSize('practiceTxt', 20)
    setTextBorder('practiceTxt', 1, '000000')
    setTextAlignment('practiceTxt', 'Right')
    setObjectCamera('practiceTxt', 'other')
    setProperty('practiceTxt.visible', false)

    makeLuaText('newBotplayTxt', 'Botplay', screenWidth-5, 0, 0)
    setTextSize('newBotplayTxt', 20)
    setTextBorder('newBotplayTxt', 1, '000000')
    setTextAlignment('newBotplayTxt', 'Right')
    setObjectCamera('newBotplayTxt', 'other')
    setProperty('newBotplayTxt.visible', false)

    setTextFont('debugText1', infoFont..'.ttf')
    setTextFont('debugText2', infoFont..'.ttf')
    setTextFont('debugText3', infoFont..'.ttf')
    setTextFont('debugWarn', infoFont..'.ttf')
    setTextFont('healthTxt', infoFont..'.ttf')
    setTextFont('dadInfo', infoFont..'.ttf')
    setTextFont('gfInfo', infoFont..'.ttf')
    setTextFont('bfInfo', infoFont..'.ttf')
    setTextFont('selCharTxt', infoFont..'.ttf')
    setTextFont('newBotplayTxt', infoFont..'.ttf')
    setTextFont('practiceTxt', infoFont..'.ttf')

    --Boxes
    makeLuaSprite('blackBG1', nil, 0, 0)
    makeGraphic('blackBG1', 390, 418, '000000')
    setScrollFactor('blackBG1', 0, 0)
    setObjectCamera('blackBG1', 'other')

    makeLuaSprite('blackBG2', nil, 0, 0)
    makeGraphic('blackBG2', 249, 238, '000000')
    setScrollFactor('blackBG2', 0, 0)
    setObjectCamera('blackBG2', 'other')

    makeLuaSprite('blackBG3', nil, 0, 0)
    makeGraphic('blackBG3', 450, 510, '000000')
    setScrollFactor('blackBG3', 0, 0)
    setObjectCamera('blackBG3', 'other')

    makeLuaSprite('blackBG4', nil, 0, 0)
    makeGraphic('blackBG4', 410, 182, '000000')
    setScrollFactor('blackBG4', 0, 0)
    setObjectCamera('blackBG4', 'other')

    for i = 1,4 do
        if enableBoxs then
            addLuaSprite('blackBG'..i, false)
            setProperty('blackBG'..i..'.alpha', boxsAlpha)
        end
    end
    for i = 1,3 do
        addLuaText('debugText'..i)
    end
    addLuaText('debugWarn')
    addLuaText('healthTxt')
    addLuaText('dadInfo')
    addLuaText('gfInfo')
    addLuaText('bfInfo')
    addLuaText('selCharTxt')
    addLuaText('practiceTxt')
    addLuaText('newBotplayTxt')

    if not tweenAnimation then
        setProperty('debugText1.x', 10)
        setProperty('debugText2.x', 10)
        setProperty('dadInfo.x', 10)
        setProperty('gfInfo.x', 10)
        setProperty('bfInfo.x', 10)
        setProperty('selCharTxt.x', 10)
        setProperty('debugWarn.y', 10)
        setProperty('healthTxt.y', getProperty('healthBar.y')-30)

        setProperty('debugText1.visible', false)
        setProperty('debugText2.visible', false)
        setProperty('dadInfo.visible', false)
        setProperty('gfInfo.visible', false)
        setProperty('bfInfo.visible', false)
        setProperty('selCharTxt.visible', false)
        setProperty('debugWarn.visible', false)
        setProperty('healthTxt.visible', false)
    else
        textVisible = true
    end

    originalboyfriendX = getProperty('boyfriend.x')
    originalboyfriendY = getProperty('boyfriend.y')
    originaldadX = getProperty('dad.x')
    originaldadY = getProperty('dad.y')
    originalgfX = getProperty('gf.x')
    originalgfY = getProperty('gf.y')
    dcz = getProperty('defaultCamZoom')
    originalCamX = getProperty('camFollowPos.x')
    originalCamY = getProperty('camFollowPos.y')
    playbackOriginal = getProperty('playbackRate')
    zoom = getProperty('camGame.zoom')
    camX = getProperty('camFollowPos.x')
    camY = getProperty('camFollowPos.y')
    ogSongSpeed = getProperty('songSpeed')
    if version == '0.6.3' then
        altCurStage = curStage
        altDifficultyPath = difficultyPath
        altSongPath = songPath
        altPlaybackRate = getProperty('playbackRate')
    else
        if versionWarns then
            debugPrint('This script would not work properly on Psych engine v', version, '. Try using the latest version. (0.6.3)')
        end
        altCurStage = getPropertyFromClass('PlayState', 'curStage')
        altDifficultyPath = difficultyName:lower():gsub('%s+', '-')
        altSongPath = songName:lower():gsub('%s+', '-')
        altPlaybackRate = 'Not supported'
    end
end

function onUpdatePost()
    if keyboardJustPressed(enableDebugKey) then
        if debugMode then
            debugMode = false
            barThing = false
            if enableSounds then
                playSound('cancelMenu', 1)
            end
            if tweenAnimation then
                doTweenX('tweenX1a', 'debugText1', -1000, 1, 'cubeIn')
                doTweenX('tweenX1b', 'debugText2', -1000, 1.1, 'cubeIn')

                doTweenX('XDtweenX1a', 'dadInfo', 1000, 1, 'cubeIn')
                doTweenX('XDtweenX1b', 'gfInfo', 1000, 1.1, 'cubeIn')
                doTweenX('XDtweenX1c', 'bfInfo', 1000, 1.2, 'cubeIn')
                doTweenX('XDtweenX1d', 'selCharTxt', 1000, 1.3, 'cubeIn')

                doTweenY('tweenY1a', 'debugWarn', -25, 1, 'cubeIn')
                doTweenY('tweenY1b', 'healthTxt', -25, 1.1, 'cubeIn')

                if showInfo then
                    doTweenY('tilinxdY1', 'debugText3', -1000, 1, 'cubeIn')
                    showInfo = false
                end
            else
                textVisible = false
                setProperty('debugText1.visible', false)
                setProperty('debugText2.visible', false)
                setProperty('dadInfo.visible', false)
                setProperty('gfInfo.visible', false)
                setProperty('bfInfo.visible', false)
                setProperty('selCharTxt.visible', false)
                setProperty('debugWarn.visible', false)
                setProperty('healthTxt.visible', false)
            end
        else
            debugMode = true
            barThing = true
            if enableSounds then
                playSound('confirmMenu', 1)
            end
            if tweenAnimation then
                doTweenX('tweenX2a', 'debugText1', 10, 1, 'cubeOut')
                doTweenX('tweenX2b', 'debugText2', 10, 1.1, 'cubeOut')

                doTweenX('XDtweenX2a', 'dadInfo', 10, 1, 'cubeOut')
                doTweenX('XDtweenX2b', 'gfInfo', 10, 1.1, 'cubeOut')
                doTweenX('XDtweenX2c', 'bfInfo', 10, 1.2, 'cubeOut')
                doTweenX('XDtweenX2d', 'selCharTxt', 10, 1.3, 'cubeOut')

                doTweenY('tweenY2a', 'debugWarn', 10, 1, 'cubeIn')
                doTweenY('tweenY2b', 'healthTxt', getProperty('healthBar.y')-30, 1.1, 'cubeIn')
            else
                textVisible = true
                setProperty('debugText1.visible', true)
                setProperty('debugText2.visible', true)
                setProperty('dadInfo.visible', true)
                setProperty('gfInfo.visible', true)
                setProperty('bfInfo.visible', true)
                setProperty('selCharTxt.visible', true)
                setProperty('debugWarn.visible', true)
                setProperty('healthTxt.visible', true)
            end

            doTweenAlpha('1a', 'practiceTxt', 0, 1, 'cubeInOut')
            doTweenAlpha('1b', 'newBotplayTxt', 0, 1, 'cubeInOut')
        end
    end
    if debugMode then
        local amountPos = (keyboardPressed('SHIFT') and 10 or 2)
        local amountCharPos = (keyboardPressed('SHIFT') and 5 or 1)
        local amountZoom = (keyboardPressed('SHIFT') and 0.01 or 0.005)
        local amountTime = (keyboardPressed('SHIFT') and 10000 or 5000)
        local amountPB = 0.05
        local amountSpeed = 0

        if amountTime == 5000 then
            aexd = 5000
        elseif amountTime == 10000 then
            aexd = 10000
        end

        --Song Functions
        if keyboardJustPressed(songFuncKeys[0]) then
            restartSong()
        end
        if keyboardJustPressed(songFuncKeys[1]) then
            exitSong()
        end

        --Show Info
        if keyboardJustPressed(showInfoKey) then
            if not showInfo then
                showInfo = true
                doTweenY('tilinxdY2', 'debugText3', 150, 1, 'cubeOut')
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
            else
                showInfo = false
                doTweenY('tilinxdY1', 'debugText3', -1000, 1, 'cubeIn')
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
            end
        end

        --Changeable Character Thing
        if keyboardJustPressed(changeCharKeys[1]) then
            if selChar == 'boyfriend' then
                selChar = 'dad'
            elseif selChar == 'dad' then
                selChar = 'gf'
            elseif selChar == 'gf' then
                selChar = 'boyfriend'
            end
        elseif keyboardJustPressed(changeCharKeys[0]) then
            if selChar == 'boyfriend' then
                selChar = 'gf'
            elseif selChar == 'dad' then
                selChar = 'boyfriend'
            elseif selChar == 'gf' then
                selChar = 'dad'
            end
        end
        setTextString('selCharTxt', 'Selected Char: '..selChar)

        --Playback Rate
        if version == '0.6.3' then
            if getProperty('playbackRate') < 0.05 then
                amountPB = 0
            end
            if getProperty('playbackRate') > 0.05 then
                amountPB = 0.05
            end
            if keyboardJustPressed(playbackKeys[1]) then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                amountPB = 0.05
                setProperty('playbackRate', getProperty('playbackRate') + amountPB)
            elseif keyboardJustPressed(playbackKeys[0]) then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('playbackRate', getProperty('playbackRate') - amountPB)
            elseif keyboardJustPressed(playbackKeys[2]) then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('playbackRate', playbackOriginal)
            end
        else
            if keyboardJustPressed(playbackKeys[1]) then
                if version == '0.6.3' then
                else
                    if versionWarns then
                        debugPrint('Playback rate is not compatible with Psych engine ', version, 'or below')
                    end
                end
            elseif keyboardJustPressed(playbackKeys[0]) then
                if version == '0.6.3' then
                else
                    if versionWarns then
                        debugPrint('Playback rate is not compatible with Psych engine ', version, 'or below')
                    end
                end
            elseif keyboardJustPressed(playbackKeys[2]) then
                if version == '0.6.3' then
                else
                    if versionWarns then
                        debugPrint('Playback rate is not compatible with Psych engine ', version, 'or below')
                    end
                end
            end
        end

        --Skip Time
        if getPropertyFromClass('Conductor', 'songPosition') < aexd then
            amountTime = 0
        end
        if getPropertyFromClass('Conductor', 'songPosition') > aexd then
            amountTime = (keyboardPressed('SHIFT') and 10000 or 5000)
        end
        if keyboardJustPressed(skipTimeKeys[0]) and skipAble then  --taken this from some Unholywanderer04#1468 code, support the chad B)
            curTime = getPropertyFromClass('Conductor', 'songPosition')
            setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - amountTime)
            setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
            setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
        elseif keyboardJustPressed(skipTimeKeys[1]) and skipAble then
            curTime = getPropertyFromClass('Conductor', 'songPosition')
            amountTime = (keyboardPressed('SHIFT') and 10000 or 5000)
            setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + amountTime)
            setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
            setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
        end

        --Scroll Speed
        if getProperty('songSpeed') < 0.2 then
            amountSpeed = 0
        end
        if getProperty('songSpeed') > 0.2 then
            amountSpeed = 0.1
        end

        if keyboardJustPressed(scrollSpeedKeys[0]) then
            if enableSounds then
                playSound('scrollMenu', 1)
            end
            setProperty('songSpeed', getProperty('songSpeed')-amountSpeed)
        elseif keyboardJustPressed(scrollSpeedKeys[1]) then
            if enableSounds then
                playSound('scrollMenu', 1)
            end
            amountSpeed = 0.1
            setProperty('songSpeed', getProperty('songSpeed')+amountSpeed)
        elseif keyboardJustPressed(scrollSpeedKeys[2]) then
            if enableSounds then
                playSound('scrollMenu', 1)
            end
            setProperty('songSpeed', ogSongSpeed)
        end

        --Move Character
        if keyboardPressed(moveCharKeys[0]) then -- Move Char Left
            setProperty(selChar..'.x', getProperty(selChar..'.x')-amountCharPos)
        end
        if keyboardPressed(moveCharKeys[3]) then -- Move Char Right
            setProperty(selChar..'.x', getProperty(selChar..'.x')+amountCharPos)
        end
        if keyboardPressed(moveCharKeys[1]) then -- Move Char Up
            setProperty(selChar..'.y', getProperty(selChar..'.y')+amountCharPos)
        end
        if keyboardPressed(moveCharKeys[2]) then -- Move Char Down
            setProperty(selChar..'.y', getProperty(selChar..'.y')-amountCharPos)
        end
        if keyboardJustPressed(moveCharKeys[4]) then
            if selChar == 'boyfriend' then
                setProperty('boyfriend.y', originalboyfriendY)
                setProperty('boyfriend.x', originalboyfriendX)
            elseif selChar == 'dad' then
                setProperty('dad.y', originaldadY)
                setProperty('dad.x', originaldadX)
            elseif selChar == 'gf' then
                setProperty('gf.y', originalgfY)
                setProperty('gf.x', originalgfX)
            end
        end

        --Change Camera Zoom
        if keyboardPressed(zoomKeys[1]) then -- Add zoom
            zoom = zoom + amountZoom
        end
        if keyboardPressed(zoomKeys[0]) then -- Remove zoom
            zoom = zoom - amountZoom
        end

        --Change Camera Pos
        if keyboardPressed(moveCamKeys[0]) then -- Move Left
            camX = camX - amountPos
        end
        if keyboardPressed(moveCamKeys[3]) then -- Move Right
            camX = camX + amountPos
        end
        if keyboardPressed(moveCamKeys[1]) then -- Move Up
            camY = camY + amountPos
        end
        if keyboardPressed(moveCamKeys[2]) then -- Move Down
            camY= camY - amountPos
        end
        if keyboardJustPressed(zoomKeys[2]) then
            if enableSounds then
                playSound('scrollMenu', 1)
            end
            camX = originalCamX
            camY = originalCamY
            zoom = dcz
        end
        setProperty('camGame.zoom', zoom)
        triggerEvent('Camera Follow Pos',camX,camY)

        --More Shit
        if keyboardJustPressed(enableBotplayKey) then
            if getProperty('cpuControlled') then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('cpuControlled', false)
            else
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('cpuControlled', true)
            end
        end

        if keyboardJustPressed(enablePracticeKey) then
            if getProperty('practiceMode') then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('practiceMode', false)
                setProperty('practiceTxt.visible', false)
            else
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setProperty('practiceMode', true)
                setProperty('practiceTxt.visible', true)
            end
        end

        if keyboardJustPressed(fullscreenKey) then
            if not getPropertyFromClass("openfl.Lib", "application.window.fullscreen") then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setPropertyFromClass("openfl.Lib", "application.window.fullscreen", true)
            else
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                setPropertyFromClass("openfl.Lib", "application.window.fullscreen", false)
            end
        end

        if keyboardJustPressed(hideHudKey) then
            if hideTheHud then
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                hideTheHud = false
                setProperty('camHUD.visible', true)
            else
                if enableSounds then
                    playSound('scrollMenu', 1)
                end
                hideTheHud = true
                setProperty('camHUD.visible', false)
            end
        end
    else
        triggerEvent('Camera Follow Pos',nil,nil)
    end
    --Debug Boxes
    setProperty('blackBG1.x', getProperty('debugText1.x')-5)
    setProperty('blackBG1.y',getProperty('debugText1.y')-5)

    setProperty('blackBG2.x', getProperty('debugText2.x')-5)
    setProperty('blackBG2.y',getProperty('debugText2.y')-5)

    setProperty('blackBG3.x', getProperty('debugText3.x')-5)
    setProperty('blackBG3.y',getProperty('debugText3.y')-5)

    setProperty('blackBG4.x', getProperty('dadInfo.x')-5+860)
    setProperty('blackBG4.y',getProperty('dadInfo.y')-5)

    setProperty('blackBG1.visible', textVisible)
    setProperty('blackBG2.visible', textVisible)
    setProperty('blackBG3.visible', textVisible)
    setProperty('blackBG4.visible', textVisible)

    --Debug Texts

    setTextString('healthTxt', 'Health: '..math.floor(getProperty('health')*50)..'%')
    screenCenter('healthTxt', 'x')

    setTextString('debugText2', 'BlueBalled: '..getPropertyFromClass('PlayState', 'deathCounter')..'\n\nHits: '..playHits..'\nOpp Hits: '..oppHits..'\n\nCombo: '..getProperty('combo')..'\nSicks: '..getProperty('sicks')..'\nGoods: '..getProperty('goods')..'\nBads: '..getProperty('bads')..'\nShits: '..getProperty('shits')..'\n\nPsych Version: '..version..'\n\nBuild Target: '..buildTarget..'\n')

    setTextString('debugText3', 'Press '..enableBotplayKey..' for enable Botplay\n\nPress '..enablePracticeKey..' for enable Practice Mode\n\nPress '..hideHudKey..' for hide Hud\n\nPress '..fullscreenKey..' for fullscreen\n\nPress '..zoomKeys[0]..'/'..zoomKeys[1]..' for Zoom\n(Press SHIFT for X5 Multiplier speed)\nPress '..zoomKeys[2]..' for reset Zoom\n\nPress '..moveCamKeys[0]..'/'..moveCamKeys[1]..'/'..moveCamKeys[2]..'/'..moveCamKeys[3]..' for move the cam\n(Press SHIFT for X5 Multiplier speed)\nPress '..zoomKeys[2]..' for reset Camera position\n\nPress '..playbackKeys[0]..'/'..playbackKeys[1]..' for change Playback Rate\nPress '..playbackKeys[2]..' for reset Playback Rate\n\nPress '..skipTimeKeys[0]..'/'..skipTimeKeys[1]..' for skip time\n\nPress '..scrollSpeedKeys[0]..'/'..scrollSpeedKeys[1]..' for change Scroll Speed\nPress '..scrollSpeedKeys[2]..' for reset ScrollSpeed\n\nPress '..moveCharKeys[0]..'/'..moveCharKeys[1]..'/'..moveCharKeys[2]..'/'..moveCharKeys[3]..' for move char\n(Press SHIFT for X5 Multiplier speed)\nPress '..moveCharKeys[4]..' for reset char pos\nPress '..changeCharKeys[0]..'/'..changeCharKeys[1]..' for change Selected Char\n\nPress '..songFuncKeys[0]..' for Reset song\nPress '..songFuncKeys[1]..' for Exit song\n')
    screenCenter('debugText3', 'x')

    if not isStoryMode then
        if not updateTilin then
            setTextString('debugText1', 'Song: '..songName..'\n(Song Path: "'..altSongPath..'")\n\nDifficulty: '..difficultyName..' ['..difficulty..']\n(Diff Path: "'..altDifficultyPath..'")\n\nCurStage: '..altCurStage..'\n\nCurStep: '..curStep..'\n\nCurBeat: '..curBeat..'\n\nCurSection: 0\n\nCurBPM: '..curBpm..'\n\nDefaultZoom: '..dcz..'\n\nCamera Pos: (X: '..camX..', Y: '..camY..')\n\nScroll Speed: '..getProperty('songSpeed')..'\n\nPlayback Rate: '..altPlaybackRate..'\n')
        else
            setTextString('debugText1', 'Song: '..songName..'\n(Song Path: "'..altSongPath..'")\n\nDifficulty: '..difficultyName..' ['..difficulty..']\n(Diff Path: "'..altDifficultyPath..'")\n\nCurStage: '..altCurStage..'\n\nCurStep: '..curStep..'\n\nCurBeat: '..curBeat..'\n\nCurSection: '..curSection..'\n\nCurBPM: '..curBpm..'\n\nDefaultZoom: '..dcz..'\n\nCamera Pos: (X: '..camX..', Y: '..camY..')\n\nScroll Speed: '..getProperty('songSpeed')..'\n\nPlayback Rate: '..altPlaybackRate..'\n')
        end
    else
        if not updateTilin then
            setTextString('debugText1', 'Song: '..songName..'\n(Song Path: "'..altSongPath..'")\n\nDifficulty: '..difficultyName..' ['..difficulty..']\n(Diff Path: "'..altDifficultyPath..'")\n\nWeek: '..week..' ['..weekRaw..']\n\nCurStage: '..altCurStage..'\n\nCurStep: '..curStep..'\n\nCurBeat: '..curBeat..'\n\nCurSection: 0\n\nCurBPM: '..curBpm..'\n\nDefaultZoom: '..dcz..'\n\nCamera Pos: (X: '..camX..', Y: '..camY..')\n\nScroll Speed: '..getProperty('songSpeed')..'\n\nPlayback Rate: '..altPlaybackRate..'\n')
        else
            setTextString('debugText1', 'Song: '..songName..'\n(Song Path: "'..altSongPath..'")\n\nDifficulty: '..difficultyName..' ['..difficulty..']\n(Diff Path: "'..altDifficultyPath..'")\n\nWeek: '..week..' ['..weekRaw..']\n\nCurStage: '..altCurStage..'\n\nCurStep: '..curStep..'\n\nCurBeat: '..curBeat..'\n\nCurSection: '..curSection..'\n\nCurBPM: '..curBpm..'\n\nDefaultZoom: '..dcz..'\n\nCamera Pos: (X: '..camX..', Y: '..camY..')\n\nScroll Speed: '..getProperty('songSpeed')..'\n\nPlayback Rate: '..altPlaybackRate..'\n')
        end
    end

    if getProperty('health') > 0.5 then
        setTextColor('healthTxt', 'FFFFFF')
    elseif getProperty('health') < 0.5 then
        setTextColor('healthTxt', 'FF0000')
    end

    if barThing then
        setTextString('timeTxt', formatTime(getSongPosition() - noteOffset) .. ' / ' .. formatTime(songLength))
    else
    end

    setTextString('dadInfo', 'Opp Cur Anim: '..getProperty('dad.animation.name')..'\nOpp Cur Character: '..getProperty('dad.curCharacter')..'\nOpp Position: (X:'..getProperty('dad.x')..', Y:'..getProperty('dad.y')..')')
    setTextColor('dadInfo', getHealthColor('dad'))
    setTextString('gfInfo', 'GF Cur Anim: '..getProperty('gf.animation.name')..'\nGF Cur Character: '..getProperty('gf.curCharacter')..'\nGF Position: (X:'..getProperty('gf.x')..', Y:'..getProperty('gf.y')..')')
    setTextColor('gfInfo', getHealthColor('gf'))
    setTextString('bfInfo', 'BF Cur Anim: '..getProperty('boyfriend.animation.name')..'\nBF Cur Character: '..getProperty('boyfriend.curCharacter')..'\nBF Position: (X:'..getProperty('boyfriend.x')..', Y:'..getProperty('boyfriend.y')..')')
    setTextColor('bfInfo', getHealthColor('boyfriend'))

    screenCenter('debugText3', 'x')
    screenCenter('debugWarn', 'x')

    setProperty('practiceTxt.y', screenHeight-5-getTextSize('practiceTxt'))
    setProperty('newBotplayTxt.y', getProperty('practiceTxt.y')-getTextSize('newBotplayTxt'))

    setProperty('botplayTxt.visible', false)

    --Updating other things
    if getProperty('cpuControlled') then
        setProperty('newBotplayTxt.visible', true)
    else
        setProperty('newBotplayTxt.visible', false)
    end

    if getProperty('practiceMode') then
        setProperty('practiceTxt.visible', true)
    else
        setProperty('practiceTxt.visible', false)
    end
end

function onSectionHit()
    if curSection == 1 then
        updateTilin = true
    end
end

function onSongStart()
    skipAble = true
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
        oppHits = oppHits + 1
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote then
        playHits = playHits + 1
    end
end

function rgbToHex(r, g, b)
    return string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

function getHealthColor(arg)
    return rgbToHex(getProperty(arg..'.healthColorArray[0]'), getProperty(arg..'.healthColorArray[1]'), getProperty(arg..'.healthColorArray[2]'))
end

function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)  
end

function onTweenCompleted(teg)
    if teg == '1a' then
        doTweenAlpha('2a', 'practiceTxt', 1, 1, 'cubeInOut')
    end
    if teg == '1b' then
        doTweenAlpha('2b', 'newBotplayTxt', 1, 1, 'cubeInOut')
    end

    if teg == '2a' then
        doTweenAlpha('1a', 'practiceTxt', 0, 1, 'cubeInOut')
    end
    if teg == '2b' then
        doTweenAlpha('1b', 'newBotplayTxt', 0, 1, 'cubeInOut')
    end
end

--[[
=====[Credits]=====
Ultimate Debug Mode (UDM) script by DuduGD2023#6164 aka me lol
Thanks superpowers04#3887 for helping me with the camera zoom/moving
Script inspired by Villagecool#6293
Also thanks to the psych engine server

=====[Info may you need]=====
1.- I dont really care about credits because i did this script for fun
2.- Tried my best doing this script
3.- Os Engine could bug the script (why would you use os engine?)
4.- enjoy this script :D feel free to edit it

=====[Full Change-Log]=====

v1 [I didn't found the link]
original script, first version, literally added everything lol

v1.1 [I didn't found the link]
Changeable keys
Added sounds

v1.1.1 [https://cdn.discordapp.com/attachments/1063985584206528532/1064019958952099940/ultimateDebugMode-v1.1.1.lua]
Optional bool sounds

v1.1.2 (Bug fix) [https://cdn.discordapp.com/attachments/1063985584206528532/1064155593805398086/ultimateDebugMode-v1.1.2.lua]
Removed "currentModDirectory" cuz OS engine error (at line 190)

v1.2 [https://cdn.discordapp.com/attachments/1063985584206528532/1064284653764219042/ultimateDebugMode-v1.2.lua]
Added optional black boxes
Changeable texts font

v1.2.1 [https://cdn.discordapp.com/attachments/1063985584206528532/1064375292199702576/ultimateDebugMode-v1.2.1.lua]
Replaced getPropertyFromClass() with keyboardJustPressed() and keyboardPressed()

v1.3 [https://cdn.discordapp.com/attachments/1063985584206528532/1068198867855736902/ultimateDebugMode-v1.3.lua]
Function to skip time
Exit song and restart song buttons

v1.3.1 (Bug fix) [https://cdn.discordapp.com/attachments/1063985584206528532/1068296346957774909/ultimateDebugMode-v1.3.1.lua]
Always enabled Charting mode
Added a comma (at line 46)

v1.4 [https://cdn.discordapp.com/attachments/1063985584206528532/1071520929332592640/UDM-v1.4.lua]
Remaked Debug HUD
Added optional tweens when enabling debug mode
Customizable debug warn text
Added Practice mode button
Added limits to some editable values (like playback rate, scroll speed, skip time, etc...)
Added F12 button for displaying debug info
Some bugs fix

v1.4.1 [This is the current version lol]
Psych engine v0.6.2 support
Added optional old psych versions warns
Added blueballed counter
Some bug fix
]]
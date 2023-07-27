--[[
    Version: 1.0.0
    Author: Ralsi (https://gamebanana.com/members/1939328)
    GB Page: https://gamebanana.com/mods/442907
    Crediting: If used in a mod, not necessary, but very much appreciated. Do not remove or edit all this info tho.
]]--

-- you can either change this (dont forget to remove those from onGameOver function) or GameOverSubstate class variables
DEATH_SOUND = nil   --'fnf_loss_sfx'
THEME = nil         --'gameOver'
CONFIRM_SOUND = nil --'gameOverEnd'
SPRITE = nil


-- [[ C0D3 ]] --
local bfx, bfy = 0, 0
local confirmed = false
local bfOrder = nil
function onGameOver()
    bfOrder = getObjectOrder('boyfriendGroup')
    if not DEATH_SOUND then DEATH_SOUND = getPropertyFromClass('GameOverSubstate', 'deathSoundName') end
    if not THEME then THEME = getPropertyFromClass('GameOverSubstate', 'loopSoundName') end
    if not CONFIRM_SOUND then CONFIRM_SOUND = getPropertyFromClass('GameOverSubstate', 'endSoundName') end
    if not SPRITE then SPRITE = getPropertyFromClass('GameOverSubstate', 'characterName') end
    runHaxeCode([[
        game.boyfriend.alpha = 0;
        var scale = game.boyfriend.scale;
        game.boyfriend = new Boyfriend(game.boyfriend.positionArray[0], game.boyfriend.positionArray[1], ']] .. SPRITE .. [[');
        game.boyfriend.scale = scale;
        game.boyfriendGroup.add(game.boyfriend);
        game.boyfriend.playAnim('firstDeath', true);
        var offset = game.boyfriend.offset;
        game.boyfriend.offset.set(offset.x*scale.x, offset.y*scale.y);
        game.boyfriend.drawFrame();
    ]])
    bfx, bfy = getGraphicMidpointX('boyfriend')-100, getGraphicMidpointY('boyfriend')-100
    openCustomSubstate('gayOverScreen', true)
    return Function_Stop
end

function onCustomSubstateCreatePost(name)
    if not name == 'gayOverScreen' then return end
    runHaxeCode([[
        FlxG.sound.music.stop();
        Conductor.songPosition = 0;
        FlxG.sound.play(Paths.sound(']] .. DEATH_SOUND .. [['));
        game.setOnLuas('inGameOver', true);
        var cams = game.variables.get('customCameras');
        if (cams != null) { for (camera in cams) camera.alpha = 0; }
        game.camHUD.alpha = 0;
        game.camOther.alpha = 0;
        var camDeath = new FlxCamera();
        camDeath.bgColor = 0x00000000;
        FlxG.cameras.add(camDeath, false);
        game.variables.set("camDeath", camDeath);
    ]])

    addSprite(0, 'GOS_bg', 0, 0, '', screenWidth*4, screenHeight*4, '0xFF000000')
    addSprite(0, 'GOS_fg', 0, 0, '', screenWidth, screenHeight, '0xFF000000', true)
    setProperty('GOS_bg.alpha', 0)
    setProperty('GOS_fg.alpha', 0)
    screenCenter('GOS_bg')
    screenCenter('GOS_fg')

    doTweenAlpha('gosalph', 'GOS_bg', 0.8, 0.3, 'quartOut')
    doTweenZoom('GOSzoom', 'camGame', 1, 1, 'quartout')
    doTweenX('cmfpx', 'camFollowPos', bfx, 2, 'quartOut')
    doTweenY('cmfpy', 'camFollowPos', bfy, 2, 'quartOut')
end

function onCustomSubstateUpdate(name, elapsed)
    if not name == 'gayOverScreen' then return end
    runHaxeCode('game.boyfriend.update(' .. elapsed .. ');')
    if confirmed then return end
    runHaxeCode([[
        if (game.boyfriend.animation.name == 'firstDeath' && game.boyfriend.animation.curAnim.finished){
            FlxG.sound.playMusic(Paths.music(']] .. THEME .. [['));
            game.boyfriend.playAnim('deathLoop', true);
            var offset = game.boyfriend.offset;
            var scale = game.boyfriend.scale;
            game.boyfriend.offset.set(offset.x*scale.x, offset.y*scale.y);
        }
    ]])
    if keyJustPressed('accept') then
        confirmed = true
        runHaxeCode([[
            game.boyfriend.playAnim('deathConfirm', true);
            var offset = game.boyfriend.offset;
            var scale = game.boyfriend.scale;
            game.boyfriend.offset.set(offset.x*scale.x, offset.y*scale.y);
            FlxG.sound.music.stop();
            FlxG.sound.play(Paths.music(']] .. CONFIRM_SOUND .. [['));
        ]])
        doTweenAlpha('gosalph2', 'GOS_fg', 1, 2, 'linear')
        runTimer('GOSconfirm', 2.5)
    elseif keyJustPressed('back') then
        confirmed = true
        setProperty('GOS_fg.alpha', 1)
        exitSong()
    end
end

function onTweenCompleted(tag)
    if tag == 'GOSzoom' then doTweenZoom('GOSzoom', 'camGame', 0.85, 30, 'linear') end
end

function onTimerCompleted(tag)
    if tag == 'GOSconfirm' then restartSong() end
end

function addSprite(pos, tag, x, y, img, width, height, color, putOnHUD)
    makeLuaSprite(tag, img, x, y)
    if not img or img == '' then makeGraphic(tag, width, height, color) end
    height = height and height > 0 and height or width
    setGraphicSize(tag, width, height)
    setObjectOrder(tag, bfOrder + pos)
    setScrollFactor(tag, 0, 0)
    if putOnHUD then runHaxeCode('game.getLuaObject("' .. tag .. '").camera = game.variables.get("camDeath");') end
    addLuaSprite(tag)
end

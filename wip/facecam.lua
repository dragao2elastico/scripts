function onCreatePost()
    addHaxeLibrary('FlxSprite', 'flixel')
    addHaxeLibrary('FlxCamera', 'flixel')
    luaDebugMode = true

    runHaxeCode([[

        ballsCamGame = new FlxCamera();
        ballsCamGame.copyFrom(game.camGame);
        ballsCamGame.x = 0;
        ballsCamGame.y = 0;
        ballsCamGame.width = 320;
        ballsCamGame.height = 240;
        ballsCamGame.zoom = 0.8;

        ballsCamGame.scroll.x = game.boyfriend.getMidpoint().x - 150;
        ballsCamGame.scroll.x = ballsCamGame.scroll.x - (game.boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0]);
        ballsCamGame.scroll.y = game.boyfriend.getMidpoint().y - 175;
        ballsCamGame.scroll.y = ballsCamGame.scroll.y + (game.boyfriend.cameraPosition[1] - game.boyfriendCameraOffset[1]);

        ballsCamGame.target = null;

        FlxG.cameras.add(ballsCamGame);
        FlxCamera.defaultCameras = [ballsCamGame, game.camGame];

    ]])
end
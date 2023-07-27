local player = 'dad'
function onSongStart()
    setProperty(player..'.visible',false)
           
    -- change window stuff here
    runHaxeCode([[
        windowDad = Application.current.createWindow({
            title: 'Dad Sprites',
            width: 420,
            height: 350,
            borderless: false,
            alwaysOnTop: true
    
        });
        ]])
    
    --just ignore down below unless you know it
    
    













    
    runHaxeCode([[
        Application.current.window.focus();
    
        FlxG.mouse.useSystemCursor = false;
        FlxG.autoPause = false;
    
        
    
            windowDad.x = 10;
            windowDad.y = 50;
         dadWin = new Sprite();
        var dadScrollWin = new Sprite();
        windowDad.stage.addEventListener("keyDown", FlxG.keys.onKeyDown);
        windowDad.stage.addEventListener("keyUp", FlxG.keys.onKeyUp);
        var m = new Matrix();
    
      
    
        
        dadWin.graphics.beginBitmapFill(game.dad.pixels, m);
        dadWin.graphics.drawRect(0, 0, game.dad.pixels.width, game.dad.pixels.height);
        dadWin.graphics.endFill();
        windowDad.stage.addChild(dadWin);
        dadWin.scaleX = 0.7;
        dadWin.scaleY = 0.7;
    
    ]])
    end




    function onUpdate(elapsed)
            runHaxeCode([[  
        
                var dadFrame = game.dad._frame;
                
                if (dadFrame == null || dadFrame.frame == null) return; // prevents crashes (i think???)
                    
                var rect = new Rectangle(dadFrame.frame.x, dadFrame.frame.y, dadFrame.frame.width, dadFrame.frame.height);
                
                dadWin.scrollRect = rect;
                dadWin.x = (((dadFrame.offset.x) - (game.dad.offset.x / 2)) * dadWin.scaleX);
                dadWin.y = (((dadFrame.offset.y) - (game.dad.offset.y / 2)) * dadWin.scaleY);   
    
                ]])
        
    end

    function onCreate()
        addHaxeLibrary('Lib', 'openfl')
        addHaxeLibrary('Application', 'openfl.display')
        addHaxeLibrary('Application', 'lime.app')
        addHaxeLibrary('FlxG', 'flixel')
        addHaxeLibrary('Matrix', 'openfl.geom')
        addHaxeLibrary('Rectangle', 'openfl.geom')
        addHaxeLibrary('Sprite', 'openfl.display')
    end
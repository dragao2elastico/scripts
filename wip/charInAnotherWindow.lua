--    CREDITS TIME   --
--[[

First of all this is a port based from this : https://github.com/DuskieWhy/Transparent-and-MultiWindow-FNF
            People who did the original one:
            [  

              [DuskieWhy] (https://twitter.com/DuskieWhy)
              [TaeYai] (https://twitter.com/TaeYai)
              [BreezyMelee] (https://twitter.com/BreezyMelee)
              [YoshiCrafter] (https://twitter.com/YoshiCrafter29) - Additional help
              [KadeDev] (https://twitter.com/kade0912) - Transparent window .hx file code

            ]

The Person that Port Multi Window with Character
[

 [Laztrix] (https://twitter.com/LaztTheRix) (Laztrix#5670) - made a fix for the dad frame not updating
 [gaminbottomtext#3433] - help a bit stuff 

]

The Person that Make Transparent Window possible in Lua (or something idk)
[

    [Mayo78#7878]

]

aight thats all. love you (no gay)
]]--

function onSongStart()
    setProperty('dad.visible',false)
           
    -- change window stuff here
    runHaxeCode([[
        windowDad = Application.current.createWindow({
            title: 'dad vision',
            width: 720,
            height: 600,
            borderless: false,
            alwaysOnTop: true
            // it fucked up NOOOO /j
        });
               ]])

setTransparency(0x00010101) -- holy... is that amongus

        runHaxeCode([[
                // want to put the window somewhere? change value below
                windowDad.x = 10;   
                windowDad.y = 50;


                // none of your business
                Application.current.window.focus();
    
                FlxG.mouse.useSystemCursor = true;
                FlxG.autoPause = false;
                // fr???
            ]])
    
    runHaxeCode([[
    // owo whats this :clueless:
         dadWin = new Sprite();
        var dadScrollWin = new Sprite();
        windowDad.stage.addEventListener("keyDown", FlxG.keys.onKeyDown);
        windowDad.stage.addEventListener("keyUp", FlxG.keys.onKeyUp);
        var m = new Matrix();

        // color code from https://hexcolor16.com/101010
        // to get color codes go here: https://hexcolor16.com click on the color you want and under hex color information find win32 representation
        //color code shoud be after DWROD COLORREF dont change the color code for this one tho, will break transparency
        
        var sprite = new Sprite ();
		sprite.graphics.beginFill (0x00010101);
		sprite.graphics.drawRect (0, 0, windowDad.width, windowDad.height);
    
        dadWin.graphics.beginBitmapFill(game.dad.pixels, m);
        dadWin.graphics.drawRect(0, 0, game.dad.pixels.width, game.dad.pixels.height);
        dadWin.graphics.endFill();
        windowDad.stage.addChild(sprite);
        windowDad.stage.addChild(dadWin);

    // hey you. yeah you, does the character being too small or too big? you can change below
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


             // you see 0 in there? you can change it.
            // if you feels like the character being not the where you wanted change it
                dadWin.x = ( 0 + ((dadFrame.offset.x) - (game.dad.offset.x / 2)) * dadWin.scaleX);
                dadWin.y = ( 0 + ((dadFrame.offset.y) - (game.dad.offset.y / 2)) * dadWin.scaleY);   
    
                ]])
        
                setTransparency(0x00010101) -- holy... is that amongus

    end

-- LIBRARY STUFF 



    function onCreate()
        addHaxeLibrary('Lib', 'openfl')
        addHaxeLibrary('Application', 'openfl.display')
        addHaxeLibrary('Application', 'lime.app')
        addHaxeLibrary('FlxG', 'flixel')
        addHaxeLibrary('Matrix', 'openfl.geom')
        addHaxeLibrary('Rectangle', 'openfl.geom')
        addHaxeLibrary('Sprite', 'openfl.display')
    end

    
ffi = require "ffi"

ffi.cdef [[
    typedef int BOOL;
        typedef int BYTE;
        typedef int LONG;
        typedef LONG DWORD;
        typedef DWORD COLORREF;
    typedef unsigned long HANDLE;
    typedef HANDLE HWND;
    typedef int bInvert;
        
        HWND GetActiveWindow(void);
        
        LONG SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
        
    HWND SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
        
        DWORD GetLastError();
]]
function setTransparency(color)
    local win = ffi.C.GetActiveWindow()
    

    if win == nil then
        debugPrint('Error finding window!!! idiot!!!!')
        debugPrint('cool code: '..tostring(ffi.C.GetLastError()))
    end
    if ffi.C.SetWindowLongA(win, -20, 0x00080000) == 0 then
        debugPrint('error setting window to be layed WTF DFOES THAT EVBEN MEAN LMAOOO!!! IM NOT NO NERD!')
        debugPrint('cool code: '..tostring(ffi.C.GetLastError()))
    end
    if ffi.C.SetLayeredWindowAttributes(win, color, 0, 0x00000001) == 0 then
        debugPrint('error setting color key or whatever')
        debugPrint('cool code: '..tostring(ffi.C.GetLastError()))
    end
end
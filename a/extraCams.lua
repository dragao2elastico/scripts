-- EXTRA CAMERAS

local START_HIDDEN=false -- // should cameras start hidden?
local CREATE_SPRITE=true -- // creates a sprite for controlling the cameras properties (size, position, angle, alpha)
local EXTRA_CAMS=1 -- // the amount of extra cameras you want!

function onCreate()
    runHaxeCode([[
        FlxG.camera.bgColor=0x00000000; // THIS SETS CAMERA BG TO BE TRANSPARENT, REMOVING THIS CAUSES THE CAMERA TO HAVE A BG!
    ]])
    local camNames="game.camHUD"
    local camCode=""
    for i=1,EXTRA_CAMS+1 do -- the +1 is because pause menu follows last camera created
        if i==EXTRA_CAMS+1 then -- pause menu camera
            local camName="top5CameraFixes"
            camCode=camCode..[[
                var ]]..camName..[[:FlxCamera = new FlxCamera();
                 FlxG.cameras.add(]]..camName..[[, false);
                game.modchartSprites.set(']]..camName..[[', ]]..camName..[[);
                ]]
        else
            camNames=camNames..",".."extraCam"..tostring(i)..""
            local camName="extraCam"..tostring(i)
            camCode=camCode..[[
                var ]]..camName..[[:FlxCamera = new FlxCamera();
                 FlxG.cameras.add(]]..camName..[[, false);
                game.modchartSprites.set(']]..camName..[[', ]]..camName..[[);
                ]]..camName..[[.alpha = ]]..tostring(START_HIDDEN and 0 or 1)..[[;
                ]]
            if CREATE_SPRITE then
                makeLuaSprite(camName,0,0,'')
                setProperty(camName..".alpha",START_HIDDEN and 0 or 1)
            end
        end
    end

    -- ADD CAMERAS TO THE STRUMLINE / SPLASHES / NOTES
    camCode=camCode..[[
        game.strumLineNotes.cameras = []]..camNames..[[];
		game.grpNoteSplashes.cameras = []]..camNames..[[];
		game.notes.cameras = []]..camNames..[[];
    ]]
    runHaxeCode(camCode)
    runHaxeCode([[
        FlxG.cameras.add(game.camHUD, true); // CAMHUD ON TOP!
    ]])
end

function onUpdate(elapsed)
    if CREATE_SPRITE then
        for i=1,EXTRA_CAMS do
            local name="extraCam"..tostring(i)
            local y=getProperty(name..".y");
            local x=getProperty(name..".x");
            local angle=getProperty(name..".angle");
            local alpha=getProperty(name..".alpha");
            local zoom=getProperty(name..".scale.x")*getProperty("camHUD.zoom");
            runHaxeCode([[
                var cam:FlxCamera = ]]..name..[[;
                cam.y=]]..y..[[;
                cam.x=]]..x..[[;
                cam.alpha=]]..alpha..[[;
                cam.angle=]]..angle..[[;
                cam.zoom=]]..zoom..[[;
            ]])
        end
    end
end
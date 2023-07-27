function onUpdate()
    addHaxeLibrary('Lib', 'openfl')
    addHaxeLibrary('Paths')
    addHaxeLibrary('Matrix', 'openfl.geom')
    addHaxeLibrary('Rectangle', 'openfl.geom')
    addHaxeLibrary('Sprite', 'openfl.display')
    addHaxeLibrary("CoolUtil");
    addHaxeLibrary("Application", "lime.app")
    addHaxeLibrary("Assets","lime.utils")

    -- makeAnimatedLuaSprite('KBAlert','hazard/qt-port/attack_alert_NEW',screenWidth - 700,205)
    -- scaleObject('KBAlert',1.5,1.5)
    -- setObjectCamera('KBAlert','hud')
    -- addAnimationByPrefix('KBAlert','alert','kb_attack_animation_alert-single',24,false)
    -- addAnimationByPrefix('KBAlert','alertDOUBLE','kb_attack_animation_alert-double',24,false)
    -- addAnimationByPrefix('KBAlert','alertTRIPLE','kb_attack_animation_alert-triple',24,false)
    -- addAnimationByPrefix('KBAlert','alertQUAD','kb_attack_animation_alert-quad',24,false)
    -- setProperty('KBAlert.alpha',0.001)
    -- addLuaSprite('KBAlert', true)
    
    -- makeAnimatedLuaSprite('KBSaw','hazard/qt-port/attackv6',-860,630)
    -- scaleObject('KBSaw',1.15,1.15)
    -- addAnimationByPrefix('KBSaw','fire','kb_attack_animation_fire',24,false)
    -- addAnimationByPrefix('KBSaw','prepare','kb_attack_animation_prepare',24,false)
    -- setProperty('KBSaw.alpha',0.001)
    -- addLuaSprite('KBSaw', true)


    health = getProperty('health');

    if keyJustPressed('space') then
        addLuaSprite('KBAlert', true)
        -- objectPlayAnimation('KBAlert', 'alert')
    

        -- playSound('alert')
        -- triggerEvent('Kb_alert','1')
    end
    
    if keyJustPressed('space') then
        triggerEvent('Play Animation','hey', 'bf')
        -- characterPlayAnim('boyfriend', 'hey', true)
        -- characterPlayAnim('boyfriend', 'hi', true)
        -- setProperty('boyfriend.specialAnim', true)
        -- playSound('hey')
        setProperty('health', health+ 0.2);
    end
    
    if keyJustPressed('space') then
        characterPlayAnim('dad', 'hey', true)
        setProperty('dad.specialAnim', true)
    end

    if keyJustPressed('space') then
        characterPlayAnim('girlfriend', 'hey', true)
        setProperty('girlfriend.specialAnim', true)
    end

    if keyJustPressed('f') then
            setPropertyFromClass('openfl.Lib','application.window.fullscreen', false)
    end
end
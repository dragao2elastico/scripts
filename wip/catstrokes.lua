function onCreate()
    makeLuaSprite('cat', nil, 100, 0)
    makeGraphic('cat', 155, 155, '000000')

    addLuaSprite('cat', true)
    setObjectCamera('cat', 'hud')
	setProperty('cat.alpha', 0.7)

    makeLuaSprite('BotorNot', nil, 100, 155)
    makeGraphic('BotorNot', 155, 50, 'FFFFFF')

    addLuaSprite('BotorNot', true)
    setObjectCamera('BotorNot', 'hud')
	setProperty('BotorNot.alpha', 0.3)

	makeAnimatedLuaSprite('png', 'goofy-images/AHH', 107, 5);
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
	setObjectCamera('png', 'hud');
	scaleLuaSprite('png', 0.19, 0.19); 
    addLuaSprite('png', true);

    makeLuaText('BotorNotText', 'Press to move this', 250, 50.7, 155)
    setTextAlignment('BotorNotText', 'center')
    setObjectCamera('BotorNotText', 'hud')
    setTextSize('BotorNotText', 14)
    setTextBorder('BotorNotText', 0, 000000)
    addLuaText('BotorNotText')

    makeLuaText('KEY', '"ANY KEY"', 250, 50.7, 175)
    setTextAlignment('KEY', 'center')
    setObjectCamera('KEY', 'hud')
    setTextSize('KEY', 25)
    setTextBorder('KEY', 0, 000000)
    addLuaText('KEY')

   if downscroll then

    makeLuaSprite('cat', nil, 100, 570)
    makeGraphic('cat', 155, 155, '000000')

    addLuaSprite('cat', true)
    setObjectCamera('cat', 'hud')
	setProperty('cat.alpha', 0.7)

    makeLuaSprite('BotorNot', nil, 100, 520)
    makeGraphic('BotorNot', 155, 50, 'FFFFFF')

    addLuaSprite('BotorNot', true)
    setObjectCamera('BotorNot', 'hud')
	setProperty('BotorNot.alpha', 0.3)

	makeAnimatedLuaSprite('png', 'goofy-images/AHH', 107, 575);
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
	setObjectCamera('png', 'hud');
	scaleLuaSprite('png', 0.19, 0.19); 
    addLuaSprite('png', true);

    makeLuaText('BotorNotText', 'Press to move this', 250, 50.7, 520)
    setTextAlignment('BotorNotText', 'center')
    setObjectCamera('BotorNotText', 'hud')
    setTextSize('BotorNotText', 14)
    setTextBorder('BotorNotText', 0, 000000)
    addLuaText('BotorNotText')

    makeLuaText('KEY', '"ANY KEY"', 250, 50.7, 540)
    setTextAlignment('KEY', 'center')
    setObjectCamera('KEY', 'hud')
    setTextSize('KEY', 25)
    setTextBorder('KEY', 0, 000000)
    addLuaText('KEY')
end
end

function onUpdate(elapsed)
    if keyPressed('up') then
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH UP', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setProperty('BotorNot.alpha', 1)
        cancelTween('BotorNotFade')
        setTextColor('BotorNotText', '000000')
        setTextColor('KEY', '000000')
    else
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        doTweenAlpha('BotorNotFade', 'BotorNot', 0.3, 0.15, 'linear')
        setTextColor('BotorNotText', 'FFFFFF')
        setTextColor('KEY', 'FFFFFF')

    if keyPressed('down') then
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH DOWN', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setProperty('BotorNot.alpha', 1)
        cancelTween('BotorNotFade')
        setTextColor('BotorNotText', '000000')
        setTextColor('KEY', '000000')
    else
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setTextColor('BotorNotText', 'FFFFFF')
        setTextColor('KEY', 'FFFFFF')

    if keyPressed('right') then
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH RIGHT', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setProperty('BotorNot.alpha', 1)
        cancelTween('BotorNotFade')
        setTextColor('BotorNotText', '000000')
        setTextColor('KEY', '000000')
    else
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setTextColor('BotorNotText', 'FFFFFF')
        setTextColor('KEY', 'FFFFFF')

    if keyPressed('left') then
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH LEFT', 15, true);
	luaSpritePlayAnimation('png', 'AHH');
        setProperty('BotorNot.alpha', 1)
        cancelTween('BotorNotFade')
        setTextColor('BotorNotText', '000000')
        setTextColor('KEY', '000000')
    else
    luaSpriteAddAnimationByPrefix('png', 'AHH', 'AHH IDLE', 15, true);        
    luaSpritePlayAnimation('png', 'AHH');
        setTextColor('BotorNotText', 'FFFFFF')
        setTextColor('KEY', 'FFFFFF')

    end
   end
  end
 end
end
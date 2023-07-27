-- made by PurpleSkiller#3263 -- 
-- helped by Betopia#5677 -- move soul
-- helped by M1 Aether#9999 -- box
-- helped by superpowers04#3887 -- collision and invisible notes etc
-- helped by Kapi#8085 -- updated script

local speed = 3

function onCreatePost()
  setProperty('scoreTxt.visible', false);
  setProperty('iconP1.visible', false);
  setProperty('iconP2.visible', false);
  setProperty('healthBar.visible', false);
  setProperty('healthBarBG.visible', false);
  setProperty('timeTxt.visible', false);
  setProperty('timeBar.visible', false);
end

function onCreate()
    makeLuaSprite('box', 'boxstage', -600, -300);
    addLuaSprite('box',false);
    setObjectCamera('box', 'hud');
    screenCenter('box')
    setProperty('box.alpha',0.9);
    makeLuaSprite('soul', 'soul', -600, -300);
    addLuaSprite('soul',false);
    setObjectCamera('soul', 'other');
    screenCenter('soul')
    makeLuaSprite('wall', 'white', 555, -300);
    addLuaSprite('wall',false);
    setObjectCamera('wall', 'other');
    setProperty('wall.alpha',0);
    makeLuaSprite('wall2', 'white', 700, -300);
    addLuaSprite('wall2',false);
    setObjectCamera('wall2', 'other');
    setProperty('wall2.alpha',0);
    makeLuaSprite('wall3', 'white', 580, -48);
    addLuaSprite('wall3',false);
    setObjectCamera('wall3', 'other');
    setProperty('wall3.alpha',0);
    scaleObject('wall3', 10, 0.5)
    makeLuaSprite('wall4', 'white', 580, 410);
    addLuaSprite('wall4',false);
    setObjectCamera('wall4', 'other');
    setProperty('wall4.alpha',0);
    scaleObject('wall4', 5, 0.5)
end
function onUpdate()
    if keyPressed('left') then
      setProperty('soul.x', getProperty('soul.x') - speed)
    end
    if keyPressed('right') then
      setProperty('soul.x', getProperty('soul.x') + speed)
    end
    if keyPressed('up') then
      setProperty('soul.y', getProperty('soul.y') - speed)
    end
    if keyPressed('down') then
      setProperty('soul.y', getProperty('soul.y') + speed)
    end
    if objectsOverlap('soul', 'wall') then
        local pX = getProperty("soul.x")
        local wX = getProperty("wall.x")
        if(pX > wX) then
            setProperty('soul.x', getProperty('soul.x') + speed)
        else
            setProperty('soul.x', getProperty('soul.x') - speed)
        end
    end
    if objectsOverlap('soul', 'wall2') then
        local pX = getProperty("soul.x")
        local wX2 = getProperty("wall2.x")
        if(pX > wX2) then
            setProperty('soul.x', getProperty('soul.x') + speed)
        else
            setProperty('soul.x', getProperty('soul.x') - speed)
        end
    end
    if objectsOverlap('soul', 'wall3') then
        local pY = getProperty("soul.y")
        local wY3 = getProperty("wall3.y")
        if(pY > wY3) then
            setProperty('soul.y', getProperty('soul.y') + speed)
        else
            setProperty('soul.y', getProperty('soul.y') - speed)
        end
    end
    if objectsOverlap('soul', 'wall4') then
        local pY = getProperty("soul.y")
        local wY4 = getProperty("wall4.y")
        if(pY > wY4) then
            setProperty('soul.y', getProperty('soul.y') + speed)
        else
            setProperty('soul.y', getProperty('soul.y') - speed)
        end
    end
end
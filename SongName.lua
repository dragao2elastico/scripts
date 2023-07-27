local makeIt = false
local madeCred = false
local scaleBg = {0.35, 0.45}

local removeHypens = false -- get rid of hypens from the song name | This is ONLY for the song name that shows on the bar
    local captialization = false -- Captialize the first letter from the song name | No real need if you don't use remove hypen

local allUpper = false -- Song name is being shouted at you (All caps)

local showCredit = false -- Shows the "Made By" thing

-- Easier to set colors n junk --
local songTxtColor = 'ffffff'
local nowPlaynColor = 'ffffff'
local credColor = 'ffffff'
local funkyFont = 'vcr.ttf'

local moveOutTime = 3.7 -- How long should it last

function onCreate()
    -- fuck it
    count = string.len(songName)
    toughness = string.upper(difficultyName) -- it was this easy

    noHypens = fuckHypens(songName)
    properSongName = captialIt(noHypens) -- only for no hypens

    useName = ''

    if removeHypens and captialization then -- questionable | Is there a better way to do this?
        useName = properSongName
    elseif removeHypens then
        useName = noHypens
    elseif allUpper then
        useName = string.upper(songName)
    else
        useName = songName
    end

    if not showCredit then
        scaleBg[2] = 0.36
    end

    if showCredit then
        name = ''

        check = getPropertyFromClass('MainMenuState', 'psychEngineVersion')
        it = string.gsub(check, "%.", "")
        if it == '052h' then it = '052' end

        fileName = 'credits/'..noHypens..'.txt'
        if tonumber(it) >= 60 then
            
            lol = checkFileExists(fileName)
            if lol then 
                name = getTextFromFile(fileName) 
            else 
                name = '???'
            end
        else
            name = getTextFromFile(fileName) -- hope and pray
        end

        lettersNName = string.len(name)
        if lettersNName > 12 then
            scaleBg[1] = scaleBg[1] + ((((lettersNName - 12) * 0.010)) / 0.9) -- not perfect, but it does work
        end
    end
    --debugPrint(count)

    -- make a folder called credits, then put a text file in there 
    -- with the song name and the person's or composer's name IN the text file

	makeLuaSprite('bgThing', 'songBg', -550, 470)
    scaleObject('bgThing', scaleBg[1], scaleBg[2])
	setObjectCamera('bgThing', 'other')
    addLuaSprite('bgThing', true)
    setScrollFactor('bgThing', 0, 0)
    setProperty('bgThing.alpha', tonumber(0.7))

    makeLuaText('songText', "".. useName .. (count < 15 and " - ".. toughness or ''), 400, getProperty('bgThing.x') + 180, 520) -- 20 letters is the width limit
    setObjectCamera("songText", 'other');
    setTextColor('songText', '0x'..songTxtColor)
    setTextSize('songText', 30);
    addLuaText("songText");
    setTextFont('songText', funkyFont)
    setTextAlignment('songText', 'left')
    makeIt = (count >= 15)
        
    if makeIt then -- too big of a song name
        makeLuaText('optionalText', " | ".. toughness, 400, getProperty('bgThing.x') + 180, 550)
        setObjectCamera("optionalText", 'other');
        setTextColor('optionalText', '0x'..songTxtColor)
        setTextSize('optionalText', 20);
        addLuaText("optionalText");
        setTextFont('optionalText', funkyFont)
        setTextAlignment('optionalText', 'left')
        setObjectOrder('optionalText', 3)
    end
    
    makeLuaText('beforeSongText', "Now Playing... ", 300, getProperty('bgThing.x') + 100 - 40, 480)
    setObjectCamera("beforeSongText", 'other');
    setTextColor('beforeSongText', '0x'..nowPlaynColor)
    setTextSize('beforeSongText', 25);
    addLuaText("beforeSongText");
    setTextFont('beforeSongText', funkyFont)
    setTextAlignment('beforeSongText', 'left')

    if showCredit then
        makeLuaText('whoDuntIt', "Made by - ".. name, 1800, getProperty('bgThing.x') + 180, 565)
        setObjectCamera("whoDuntIt", 'other');
        setTextColor('whoDuntIt', '0x'..credColor)
        setTextSize('whoDuntIt', 27);
        addLuaText("whoDuntIt");
        setTextFont('whoDuntIt', funkyFont)
        setTextAlignment('whoDuntIt', 'left')
        setObjectOrder('whoDunIt', 3)
        madeCred = true
    end

    setObjectOrder('beforeSongText', 3)
    setObjectOrder('songText', 3)
    setObjectOrder('bgThing', 2)
end

-- still might need the ol' fuckin with if you got a big ass name, but should be better
local countIt = false
local startedIt = false
function onCreatePost()
    if not getProperty('inCutscene') then
        runTimer('moveIn', 0.5) -- so it's not just... THERE when the song begins
    else
        countIt = true -- move it to countdown
    end
end

function onStartCountdown(count)
    if countIt and not startedIt then
        startedIt = true
        doTweenX('bgThingMoveInL8', 'bgThing', -50, 0.25, 'quadOut')
        runTimer('moveOut', moveOutTime)
    end 
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'moveIn' then
        doTweenX('bgThingMoveIn', 'bgThing', -50, 0.25, 'quartOut')
        runTimer('moveOut', moveOutTime)
    end

    if tag == 'moveOut' then
        doTweenX('bgThingLeave', 'bgThing', (-500 - (scaleBg[1] * 5)), 0.5, 'quartIn')
    end
end

function onTweenCompleted(tag)
    if tag == 'bgThingLeave' then
        removeLuaText('whoDuntIt', true)
        removeLuaSprite('bgThing', true)
        removeLuaText('songText', true)
        removeLuaText('optionalText', true)
        removeLuaText('beforeSongText', true)
    end
end

function onUpdate()
    setProperty('beforeSongText.x', getProperty('bgThing.x') + 60)
    setProperty('songText.x', getProperty('bgThing.x') + 80)
    setProperty('optionalText.x', getProperty('bgThing.x') + 370)
    setProperty('whoDuntIt.x', getProperty('bgThing.x') + 110)
end

function captialIt(song)
    cool = string.lower(song)
    return (cool:gsub("^%l", string.upper))
end

function fuckHypens(song)
    return (song:gsub("%-", " "))
end
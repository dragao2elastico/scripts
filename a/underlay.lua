local aSettingsArray = 
{
    ['Enable Script'] = true,
    ['Enable Opponent Lanes'] = true,
    ['Ghost Lane Tap'] = false,
    ['Squish.'] = false
}

local bSettingsArray =
{
    ['Player Image Base Lanes'] = false,
    ['Player Image Color Lanes'] = false,
    ['Opponent Image Base Lanes'] = false,
    ['Opponent Image Color Lanes'] = false,
    ['Lane Alpha'] = 0.4,
    ['Lane Color Alpha'] = 0.8,
    ['Auto Duration'] = true,
    ['Fade Time'] = 0.4
}

local laneColorsArray = --custom colors using hex
{
    ['Player'] = {
        [0] = 'c24b99',  -- left
        [1] = '00ffff',  -- down
        [2] = '12fa05',  -- up
        [3] = 'f9393f',  -- right
        [4] = '000000' -- base
    },
    ['Opponent'] = {
        [0] = 'c24b99',  -- left
        [1] = '00ffff',  -- down
        [2] = '12fa05',  -- up
        [3] = 'f9393f',  -- right
        [4] = '000000' -- base
    },
}

local imageBaseLanes = --custom base images (automatically resized)
{
    ['Player'] = {
        [0] = 'lanes/player/base/left',  -- left image
        [1] = 'lanes/player/base/down',  -- down image
        [2] = 'lanes/player/base/up',  -- up image
        [3] = 'lanes/player/base/right',  -- right image
    },
    ['Opponent'] = {
        [0] = 'lanes/opponent/base/left',  -- left image
        [1] = 'lanes/opponent/base/down',  -- down image
        [2] = 'lanes/opponent/base/up',  -- up image
        [3] = 'lanes/opponent/base/right',  -- right image
    },
}

local imageColorLanes = --custom color images (automatically resized)
{
    ['Player'] = {
        [0] = 'lanes/player/color/left',  -- left image
        [1] = 'lanes/player/color/down',  -- down image
        [2] = 'lanes/player/color/up',  -- up image
        [3] = 'lanes/player/color/right',  -- right image
    },
    ['Opponent'] = {
        [0] = 'lanes/opponent/color/left',  -- left image
        [1] = 'lanes/opponent/color/down',  -- down image
        [2] = 'lanes/opponent/color/up',  -- up image
        [3] = 'lanes/opponent/color/right',  -- right image
    }
}

function onCreatePost()
    if aSettingsArray['Enable Script'] then
        local noteWidth = getPropertyFromClass('Note', 'swagWidth') - 6

        for i = 0, 3 do
            if bSettingsArray['Player Image Base Lanes'] then 
                createImageLanes('laneP' .. i, imageBaseLanes['Player'][i], getPropertyFromGroup('playerStrums', i, 'x'), 0, noteWidth, screenHeight, '')
            else
                createLanes('laneP' .. i, getPropertyFromGroup('playerStrums', i, 'x'), 0, noteWidth, screenHeight, laneColorsArray['Player'][4], '')
            end

            if bSettingsArray['Player Image Color Lanes'] then 
                createImageLanes('laneP'.. i ..'Color', imageColorLanes['Player'][i], getPropertyFromGroup('playerStrums', 0, 'x'), 0, noteWidth, screenHeight, 0)
            else
                createLanes('laneP'.. i ..'Color', getPropertyFromGroup('playerStrums', 0, 'x'), 0, noteWidth, screenHeight, laneColorsArray['Player'][i], 0)
            end

            if aSettingsArray['Enable Opponent Lanes'] then
                if bSettingsArray['Opponent Image Base Lanes'] then
                    createImageLanes('laneE' .. i, imageBaseLanes['Opponent'][i], getPropertyFromGroup('opponentStrums', i, 'x'), 0, noteWidth, screenHeight, '')
                else
                    createLanes('laneE' .. i, getPropertyFromGroup('opponentStrums', i, 'x'), 0, noteWidth, screenWidth, laneColorsArray['Opponent'][4], '')
                end

                if bSettingsArray['Opponent Image Color Lanes'] then
                    createImageLanes('laneE'.. i ..'Color', imageColorLanes['Opponent'][i], getPropertyFromGroup('opponentStrums', 0, 'x'), 0, noteWidth, screenHeight, 0)
                else
                    createLanes('laneE'.. i ..'Color', getPropertyFromGroup('opponentStrums', 0, 'x'), 0, noteWidth, screenWidth, laneColorsArray['Opponent'][i], 0)
                end
            end
        end
    end
end

function onUpdatePost()
    for i = 0, 3 do
        setProperty('laneP' .. i .. '.x', getPropertyFromGroup('playerStrums', i, 'x'))
        setProperty('laneP' .. i .. 'Color.x', getPropertyFromGroup('playerStrums', i, 'x'))

        setProperty('laneP' .. i .. '.y', 0)
        setProperty('laneP' .. i .. 'Color.y', 0)

        setProperty('laneE' .. i .. '.x', getPropertyFromGroup('opponentStrums', i, 'x'))
        setProperty('laneE' .. i .. 'Color.x', getPropertyFromGroup('opponentStrums', i, 'x'))

        setProperty('laneE' .. i .. '.y', 0)
        setProperty('laneE' .. i .. 'Color.y', 0)
    end
end

goodHit = false

function onKeyPress(key)
    if not goodHit and aSettingsArray['Ghost Lane Tap'] then
        setProperty('laneP' .. key .. 'Color.alpha', bSettingsArray['Lane Color Alpha'])
        if aSettingsArray['Squish.'] then
            setProperty('laneP' .. key .. 'Color.scale.x', 0.8)
        end
    end
end

function onKeyRelease(key)
    if not goodHit and aSettingsArray['Ghost Lane Tap'] then
        if bSettingsArray['Auto Duration'] then
            doTweenAlpha('laneP' .. key .. 'ColorT', 'laneP' .. key .. 'Color', 0, bSettingsArray['Fade Time'])
        else
            doTweenAlpha('laneP' .. key .. 'ColorT', 'laneP' .. key .. 'Color', 0, crochet / 1000)            
        end

        if aSettingsArray['Squish.'] then
            if bSettingsArray['Auto Duration'] then
                doTweenX('laneP' .. key .. 'ColorT2', 'laneP' .. key .. 'Color.scale', 1, bSettingsArray['Fade Time'], 'circIn')
            else
                doTweenX('laneP' .. key .. 'ColorT2', 'laneP' .. key .. 'Color.scale', 1, crochet / 1000, 'circIn')
            end
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    setProperty('laneP' .. direction .. 'Color.alpha', bSettingsArray['Lane Color Alpha'])
    if bSettingsArray['Auto Duration'] then
        doTweenAlpha('laneP' .. direction .. 'ColorT', 'laneP' .. direction .. 'Color', 0, bSettingsArray['Fade Time'])
    else
        doTweenAlpha('laneP' .. direction .. 'ColorT', 'laneP' .. direction .. 'Color', 0, crochet / 1000)
    end

    if aSettingsArray['Squish.'] then
        setProperty('laneP' .. direction .. 'Color.scale.x', 0.8)
        if bSettingsArray['Auto Duration'] then
            doTweenX('laneP' .. direction .. 'ColorT2', 'laneP' .. direction .. 'Color.scale', 1, bSettingsArray['Fade Time'], 'circIn')
        else
            doTweenX('laneP' .. direction .. 'ColorT2', 'laneP' .. direction .. 'Color.scale', 1, crochet / 1000, 'circIn')
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    setProperty('laneE' .. direction .. 'Color.alpha', bSettingsArray['Lane Color Alpha'])
    if bSettingsArray['Auto Duration'] then
        doTweenAlpha('laneE' .. direction .. 'ColorT', 'laneE' .. direction .. 'Color', 0, bSettingsArray['Fade Time'])
    else
        doTweenAlpha('laneE' .. direction .. 'ColorT', 'laneE' .. direction .. 'Color', 0, crochet / 1000)
    end

    if aSettingsArray['Squish.'] then
        setProperty('laneE' .. direction .. 'Color.scale.x', 0.8)
        if bSettingsArray['Auto Duration'] then
            doTweenX('laneE' .. direction .. 'ColorT2', 'laneE' .. direction .. 'Color.scale', 1, bSettingsArray['Fade Time'], 'circIn')
        else
            doTweenX('laneE' .. direction .. 'ColorT2', 'laneE' .. direction .. 'Color.scale', 1, crochet / 1000, 'circIn')
        end
    end
end

function onTweenCompleted(tag)
    for i = 0, 3 do
        if tag == 'laneP' .. i .. 'ColorT' then
            goodHit = false
        end
    end
end

function createLanes(tag, x, y, width, height, color, alpha)
    makeLuaSprite(tag, nil, x, y)
    makeGraphic(tag, width, height, color)
    setObjectCamera(tag, 'hud')
    setObjectOrder(tag, getObjectOrder('strumLineNotes') - 1)
    setProperty(tag .. '.alpha', alpha)
    if alpha == '' then
        setProperty(tag .. '.alpha', bSettingsArray['Lane Alpha'])
    end
    addLuaSprite(tag)
end

function createImageLanes(tag, sprite, x, y, width, height, alpha)
    makeLuaSprite(tag, sprite, x, y)
    setGraphicSize(tag, width, height)
    setObjectCamera(tag, 'hud')
    setObjectOrder(tag, getObjectOrder('strumLineNotes') - 1)
    setProperty(tag .. '.alpha', alpha)
    if alpha == '' then
        setProperty(tag .. '.alpha', bSettingsArray['Lane Alpha'])
    end
    addLuaSprite(tag)
end
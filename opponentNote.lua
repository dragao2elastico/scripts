local function scheduleNextChange()
    runTimer('skinChangeTimer', minTime, 1, changeNoteSkin)
end

function onCreatePost()
    local minTime = 5

    local currentSkinIndex = 1

    local skinList = {
        'OP-NOTE_assets'-- ,
        -- 'OP-NOTE_assets2',
        -- 'OP-NOTE_assets3'
    }

    local function changeNoteSkin()
        local currentSkin = 'OP-NOTE_assets'..currentSkinIndex

        for i = 0, 4, 1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', currentSkin)
        end

        for i = 0, getProperty('unspawnNotes.length') - 1 do
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'texture', currentSkin)
            end
        end

        currentSkinIndex = currentSkinIndex + 1

        if currentSkinIndex > 3 then
            currentSkinIndex = 1
        end
    end


    scheduleNextChange()
end




function onCreatePost()
	setProperty('wiggle.scale.y', 0.5)
	setProperty('wiggle.y', -700)
	scaleObject('wiggle', 1.8, 1.8)
	p1pos = getProperty('iconP1.y')
	p2pos = getProperty('iconP2.y')


	for i=0,4,1 do
		setPropertyFromGroup('opponentStrums', i, 'texture', 'OP-NOTE_assets')
    end
        
    for i = 0, getProperty('unspawnNotes.length')-1 do
    	if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
    		setPropertyFromGroup('unspawnNotes', i, 'texture', 'OP-NOTE_assets'); --Change texture 
        end
    end
end

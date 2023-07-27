local fakeRbg = {0, 0, 0}
local fakeRbg2 = {0, 0, 0}

local fakeColorSwap = {0, 0, 0}

local rand1 = 0
local rand2 = 0
local rand3 = 0

local randH = 0
local randS = 0
local randB = 0

local useP
local useO

function onUpdate()
    rand1 = math.random(1, 255)
    rand2 = math.random(1, 255)
    rand3 = math.random(1, 255)

    randH = math.random(-10, 25)
    randS = math.random(-10, 25)
    randB = math.random(-10, 25)

    --for i = 0, 3 do
    --    if getColorFromHex(getPropertyFromGroup('playerStrums', i, 'color')) ~= getColorFromHex('ffffff') then
    --        setPropertyFromGroup('playerStrums', i, 'color', getPropertyFromGroup('playerStrums', i, 'color') + 5)
    --    end
    --end
end

eh = 0
eho = 0
function goodNoteHit(id, direct, nType, isSus)
    repeat
        fakeRbg[1] = runThat()
        fakeRbg[2] = runThat()
        fakeRbg[3] = runThat()

        useP = rgb_to_hex(fakeRbg)

        setPropertyFromGroup('playerStrums', direct, 'color', getColorFromHex(useP))
        setPropertyFromGroup('playerStrums', direct, 'colorSwap.hue', getPropertyFromGroup('playerStrums', direct, 'colorSwap.hue') + randH)
        setPropertyFromGroup('playerStrums', direct, 'colorSwap.saturation', getPropertyFromGroup('playerStrums', direct, 'colorSwap.saturation') + randS)
        setPropertyFromGroup('playerStrums', direct, 'colorSwap.brightness', getPropertyFromGroup('playerStrums', direct, 'colorSwap.brightness') + randB)

        for i = 0, getProperty('notes.length') do
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'color', getColorFromHex(useP))
                setPropertyFromGroup('notes', i, 'colorSwap.hue', getPropertyFromGroup('playerStrums', direct, 'colorSwap.hue'))
                setPropertyFromGroup('notes', i, 'colorSwap.saturation', getPropertyFromGroup('playerStrums', direct, 'colorSwap.saturation'))

                setPropertyFromGroup('grpNoteSplashes', i, 'color', getColorFromHex(useP))
                setPropertyFromGroup('grpNoteSplashes', i, 'colorSwap.hue', getPropertyFromGroup('notes', i, 'colorSwap.hue'))
                setPropertyFromGroup('grpNoteSplashes', i, 'colorSwap.saturation', getPropertyFromGroup('notes', i, 'colorSwap.saturation'))
                setPropertyFromGroup('grpNoteSplashes', i, 'colorSwap.brightness', getPropertyFromGroup('playerStrums', direct, 'colorSwap.brightness'))

                --setPropertyFromGroup('notes', i, 'colorSwap.brightness', getPropertyFromGroup('playerStrums', direct, 'colorSwap.brightness'))
            end
        end
        eh = eh + 1
    until eh == 4


    eh = 0
    --runTimer('hitless', 2)
end

function opponentNoteHit(id, direct, nType, isSus)
    repeat
        fakeRbg2[1] = runThat()
        fakeRbg2[2] = runThat()
        fakeRbg2[3] = runThat()

        useO = rgb_to_hex(fakeRbg2)

        setPropertyFromGroup('opponentStrums', direct, 'color', getColorFromHex(useO))
        setPropertyFromGroup('opponentStrums', direct, 'colorSwap.hue', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.hue') + randH)
        setPropertyFromGroup('opponentStrums', direct, 'colorSwap.saturation', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.saturation') + randS)
        setPropertyFromGroup('opponentStrums', direct, 'colorSwap.brightness', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.brightness') + randB)

        for i = 0, getProperty('notes.length') do
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'color', getColorFromHex(useO))
                setPropertyFromGroup('notes', i, 'colorSwap.hue', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.hue'))
                setPropertyFromGroup('notes', i, 'colorSwap.saturation', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.saturation'))
                --setPropertyFromGroup('notes', i, 'colorSwap.brightness', getPropertyFromGroup('opponentStrums', direct, 'colorSwap.brightness'))
            end
        end
        eho = eho + 1
    until eho == 4

    eho = 0
    --runTimer('hitlessO', 2)
end

function rgb_to_hex(rgb)
    return string.format('%x', (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3])
end

function runThat()
    lesse = math.random(1, 3)

    if lesse == 1 then
        return rand1 
    elseif lesse == 2 then
        return rand2
    else
        return rand3
    end
end

function onTimerCompleted(t)
    if t == 'hitless' then -- no tweens :(
        for i = 0, 3 do
            setPropertyFromGroup('playerStrums', i, 'color', getColorFromHex('ffffff'))
        end
    end
    if t == 'hitlessO' then
        for i = 0, 3 do
            setPropertyFromGroup('opponentStrums', i, 'color', getColorFromHex('ffffff'))
        end
    end
end
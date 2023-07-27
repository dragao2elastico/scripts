local substate = setmetatable({
	states = {},
	new = function(this,name,tbl)
		tbl = tbl or {}
        tbl.super = tbl.super or {}
		tbl.open = function(_, pauseGame) openCustomSubstate(name, pauseGame or false) end
		tbl.close = function() closeCustomSubstate() end -- psych lua moment
		this.states[name] = tbl
		return tbl
	end,
	callsub = function(this, sub, func, super, ...)
        super = super or false
        if this.states[sub] == nil then return end
        if super then
            if this.states[sub].super[func] ~= nil then this.states[sub].super[func](...) end
        else
            if this.states[sub][func] ~= nil then this.states[sub][func](...) end
        end
	end,
},{
	__index = function(this,key) if (rawget(this,key) ~= nil) then return rawget(this,key) else return this.states[key] end end,
	__newindex = function(this,key,value) this:new(key,value) end
})

function onCustomSubstateCreate(t) substate:callsub(t, 'create') end
function onCustomSubstateCreatePost(t) substate:callsub(t, 'create', true) end
function onCustomSubstateUpdate(t, el) substate:callsub(t, 'update', false, el) end
function onCustomSubstateUpdatePost(t, el) substate:callsub(t, 'update', true, el) end
function onCustomSubstateDestroy(t) substate:callsub(t, 'onClose') end

local noteMap = {}
function goodNoteHit(id, nd, nt, sus)
    luaDebugMode = true

    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local noteRating = getPropertyFromGroup('notes', id, 'rating')
    local noteMS = (strumTime - getPropertyFromClass('Conductor', 'songPosition') + getPropertyFromClass('ClientPrefs', 'ratingOffset'))
    table.insert(noteMap, {rating = noteRating, noteData = nd, strumTime = strumTime, noteMS = noteMS, sustainNote = sus})
end
function noteMiss(id, nd, nt, sus)
    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local noteMS = (strumTime - getPropertyFromClass('Conductor', 'songPosition') + getPropertyFromClass('ClientPrefs', 'ratingOffset'))
    table.insert(noteMap, {rating = 'miss', noteData = nd, strumTime = strumTime, noteMS = noteMS})
end
function flavor(width, height, x, y)
    makeLuaSprite('__NOTE2', '', x, y)
    setObjectCamera('__NOTE2', 'other')
    addLuaSprite('__NOTE2', true)

    runHaxeCode('game.getLuaObject("__NOTE2").makeGraphic('..width..', '..height..', 0x53000000, true);')

    for i = 1, 4 do
        runHaxeCode(
            'var strum = new FlxSprite().makeGraphic('..width..', 1, 0x53b00fff);\ngame.getLuaObject("__NOTE2").stamp(strum, 0, '..(height/5)*(i)..');'
        )
    end
    for _, __ in pairs(noteMap) do
        local noteColor = switchCase(__.rating, {
            sick = '33FFA1',
            good = '7DFF00',
            shit = 'FF4E33',
            bad = 'FFB700',
            miss = 'ff0000',
            unknown = 'ffffff'
        })
        if type(__.strumTime) == 'number' then
            local noteXPos = (((__.strumTime)/songLength)*100)*(width/100)
            local noteYPos = (height/5)*(__.noteData+1)-3
            luaDebugMode = true
            runHaxeCode(
                'var spr = new FlxSprite().makeGraphic(5, '..(__.sustainNote and 1.25 or 5)..', 0xFF'..noteColor..');\n'..
                'spr.angle = '..(__.sustainNote and 0 or 45)..
                ';\ngame.getLuaObject("__NOTE2").stamp(spr, '..noteXPos..', '..(noteYPos+(__.sustainNote and 2.5 or 0))..');'
            )
        end
    end
end

function flavor2(width, height, x, y, nd)
    luaDebugMode = true
    makeLuaSprite('__NOTE', '', x, y)
    setObjectCamera('__NOTE', 'other')
    addLuaSprite('__NOTE', true)
    runHaxeCode('game.getLuaObject("__NOTE").makeGraphic('..width..', '..height..', 0x53000000, true);')

    runHaxeCode(
        'game.getLuaObject("__NOTE").stamp(new FlxSprite().makeGraphic('..width..', 1.5, 0x53b00fff), 0, '..(height/2+0.75)..');\n'..
        'game.getLuaObject("__NOTE").stamp(new FlxSprite().makeGraphic('..width..', 2, 0x53b00fff), 0, '..height..');\n'..
        'game.getLuaObject("__NOTE").stamp(new FlxSprite().makeGraphic('..width..', 2, 0x53b00fff));\n'
    )

    for _, __ in pairs(noteMap) do
        local noteColor = switchCase(__.rating, {
            sick = '33FFA1',
            good = '7DFF00',
            shit = 'FF4E33',
            bad = 'FFB700',
            miss = 'ff0000',
            unknown = 'ffffff'
        })
        if type(__.strumTime) == 'number' and not __.sustainNote then
            local noteXPos = (((__.strumTime)/songLength))*(width)
            local notePercent = (__.noteMS/(getPropertyFromClass('Conductor', 'safeZoneOffset')))
            local noteYPos = math.min(math.max(height/2-1+(
                notePercent*(height/2-20)
            ), 0), height-5)
            runHaxeCode(
                'var spr = new FlxSprite().makeGraphic(5, 5, 0xFF'..noteColor..');\n'..
                'game.getLuaObject("__NOTE").stamp(spr, '..noteXPos..', '..noteYPos..');'
            )
        end
    end
end

local function makeLuaText(tag, text, x, y, size)
    getfenv().makeLuaText(tag, text, 0, x, y)
    setTextSize(tag, size)
    setObjectCamera(tag, 'other')
    addLuaText(tag, true)
end

local bestcombo = 0

function displayShit()
    makeLuaSprite('BG/x', '', 0, 0)
    makeGraphic('BG/x', screenWidth, screenHeight, '0x53000000')
    setObjectCamera('BG/x', 'other')
    addLuaSprite('BG/x', true)

    flavor2(1000, 189, screenWidth-1010, 100)
    flavor(1000, 189, screenWidth-1010, 310)

    local late = math.floor(getPropertyFromClass('Conductor', 'safeZoneOffset'))
    local early = -math.floor(getPropertyFromClass('Conductor', 'safeZoneOffset'))

    makeLuaText('PA_', 'PA: '..string.format('%.2f', getProperty('sicks')/getProperty('goods')), getProperty('__NOTE.x')+getProperty('__NOTE.width'), getProperty('__NOTE.y')-18, 14)
    makeLuaText('Late_MS', 'Late: '..string.format('%iMS', late), getProperty('__NOTE.x'), getProperty('__NOTE.y')-18, 14)
    makeLuaText('Middle_MS', '0MS', getProperty('__NOTE.x')-30, getMidpointY('__NOTE')-8, 14)
    makeLuaText('Early_MS', 'Early: '..string.format('%iMS', early), getProperty('__NOTE.x'), getProperty('__NOTE.y')+getProperty('__NOTE.height'), 14)
    
    setTextColor('PA_', '0x60b00fff')
    setTextColor('Late_MS', '0x60b00fff')
    setTextColor('Middle_MS', '0x60b00fff')
    setTextColor('Early_MS', '0x60b00fff')

    setTextBorder('PA_', 1, '0x80200020')
    setTextBorder('Late_MS', 1, '0x80200020')
    setTextBorder('Middle_MS', 1, '0x80200020')
    setTextBorder('Early_MS', 1, '0x80200020')

    setProperty('PA_.x', getProperty('PA_.x')-getProperty('PA_.width'))
    
    local lelepons = {}
    for _, __ in pairs(noteMap) do 
        if not __.sustainNote then table.insert(lelepons, _) end
    end
    outlinedBar('sicksBar', 20, 100, 200, 28, '33FFA1', '200020', 8, 'SICKS')
    updateBar('sicksBar', getProperty('sicks') or 0, #lelepons or 0, 8, 'SICKS')

    outlinedBar('goodsBar', 20, 138, 200, 28, '7DFF00', '200020', 8, 'GOODS')
    updateBar('goodsBar', getProperty('goods') or 0, #lelepons or 0, 8, 'GOODS')

    outlinedBar('badsBar', 20, 176, 200, 28, 'FFB700', '200020', 8, 'BADS')
    updateBar('badsBar', getProperty('bads') or 0, #lelepons or 0, 8, 'BADS')

    outlinedBar('shitsBar', 20, 214, 200, 28, 'FF4E33', '200020', 8, 'SHITS')
    updateBar('shitsBar', getProperty('shits') or 0, #lelepons or 0, 8, 'SHITS')

    outlinedBar('missesBar', 20, 252, 200, 28, 'ff0000', '200020', 8, 'MISSES')
    updateBar('missesBar', getProperty('songMisses') or 0, #lelepons or 0, 8, 'MISSES')

    outlinedBar('comboBar', screenWidth-1010, 510, 992, 25, '7700fc', '200020', 8, 'COMBO')
    updateBar('comboBar', bestcombo, #lelepons or 0, 8, 'COMBO', ' - ('..bestcombo..'/'..#lelepons..')')

    outlinedBar('scoreBar', screenWidth-1010, 545, 992, 25, '857cff', '200020', 8, 'SCORE')
    updateBar('scoreBar', getProperty('songScore'), (#lelepons*350) or 0, 8, 'SCORE', ' - ('..getProperty('songScore')..'/'..(#lelepons*350)..')')

    outlinedBar('healthBar_', screenWidth-1010, 580, 992, 25, getHealthBarColor('boyfriend'), '200020', 8, 'HEALTH')
    updateBar('healthBar_', getProperty('health'), 2 or 0, 8, 'HEALTH')

    makeLuaSprite('songDisplayer_', '', 20, 310)
    makeGraphic('songDisplayer_', 208, 189, '200020')
    setObjectCamera('songDisplayer_', 'other')
    addLuaSprite('songDisplayer_', true)

    local ratingColor = switchCase(getProperty('ratingFC'), {
        SFC = '33ffa1',
        GFC = '4dff69',
        FC = 'a0ff53',
        SDCB = '7DFF00',
        Clear = 'd1d102',
    }) or 'ffffff'
    outlinedBar('noteHitsBar', 20, 461, 200, 28, ratingColor, '200020', 8, getProperty('ratingFC'))
    setBarByPercent('noteHitsBar', getProperty('ratingPercent') or 0, 8, getProperty('ratingFC'))

    makeLuaText('songNameText_', songName:upper()..'\n'..difficultyName:upper()..'\n', getMidpointX('songDisplayer_'), 310, 18)
    if getProperty('songNameText_.width') > getProperty('songDisplayer_.width')-5 then
        setGraphicSize('songNameText_', getProperty('songDisplayer_.width')-5)
    end
    setProperty('songNameText_.x', getProperty('songNameText_.x')-getProperty('songNameText_.width')/2)
    setTextColor('songNameText_', '0x60b00fff')
    setTextBorder('songNameText_', 1, '0x80200020')
    setTextAlignment('songNameText_', 'center')

    makeLuaText('detailShit', string.format('SICKS: %s\nGOODS: %s\nBADS: %s\nSHITS: %s\nMISSES: %s\n', getProperty('sicks'), getProperty('goods'), getProperty('bads'), getProperty('shits'), getProperty('songMisses')), 22.5, getMidpointY('songDisplayer_'), 17)
    setTextColor('detailShit', '200020')
    setTextBorder('detailShit', 1, '20ffff2')
    setProperty('detailShit.y', getProperty('detailShit.y')-(getProperty('detailShit.height')-20)/2)
    setTextAlignment('detailShit', 'left')
end

function to_hex(r, g, b) return string.format('%x', (r * 0x10000) + (g * 0x100) + b) end
function getHealthBarColor(char)
    return to_hex(getProperty(char..'.healthColorArray[0]'), getProperty(char..'.healthColorArray[1]'), getProperty(char..'.healthColorArray[2]'))
end

function switchCase(var, cases)
    for _, __ in pairs(cases) do
        if var == _ then
            return __
        end
    end
end

function outlinedBar(tag, x, y, width, height, color, outcolor, depth, text) -- cherry bar but ported to lua and i added an outline and a text (yes i made a haxe class called cherry bar)
    makeLuaSprite(tag..'__OUTLINE', '', x, y)
    makeGraphic(tag..'__OUTLINE', width+depth, height+depth, outcolor)
    setObjectCamera(tag..'__OUTLINE', 'other')
    addLuaSprite(tag..'__OUTLINE', true)

    makeLuaSprite(tag, '', x+depth/2, y+depth/2)
    makeGraphic(tag, 1, height, color)
    setObjectCamera(tag, 'other')
    addLuaSprite(tag, true)

    makeLuaText(tag..'__TEXT', text..': %0', x+depth, y+depth, 14)
    setProperty(tag..'__TEXT.x', x+(width-depth)/2-getProperty(tag..'__TEXT.width')/2)
    setProperty(tag..'__TEXT.y', y+(height+depth)/2-getProperty(tag..'__TEXT.height')/2)
    setTextColor(tag..'__TEXT', outcolor)
    setTextBorder(tag..'__TEXT', 1, color)
    setTextAlignment(tag..'__TEXT', 'center')
    setProperty(tag..'__TEXT.antialiasing', true)
end

function updateBar(bar, currentAmount, maxAmount, depth, text, exTxt)
    local p = (currentAmount/maxAmount)
    exTxt = exTxt or ''
    local width = (getProperty(bar..'__OUTLINE.width')-depth)*p
    if p ~= p then p = 0 end
    -- setGraphicSize(bar, width, getProperty(bar..'.height'), true)
    -- setProperty(bar..'.x', getProperty(bar..'__OUTLINE.x')+depth/2)
    setTextString(bar..'__TEXT', string.format('%s: %.2f%%%s', text, p*100, exTxt))
    newLerper(bar, p*100, depth)
end

function setBarByPercent(bar, percent, depth, text, exTxt)
    exTxt = exTxt or ''
    local width = (getProperty(bar..'__OUTLINE.width')-depth)*percent
    -- setGraphicSize(bar, width, getProperty(bar..'.height'), true)
    -- setProperty(bar..'.x', getProperty(bar..'__OUTLINE.x')+depth/2)
    setTextString(bar..'__TEXT', string.format('%s: %.2f%%%s', text, percent*100, exTxt))
    newLerper(bar, percent*100, depth)
end
 
local function lerp(a, b, ratio)
    return a + ratio * (b - a)
end

local lerperBars = {} -- cool lerp effect when result screen is open
function newLerper(bar, curPercent, depth, width)
    lerperBars[bar] = {curValue = 0, finalValue = curPercent, depth = depth}
end
function onUpdate(elapsed)
    bestcombo = math.max(bestcombo, getProperty('combo'))
end

local pepsi = false
function onEndSong()
    local resultScreen = substate:new('results')
    resultScreen.create = displayShit()
    resultScreen.update = function(elapsed) if
        keyboardJustPressed('ENTER') then resultScreen.close() endSong() end
        for _, __ in pairs(lerperBars) do
            __.curValue = lerp(__.curValue, __.finalValue, elapsed*2)
            setGraphicSize(_, (getProperty(_..'__OUTLINE.width')-__.depth)*(__.curValue/100), getProperty(_..'.height'), true)
            setProperty(_..'.x', getProperty(_..'__OUTLINE.x')+__.depth/2)
            if __.curValue == __.finalValue then
                lerperBars[_] = nil
            end
        end
    end
    if not pepsi then pepsi = true resultScreen.open(true) return Function_Stop else return Function_Continue end
end
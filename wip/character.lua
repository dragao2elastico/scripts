local canSelect

local allowCountdown = false

local Select = true

SelectAmount = 1
SelectAmountBack = -1

local MaxProductLimit = 3
local MinProductLimit = 1

local canSpace = false

local ProductSelected

function onCreate()
	initSaveData('DataFolder', 'Folder')
	flushSaveData('DataFolder')
	MoneyAmount = getDataFromSave('DataFolder', 'Money') -- Do NOT Remove Money, unless you're changing all the variables.

function onStartCountdown()
	if not allowCountdown then
            canSpace = true
		allowCountdown = true
		return Function_Stop;
	end
	return Function_Continue;
end

	      makeLuaSprite('ui', 'select/ui/screen', 0, 0)
            setObjectCamera('ui', 'hud')
	      addLuaSprite('ui', true)
            setProperty('ui.visible', true)

	      makeLuaSprite('arrow', 'select/arrow', 0, 0)
            setObjectCamera('arrow', 'hud')
	      addLuaSprite('arrow', true)
            setProperty('arrow.visible', false)

	      makeLuaSprite('bf', 'select/character/boyfriend', 0, 0)
            setObjectCamera('bf', 'hud')
	      addLuaSprite('bf', true)
            setProperty('bf.visible', false)

	      makeLuaSprite('bfName', 'select/names/bfName', 0, 0)
            setObjectCamera('bfName', 'hud')
	      addLuaSprite('bfName', true)
            setProperty('bfName.visible', false)

	      makeLuaSprite('bfShadow', 'select/portrait/bfShadow', 0, 0)
            setObjectCamera('bfShadow', 'hud')
	      addLuaSprite('bfShadow', true)
            setProperty('bfShadow.visible', false)

	      makeLuaSprite('pico', 'select/character/pico', 0, 0)
            setObjectCamera('pico', 'hud')
	      addLuaSprite('pico', true)
            setProperty('pico.visible', false)

	      makeLuaSprite('picoName', 'select/names/picoName', 0, 0)
            setObjectCamera('picoName', 'hud')
	      addLuaSprite('picoName', true)
            setProperty('picoName.visible', false)

	      makeLuaSprite('picoShadow', 'select/portrait/picoShadow', 0, 0)
            setObjectCamera('picoShadow', 'hud')
	      addLuaSprite('picoShadow', true)
            setProperty('picoShadow.visible', false)

	      makeLuaSprite('tank', 'select/character/tankman', 0, 0)
            setObjectCamera('tank', 'hud')
	      addLuaSprite('tank', true)
            setProperty('tank.visible', false)

	      makeLuaSprite('tankName', 'select/names/tankmanName', 0, 0)
            setObjectCamera('tankName', 'hud')
	      addLuaSprite('tankName', true)
            setProperty('tankName.visible', false)

	      makeLuaSprite('tankShadow', 'select/portrait/tankShadow', 0, 0)
            setObjectCamera('tankShadow', 'hud')
	      addLuaSprite('tankShadow', true)
            setProperty('tankShadow.visible', false)

		ProductSelected = 0

	end

function onCreatePost()
	      setProperty('timeTxt.visible', false)
	      setProperty('iconP1.visible', false)
	      setProperty('iconP2.visible', false)
	      setProperty('healthBar.visible', false)
	      setProperty('healthBarBG.visible', false)
	      setProperty('scoreTxt.visible', false)
	      setProperty('boyfriend.visible', false)
	      setProperty('gf.visible', false)
	      setProperty('dad.visible', false)
end

function onUpdate()
            if canSpace == true then
            if keyboardJustPressed('SPACE') then
            Select = false
            setProperty('ui.visible', false)
            setProperty('arrow.visible', false)
            setProperty('bf.visible', false)
            setProperty('bfName.visible', false)
            setProperty('bfShadow.visible', false)
            setProperty('pico.visible', false)
            setProperty('picoName.visible', false)
            setProperty('picoShadow.visible', false)
            setProperty('tank.visible', false)
            setProperty('tankName.visible', false)
            setProperty('tankShadow.visible', false)
	      setProperty('timeTxt.visible', true)
	      setProperty('iconP1.visible', true)
	      setProperty('iconP2.visible', true)
	      setProperty('healthBar.visible', true)
	      setProperty('healthBarBG.visible', true)
	      setProperty('scoreTxt.visible', true)
	      setProperty('boyfriend.visible', true)
	      setProperty('gf.visible', true)
	      setProperty('dad.visible', true)
		startCountdown()
          end 
         end

            if Select == true then
		if keyboardJustPressed('UP') or keyboardJustPressed('DOWN') then

			if ProductSelected >= MaxProductLimit and keyboardJustPressed('DOWN') then
				ProductSelected = 1
			elseif ProductSelected <= MinProductLimit and keyboardJustPressed('UP') then
				ProductSelected = 3
			else
				if keyboardJustPressed('DOWN') then
					ProductSelected = ProductSelected + 1
				end
				if keyboardJustPressed('UP') then
					ProductSelected = ProductSelected - 1
				end
			end
			if ProductSelected == 1 then
                        setProperty('arrow.y', 0)
                        setProperty('arrow.visible', true)
                        setProperty('bf.visible', true)
                        setProperty('bfName.visible', true)
                        setProperty('bfShadow.visible', true)
                        setProperty('pico.visible', false)
                        setProperty('picoName.visible', false)
                        setProperty('picoShadow.visible', false)
                        setProperty('tank.visible', false)
                        setProperty('tankName.visible', false)
                        setProperty('tankShadow.visible', false)
                  elseif ProductSelected == 2 then
                        setProperty('arrow.y', 35)
                        setProperty('arrow.visible', true)
                        setProperty('bf.visible', false)
                        setProperty('bfName.visible', false)
                        setProperty('bfShadow.visible', false)
                        setProperty('pico.visible', true)
                        setProperty('picoName.visible', true)
                        setProperty('picoShadow.visible', true)
                        setProperty('tank.visible', false)
                        setProperty('tankName.visible', false)
                        setProperty('tankShadow.visible', false)
                  elseif ProductSelected == 3 then
                        setProperty('arrow.y', 70)
                        setProperty('arrow.visible', true)
                        setProperty('bf.visible', false)
                        setProperty('bfName.visible', false)
                        setProperty('bfShadow.visible', false)
                        setProperty('pico.visible', false)
                        setProperty('picoName.visible', false)
                        setProperty('picoShadow.visible', false)
                        setProperty('tank.visible', true)
                        setProperty('tankName.visible', true)
                        setProperty('tankShadow.visible', true)
			end
                end
		if ProductSelected == 1 then
                  triggerEvent('Change Character', '0', 'bf')
	            setProperty('boyfriend.visible', false)
            elseif ProductSelected == 2 then
                  triggerEvent('Change Character', '0', 'pico-player')
	            setProperty('boyfriend.visible', false)
            elseif ProductSelected == 3 then
                  triggerEvent('Change Character', '0', 'tankman-player')
	            setProperty('boyfriend.visible', false)
		end
end
end
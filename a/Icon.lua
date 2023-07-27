-- gf icon script by Misha21220 [GD] (artycity21), this script sucks
function onCreate()

		        makeAnimatedLuaSprite('gficon', 'icons/gfIcon', 0, 0)
				addAnimationByPrefix('gficon', 'gf','neutral', 1, false)
				addAnimationByPrefix('gficon', 'boobas','booba', 1, false)
				addAnimationByPrefix('gficon', 'sad','sad', 1, false)
				addAnimationByPrefix('gficon', 'happy','smile', 1, false)				
                setObjectCamera('gficon', 'HUD')
                scaleObject('gficon', 1, 1)
                addLuaSprite('gficon', true)
                objectPlayAnimation('gficon', 'gf', false)					
end

function onUpdate()
  setObjectOrder('gficon', getObjectOrder('healthBar')+ 0) -- change 4 to 1 if you want to make gf icon behind bf and dad icons
  setProperty('gficon.x', getProperty('healthBar.x')+ 225)
  setProperty('gficon.y', getProperty('healthBar.y')- 100)  
	if getProperty('healthBar.percent') > 51 then
                setProperty('gficon.flipX', true)
        else
                setProperty('gficon.flipX', false)
    end

	if getProperty('healthBar.percent') > 80 then
       objectPlayAnimation('gficon', 'happy', false)  
	end   
    if getProperty('healthBar.percent') < 80 and getProperty('healthBar.percent') > 25 then
       objectPlayAnimation('gficon', 'gf', false)	
	end	
    if getProperty('healthBar.percent') < 25 then
       objectPlayAnimation('gficon', 'sad', false)	
	end

	setProperty('gficon.scale.x', getProperty('iconP1.scale.x'))
	setProperty('gficon.scale.y', getProperty('iconP1.scale.y'))
	setProperty('gficon.alpha', getProperty('healthBar.alpha'))
end --this script is old, i mean this script is first what i made, but TODAY, 29 NutNovember i made this script better and stronger and faster and se
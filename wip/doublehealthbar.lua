
function onCreate()
    precacheImage('gfidle') -- change "iconnamefile" to your correct file
    precacheImage('gfsad') -- change "iconnamefile" to your correct file
    precacheImage('bfidle') -- change "iconnamefile" to your correct file
    precacheImage('bfsad') -- change "iconnamefile" to your correct file

    makeLuaSprite('DoubleBar', 'doubleBar', 337, 600)
    scaleObject('DoubleBar', 1.003, 1.0)
    addLuaSprite('DoubleBar', false)
    setObjectCamera('DoubleBar', 'hud')
    setProperty('DoubleBar.alpha', 1)

    if downscroll then

    makeLuaSprite('DoubleBar', 'doubleBar', 337, 150)
    scaleObject('DoubleBar', 1.003, 1.0)
    addLuaSprite('DoubleBar', false)
    setObjectCamera('DoubleBar', 'hud')
    setProperty('DoubleBar.alpha', 1)
end
end

function onUpdate(elapsed)
    if getProperty('health') > 1.6 then
        setProperty('gfidle.visible', false) -- change "iconnameP1" to your correct name
        setProperty('gfsad.visible', true) -- change "iconnameloseP2" to your correct name
    else
        setProperty('gfidle.visible', true) -- change "iconnameP1" to your correct name
        setProperty('gfsad.visible', false) -- change "iconnameloseP2" to your correct name

    if getProperty('health') > 0.4 then
        setProperty('bfidle.visible', true) -- change "iconnameP1" to your correct name
        setProperty('bfsad.visible', false) -- change "iconnameloseP2" to your correct name
    else
        setProperty('bfidle.visible', false) -- change "iconnameP1" to your correct name
        setProperty('bfsad.visible', true) -- change "iconnameloseP2" to your correct name
    end
  end
end


function onCreatePost()
        makeLuaSprite('gfidle', 'double-icon/gfidle', getProperty('iconP2.x'), getProperty('iconP2.y')) -- change "iconnamefile" to your correct file
        setObjectCamera('gfidle', 'hud')
        addLuaSprite('gfidle', true)
        setObjectOrder('gfidle', getObjectOrder('iconP2') + 1)
        setProperty('gfidle.flipX', false)
        setProperty('gfidle.visible', true)

        makeLuaSprite('gfsad', 'double-icon/gfsad', getProperty('iconP2.x'), getProperty('iconP2.y')) -- change "iconnamefile2" to your correct file
        setObjectCamera('gfsad', 'hud')
        addLuaSprite('gfsad', true)
        setObjectOrder('gfsad', getObjectOrder('iconP2') + 1)
        setProperty('gfsad.flipX', false)
        setProperty('gfsad.visible', false)

        makeLuaSprite('bfidle', 'double-icon/bfidle', getProperty('iconP1.x'), getProperty('iconP1.y')) -- change "iconnamefile" to your correct file
        setObjectCamera('bfidle', 'hud')
        addLuaSprite('bfidle', true)
        setObjectOrder('bfidle', getObjectOrder('iconP1') + 1)
        setProperty('bfidle.flipX', true)
        setProperty('bfidle.visible', true)

        makeLuaSprite('bfsad', 'double-icon/bfsad', getProperty('iconP1.x'), getProperty('iconP1.y')) -- change "iconnamefile2" to your correct file
        setObjectCamera('bfsad', 'hud')
        addLuaSprite('bfsad', true)
        setObjectOrder('bfsad', getObjectOrder('iconP1') + 1)
        setProperty('bfsad.flipX', true)
        setProperty('bfsad.visible', false)

    if downscroll then

        makeLuaSprite('gfidle', 'double-icon/gfidle', getProperty('iconP2.x'), getProperty('iconP2.y')) -- change "iconnamefile" to your correct file
        setObjectCamera('gfidle', 'hud')
        addLuaSprite('gfidle', true)
        setObjectOrder('gfidle', getObjectOrder('iconP2') + 1)
        setProperty('gfidle.flipX', false)
        setProperty('gfidle.visible', true)

        makeLuaSprite('gfsad', 'double-icon/gfsad', getProperty('iconP2.x'), getProperty('iconP2.y')) -- change "iconnamefile2" to your correct file
        setObjectCamera('gfsad', 'hud')
        addLuaSprite('gfsad', true)
        setObjectOrder('gfsad', getObjectOrder('iconP2') + 1)
        setProperty('gfsad.flipX', false)
        setProperty('gfsad.visible', false)

        makeLuaSprite('bfidle', 'double-icon/bfidle', getProperty('iconP1.x'), getProperty('iconP1.y')) -- change "iconnamefile" to your correct file
        setObjectCamera('bfidle', 'hud')
        addLuaSprite('bfidle', true)
        setObjectOrder('bfidle', getObjectOrder('iconP1') + 1)
        setProperty('bfidle.flipX', true)
        setProperty('bfidle.visible', true)

        makeLuaSprite('bfsad', 'double-icon/bfsad', getProperty('iconP1.x'), getProperty('iconP1.y')) -- change "iconnamefile2" to your correct file
        setObjectCamera('bfsad', 'hud')
        addLuaSprite('bfsad', true)
        setObjectOrder('bfsad', getObjectOrder('iconP1') + 1)
        setProperty('bfsad.flipX', true)
        setProperty('bfsad.visible', false)
end
end

function onUpdatePost(elapsed)
        setProperty('gfidle.x', getProperty('iconP2.x') + 5) -- icon location X (firstIcon)
        setProperty('gfidle.angle', getProperty('iconP2.angle'))
        setProperty('gfidle.y', getProperty('iconP2.y') - 50) -- icon location Y (firstIcon)
        setProperty('gfidle.scale.x', getProperty('iconP2.scale.x') - 0.06) -- icon size X (firstIcon)
        setProperty('gfidle.scale.y', getProperty('iconP2.scale.y') - 0.06) -- icon size Y (FirstIcon)

        setProperty('gfsad.x', getProperty('iconP2.x') + 5) -- icon location X (secondIcon)
        setProperty('gfsad.angle', getProperty('iconP2.angle'))
        setProperty('gfsad.y', getProperty('iconP2.y') - 50) -- icon location Y (secondIcon)
        setProperty('gfsad.scale.x', getProperty('iconP2.scale.x') - 0.06) -- icon size X (secondIcon)
        setProperty('gfsad.scale.y', getProperty('iconP2.scale.y') - 0.06) -- icon size Y (secondIcon)

        setProperty('bfidle.x', getProperty('iconP1.x') + 5) -- icon location X (firstIcon)
        setProperty('bfidle.angle', getProperty('iconP1.angle'))
        setProperty('bfidle.y', getProperty('iconP1.y') - 60) -- icon location Y (firstIcon)
        setProperty('bfidle.scale.x', getProperty('iconP1.scale.x') - 0.06) -- icon size X (firstIcon)
        setProperty('bfidle.scale.y', getProperty('iconP1.scale.y') - 0.06) -- icon size Y (FirstIcon)

        setProperty('bfsad.x', getProperty('iconP1.x') + 5) -- icon location X (secondIcon)
        setProperty('bfsad.angle', getProperty('iconP1.angle'))
        setProperty('bfsad.y', getProperty('iconP1.y') - 60) -- icon location Y (secondIcon)
        setProperty('bfsad.scale.x', getProperty('iconP1.scale.x') - 0.06) -- icon size X (secondIcon)
        setProperty('bfsad.scale.y', getProperty('iconP1.scale.y') - 0.06) -- icon size Y (secondIcon)

    if downscroll then

        setProperty('gfidle.x', getProperty('iconP2.x') + 5) -- icon location X (firstIcon)
        setProperty('gfidle.angle', getProperty('iconP2.angle'))
        setProperty('gfidle.y', getProperty('iconP2.y') - -70) -- icon location Y (firstIcon)
        setProperty('gfidle.scale.x', getProperty('iconP2.scale.x') - 0.06) -- icon size X (firstIcon)
        setProperty('gfidle.scale.y', getProperty('iconP2.scale.y') - 0.06) -- icon size Y (FirstIcon)

        setProperty('gfsad.x', getProperty('iconP2.x') + 5) -- icon location X (secondIcon)
        setProperty('gfsad.angle', getProperty('iconP2.angle'))
        setProperty('gfsad.y', getProperty('iconP2.y') - -70) -- icon location Y (secondIcon)
        setProperty('gfsad.scale.x', getProperty('iconP2.scale.x') - 0.06) -- icon size X (secondIcon)
        setProperty('gfsad.scale.y', getProperty('iconP2.scale.y') - 0.06) -- icon size Y (secondIcon)

        setProperty('bfidle.x', getProperty('iconP1.x') + 5) -- icon location X (firstIcon)
        setProperty('bfidle.angle', getProperty('iconP1.angle'))
        setProperty('bfidle.y', getProperty('iconP1.y') - -60) -- icon location Y (firstIcon)
        setProperty('bfidle.scale.x', getProperty('iconP1.scale.x') - 0.06) -- icon size X (firstIcon)
        setProperty('bfidle.scale.y', getProperty('iconP1.scale.y') - 0.06) -- icon size Y (FirstIcon)

        setProperty('bfsad.x', getProperty('iconP1.x') + 5) -- icon location X (secondIcon)
        setProperty('bfsad.angle', getProperty('iconP1.angle'))
        setProperty('bfsad.y', getProperty('iconP1.y') - -60) -- icon location Y (secondIcon)
        setProperty('bfsad.scale.x', getProperty('iconP1.scale.x') - 0.06) -- icon size X (secondIcon)
        setProperty('bfsad.scale.y', getProperty('iconP1.scale.y') - 0.06) -- icon size Y (secondIcon)
end
end

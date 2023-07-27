------------------- (fancy game over animation script by ToufG#0001) ------------------

local animationToPlay = 'hurt' -- The animation to play when losing
local shouldBeForced = true -- If the animation should be forced or not.
local deathTxtText = {
    'Skill Issue.',
    'I seriously hope this was a joke.',
    'Could\'ve done better tbh.',
    'You\'re kinda mid.',
    'Dying on FNF in 2023.',
    'What the fuck.',
    'Have fun with these blue balls',
    'Fatality.',
    'Skill 100',
    'I\'m out of roasts.'
}

------------------------(no touching from there, k?)-------------------------

local bfHasDied = false
function onCreate()
makeLuaText('deathTxt', deathTxtText[getRandomInt(1,#deathTxtText)], 696, 300, 300)
setTextAlignment('deathTxt', 'center')
setTextSize('deathTxt', 75)
setTextColor('deathTxt', 'FF0000')
setObjectCamera('deathTxt', 'HUD')
addLuaText('deathTxt')
setProperty('deathTxt.alpha', 0)
end
function onGameOver()
bfHasDied = true
if getProperty('playbackRate') < 0.001 then
setProperty('playbackRate', 1)
return Function_Continue
end
return Function_Stop
end
function onUpdatePost()
if bfHasDied then
setProperty('deathTxt.alpha', getProperty('deathTxt.alpha')+0.001)
setProperty('playbackRate', getProperty('playbackRate')-0.001)
setProperty('dad.alpha', getProperty('dad.alpha')-0.001)
setProperty('cameraFollowPos.x', getProperty('boyfriend.x'))
setProperty('gf.alpha', getProperty('gf.alpha')-0.001)
setProperty('camera.zoom', getProperty('camera.zoom')+0.001)
characterPlayAnim('boyfriend', animationToPlay, shouldBeForced)
for i = 0, getProperty('notes.length')-1 do
if getPropertyFromGroup('notes', i, 'mustPress') then
setPropertyFromGroup('notes', i, 'x', getPropertyFromGroup('notes', i, 'x')+math.random(-20,20)*(getProperty('deathTxt.alpha')*5))
setPropertyFromGroup('notes', i, 'ignoreNote', true)
setPropertyFromGroup('notes', i, 'canBeHit', true)
end
end
end
end
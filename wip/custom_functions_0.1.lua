local second = 1
function onUpdate()
    runHaxeCode("game.setOnLuas('songPosition', " .. getPropertyFromClass('Conductor', 'songPosition') .. ");")
    if songPosition == 0 then
        runTimer('addmilisecond', 0.001, math.pow(69, 420))
        runTimer('addsecond', 1, math.pow(69, 420))
    end
end
function onTimerCompleted(tag)
    if tag == 'addsecond' then
        second = round(songPosition*0.001, 0) * 100
        callOnLuas('onSecondHit', {round(songPosition*0.001, 0)})
    end
    if tag == 'addmilisecond' then
        second = second + 1
        callOnLuas('onMilliSecondHit', {second})
    end
end
function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end
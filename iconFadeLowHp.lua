function onUpdate()
    if getProperty('health') <= 0.4 then
        doTweenAlpha('playericonout', 'iconP1', 0.75, 0.3, 'quartOut')
    else
        doTweenAlpha('playericonin', 'iconP1', 1, 0.1, 'quartOut')
            if getProperty('health') >= 1.625 then
                doTweenAlpha('oppiconout', 'iconP2', 0.75, 0.3, 'quartOut')
            else
                doTweenAlpha('oppiconin', 'iconP2', 1, 0.1, 'quartOut')
        end
    end
end
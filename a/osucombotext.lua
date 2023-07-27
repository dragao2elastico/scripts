function onCreatePost()
    makeLuaText("osucombo", "0x", 500, 0, 620) --left: 0 right: 775
    setTextSize("osucombo", 100)
    setTextAlignment("osucombo", "left")
    addLuaText('osucombo')
    makeLuaText("osucombosh", "0x", 500, 0, 620) --left: 0 right: 775
    setTextSize("osucombosh", 100)
    setTextAlignment("osucombosh", "left")
    addLuaText('osucombosh')
    setProperty('osucombosh.alpha', 0.5)
end

function onUpdatePost(elapsed)
    setTextString("osucombosh", getProperty("combo") .. "x")
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        setProperty("osucombo.scale.x", 1.25)
        setProperty("osucombo.scale.y", 1.25)
        setProperty("osucombo.x", 50) --left: 50 right: 725
        setProperty("osucombo.y", 610)
        doTweenX("osuxs", "osucombo.scale", 1, 0.25, "linear")
        doTweenY("osuys", "osucombo.scale", 1, 0.25, "linear")
        doTweenX("osux", "osucombo", 0, 0.25, "linear")
        doTweenY("osuy", "osucombo", 620, 0.25, "linear")
        setTextString("osucombo", getProperty("combo")-1 .. "x")
        runTimer("combocauter", 0.25)
        setProperty("osucombosh.scale.x", 1.75)
        setProperty("osucombosh.scale.y", 1.75)
        setProperty("osucombosh.x", 175) --left: 50 right: 725
        setProperty("osucombosh.y", 590)
        setProperty('osucombosh.alpha', 0.5)
        doTweenX("osuxss", "osucombosh.scale", 1, 0.25, "linear")
        doTweenY("osuyss", "osucombosh.scale", 1, 0.25, "linear")
        doTweenX("osuxsh", "osucombosh", 0, 0.25, "linear")
        doTweenY("osuysh", "osucombosh", 620, 0.25, "linear")
        doTweenAlpha("osuassh", "osucombosh", 0, 0.25, "linear")
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "combocauter" then
        setTextString("osucombo", getProperty("combo") .. "x")
    end
end
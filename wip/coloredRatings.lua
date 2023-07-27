-- in case you have different ratings, you can just add them by name to this table
-- RatingName = {"unique marker (make sure it doesn't match any other text that could be in scoreTxt)", 0xffffff }
replaceThing = {
    SFC = {"!!!", 0xedbb32},
    GFC = {"~!~", 0x44ecf2},
    FC = {">!>", 0x44f253},
    SDCB = {"<!<", 0x31ad3b},
    Clear = {"@!@", 0xaaadaa}
}


function onUpdateScore()
    if ratingFC ~= "" then
        currentTxt = getProperty("scoreTxt.text")
        curFc = ratingFC
        -- todo: fix it only working after the second note hit
        replacedTxt = replaceThing[curFc][1] .. curFc .. replaceThing[curFc][1]
        currentTxt = string.gsub(currentTxt, curFc, replacedTxt)

        -- setProperty("scoreTxt.text", currentTxt)
        markerClasses = "["
        
        for _,v in pairs(replaceThing) do
            markerClasses = markerClasses .. string.format("new FlxTextFormatMarkerPair(new FlxTextFormat(%s), '%s')", v[2], v[1]) 
            markerClasses = markerClasses .. ", "
        end
        markerClasses = string.sub(markerClasses, 1, -3) .. "]"

        
        addHaxeLibrary("FlxTextFormatMarkerPair", "flixel.text")
        addHaxeLibrary("FlxTextFormat", "flixel.text")
        runHaxeCode(string.format("game.scoreTxt.applyMarkup(\"%s\", %s);", currentTxt, markerClasses))

    end
    -- setProperty("scoreTxt.text", string.format("Score: %s ~ Misses: %s ~ Rating: %s"))
    
    return Function_Stop
end
local keybind = 'SIX' -- number six not numpad six
function saveScreenshot(path, x, y, width, height)
    if x == nil then x = 0 end
    if y == nil then y = 0 end
    if width == nil then width = screenWidth end
    if height == nil then height = screenHeight end
    addHaxeLibrary("Application", "lime.app")
    addHaxeLibrary("Rectangle", "lime.math")
    addHaxeLibrary("File", "sys.io")
    addHaxeLibrary("Main")
    return runHaxeCode([[
        var img = Application.current.window.readPixels(new Rectangle(]]..x..[[, ]]..y..[[, ]]..width..[[, ]]..height..[[));
        File.saveBytes("]]..path..[[", img.encode());
        return true;
    ]])
end
function onUpdatePost()
    if keyboardJustPressed(keybind) then
        saveScreenshot('mods/images/screenshots/'..os.time()..'.png', 0, 0, screenWidth, screenHeight)
    end
end
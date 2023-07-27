ffi = require 'ffi'

ffi.cdef [[
typedef int BYTE;
typedef int LONG;
typedef LONG DWORD;
typedef DWORD COLORREF;
typedef unsigned long HWND;

DWORD GetLastError();
HWND GetActiveWindow(void);
LONG SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
HWND SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
]]

local function RGBtoNumber(r, g, b)
    return tonumber(
               '0x' .. string.format('%02x', r) .. string.format('%02x', g) ..
                   string.format('%02x', b))
end

--[[
    How to use:

    ```lua
    function onCreate()
        -- Set transparence with color key set to black.
        -- Hex
        setWindowTransparency(true, {255, 255, 255})
        -- RBG
        setWindowTransparency(true, 0x00000000)

        -- Disable transparency
        setWindowTransparency()
    end
    ```
]]
local function setWindowTransparency(enable, color)
    if enable == nil then enable = false end
    if not enable or color == nil then
        color = RGBtoNumber(1, 1, 1)
    elseif type(color) == 'table' then
        color = RGBtoNumber(color[1], color[2], color[3])
    end

    local win = ffi.C.GetActiveWindow()
    if ffi.C.SetWindowLongA(win, -20, enable and 0x00080000 or 0) then
        ffi.C.SetLayeredWindowAttributes(win, color, 0, 0x00000001)
    end
end

-- Example code
function onCreatePost()
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    -- By default, the color key is {1, 1, 1}
    setWindowTransparency(true)

    -- Make a background so the thing is REALLY layered
    makeLuaSprite('layerBG', '', 0, 0)
    makeGraphic('layerBG', screenWidth, screenHeight, '010101')
    scaleObject('layerBG', 3, 3)
    screenCenter('layerBG')
    setScrollFactor('layerBG', 0, 0)
    addLuaSprite('layerBG')
end

function onDestroy()
    -- Remove transparency when not in PlayState
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
    setWindowTransparency()
end

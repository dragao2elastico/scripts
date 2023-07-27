bongoCatty = true
NKps = true

function onCreate()
	if bongoCatty == true then
		addLuaScript('auuugh/bongoCatMania.lua')
	else
		debugPrint('BongoCat is disabled')
	end
	if NKps == true then
		addLuaScript('auuugh/NKps.lua')
	else
		debugPrint('N/Kps is disabled.')
	end
end
local noteys = {}
local anims = {
  [0] = 'singLEFT',
  [1] = 'singDOWN',
  [2] = 'singUP',
  [3] = 'singRIGHT'
}
local og = false
-- function onCreatePost()
--   for i=0, 3 do
--     setPropertyFromGroup('opponentStrums', i, 'visible', 'false')
--     setPropertyFromGroup('playerStrums', i, 'x', screenWidth/2 + (110*(i-2)))
--   end
-- end
function onSpawnNote(i)
  if not getPropertyFromGroup('notes', i, 'mustPress') then
    setPropertyFromGroup('notes', i, 'mustPress', true)
    table.insert(noteys, 0, {true, getPropertyFromGroup('notes', i, 'noAnimation'), getPropertyFromGroup('notes', i, 'gfNote')})
    setPropertyFromGroup('notes', i, 'noAnimation', true)
    setPropertyFromGroup('notes', i, 'multAlpha', 0.5)
    setPropertyFromGroup('notes', i, 'hitHealth', 0)
  else
    table.insert(noteys, 0, false)
  end
end
function goodNoteHit(i, d)
  if noteys[i][1] then
    if not noteys[i][2] then
      playAnim('dad', anims[d], true)
      setProperty('dad.specialAnim', true)
    end
    setProperty('camZooming', true)
  end
  table.remove(noteys, i)
end
function noteMiss(i)
  table.remove(noteys, i)
end
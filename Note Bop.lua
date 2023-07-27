    --      --
      --   --
-- - --     -- - --
-- Note Bop      --  -- Give credits if used on public proyects.
-- 2.0.1         --  -- If you're going to modify this, please add a comment saying it.
--               --
-- By Zelta#4392 --  -- https://gamebanana.com/tools/11531
-- - --     -- - --  
--               --  -- Don't delete script's default comments. This is a mod takedown reason.



-- Settings --
--  Modify the script to make it perfect for your mod!


local bopStength = 28
--  This controls how low, (if you're using downbop), the notes will drop, or up, (if you're using upbop), the notes will raise.
--  Positive numbers self-adapt to negative if needed, so don't use negative numbers.

local opponentBop = true
--  If true, enemy's notes will bop on press.

local playerBop = true
--  If true, player's notes will bop on press.
--  If false, 'ghostBop' option will be deprecated.

local ghostBop = true
--  If true, player will have the ability to bop notes on press without waiting for note hits.

local bopDirection = { 
  --Valid values: 'up', 'down'.

  'up', --Upscroll mode
  'down', --Downscroll mode
}


-- Settingsn't --
--  Settings end here. Such a customizable script, huh?

local downToNega = 1

local keys = {'left','down','up','right'}

local relocatePosition = 571

function onCreatePost()

  opponentRelocatePos = getPropertyFromGroup('strumLineNotes', direction,'y')
  playerRelocatePos = getPropertyFromGroup('strumLineNotes', direction,'y')

  if downscroll then
    if bopDirection[2] == 'down' then
      downToNega = 1
    elseif bopDirection[2] == 'up' then
      downToNega = -1
    else
      errorThingy(bopDirection[2])
    end
  else
    if bopDirection[1] == 'down' then
      downToNega = 1
    elseif bopDirection[1] == 'up' then
      downToNega = -1
    else
      errorThingy(bopDirection[1])
    end
  end
end

function errorThingy(input)
  debugPrint("NOTE BOP SCRIPT: '"..input.."' isn't a valid value.")
end

function directionProcessing(bopStength)
  return bopStength*downToNega
end

function opponentNoteHit(x,direction,x,isSustainNote)
  if not isSustainNote and opponentBop then
    if getPropertyFromGroup('strumLineNotes', direction,'y') == opponentRelocatePos then
      opponentRelocatePos = getPropertyFromGroup('strumLineNotes', direction,'y')
    end
    cancelTween('opponentBop'..direction)
    setPropertyFromGroup('strumLineNotes', direction,'y',directionProcessing(bopStength)+opponentRelocatePos)
    noteTweenY('opponentBop'..direction, direction, opponentRelocatePos, 0.15,"circInOut")
  end
end

function goodNoteHit(x,direction,x,isSustainNote)
  if not isSustainNote and playerBop and not ghostBop then
    if getPropertyFromGroup('strumLineNotes', direction,'y') == playerRelocatePos then
      playerRelocatePos = getPropertyFromGroup('strumLineNotes', direction,'y')
    end
    cancelTween('playerBop'..direction)
    setPropertyFromGroup('strumLineNotes', direction+4,'y',directionProcessing(bopStength)+playerRelocatePos)
    noteTweenY('playerBop'..direction, direction+4,playerRelocatePos, 0.15,"circInOut")
  end
end

function onUpdate()
  if ghostBop and playerBop then
    for i = 1,4 do
      if keyReleased(keys[i]) then
        denyHold = false
      end
    end
    if not denyHold then
      for i = 1,4 do
        if keyJustPressed(keys[i]) then
          setPropertyFromGroup('strumLineNotes', i+3,'y',directionProcessing(bopStength)+playerRelocatePos)
          noteTweenY('playerBop'..i, i+3,playerRelocatePos, 0.15,"circInOut")
        end
      end
    end
  end
end
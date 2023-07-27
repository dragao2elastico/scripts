function onUpdatePost()

--------this is to put a button that does the 'hey' animation

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Z') then            -----change the Z to the letter of your taste
      characterPlayAnim('boyfriend', 'hey', true)
  end

--------this is to put a button that does the animations (up, down, left and right)

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.H') then            -----change the H in your up letter        
      characterPlayAnim('boyfriend', 'singUP', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F') then            -----change the F in your down letter        
      characterPlayAnim('boyfriend', 'singDOWN', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.J') then            -----change the J in your right letter        
      characterPlayAnim('boyfriend', 'singRIGHT', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.D') then            -----change the D in your left letter        
      characterPlayAnim('boyfriend', 'singLEFT', true)
  end

--------this is to put secondary key buttons (optional)

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.H') then            -----change the H in your secondary up letter        
      characterPlayAnim('boyfriend', 'singUP', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F') then            -----change the F in your secondary down letter         
      characterPlayAnim('boyfriend', 'singDOWN', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.J') then            -----change the J in your secondary right letter         
      characterPlayAnim('boyfriend', 'singRIGHT', true)
  end

      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.D') then            -----change the D in your secondary left letter         
      characterPlayAnim('boyfriend', 'singLEFT', true)
  end
end
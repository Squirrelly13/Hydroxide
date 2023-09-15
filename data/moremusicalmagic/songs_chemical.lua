
ocarina_songs["tinker"] = { "a2", "f", "d", "b", "a", "c", "e", "gsharp", "a2" }  --Hinted at in desert chasm

ocarina_funcs["tinker"] = function()                  --Note: This is infinitely reusable and has no cooldown
  local x, y = EntityGetTransform( entity_id )
  EntityLoad( "mods/Hydroxide/files/entities/misc/tinkersong.xml", x, y )
  GamePrintImportant( "The Gods sing along to your song", "Can you hear them?" )
end



ocarina_songs["tinker"] = { "a2", "f", "d", "b", "a", "c", "e", "gsharp", "a2" }  --Hinted at in desert chasm

ocarina_funcs["tinker"] = function()                  --Note: This is infinitely reusable and has no cooldown
  local x, y = EntityGetTransform( entity_id )
  EntityLoad( "mods/Hydroxide/files/chemical_curiosities/materials/tinker_dust/tinkersong.xml", x, y )
  GamePrintImportant( "$log_cc_tinkersong_secret", "$log_cc_tinkersong_secret_desc" )
end


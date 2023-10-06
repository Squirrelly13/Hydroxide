RegisterSpawnFunction( 0xffd795e3, "spawn_hatch")

local old_init = init

init = function(x, y, w, h)
    LoadPixelScene("mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house.png", "", x + 88, y - 189, "", true, false, nil, nil, true)

    old_init(x, y, w, h)
end

function spawn_hatch ( x, y )
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/hatch.xml", x + 13.5, y + 3 )
end
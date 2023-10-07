RegisterSpawnFunction( 0xffd795e3, "spawn_hatch")
RegisterSpawnFunction( 0xff6ab83a, "spawn_door")
RegisterSpawnFunction( 0xfff6c71f, "spawn_chandelier")
RegisterSpawnFunction( 0xffd49910, "spawn_lantern")
RegisterSpawnFunction( 0xff4d69d6, "spawn_table")
RegisterSpawnFunction( 0xffcd94dd, "spawn_desk")
RegisterSpawnFunction( 0xff8b2ea4, "spawn_bedroom")
RegisterSpawnFunction( 0xff33338a, "spawn_warderobe")

local old_init = init

init = function(x, y, w, h)
    LoadPixelScene("mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house.png", "mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house_visual.png", x + 88, y - 189, "mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house_bg.png", true, false, nil, nil, true)

    old_init(x, y, w, h)
end

function spawn_hatch ( x, y )
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/hatch.xml", x + 13.5, y + 3 )
end

function spawn_door ( x, y )
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/door/door.xml", x + 0.5, y + 1 )
end

function spawn_chandelier ( x, y )
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/chandelier.xml", x, y + 4 )
end

function spawn_lantern ( x, y )
    EntityLoad( "data/entities/props/physics/lantern_small.xml", x, y )
end

function spawn_table ( x, y )
    x = x + 1
    EntityLoad( "data/entities/props/furniture_wood_table.xml", x, y )
    EntityLoad( "data/entities/props/physics_chair_1.xml", x - 18, y )
    EntityLoad( "data/entities/props/physics_chair_2.xml", x + 18, y )
end

function spawn_desk ( x, y )
    x = x + 6
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/desk.xml", x, y )
    EntityLoad( "data/entities/props/physics_chair_2.xml", x + 10, y )
    EntityLoad( "mods/Hydroxide/files/mystical_mixtures/journal/journal_entity.xml", x, y - 13 )
end

function spawn_bedroom ( x, y )
    --GamePrint("Bedroom")
    EntityLoad( "data/entities/props/furniture_bed.xml", x + 7, y )
    --EntityLoad( "data/entities/props/furniture_wardrobe.xml", x - 2, y )
end

function spawn_warderobe ( x, y )
    EntityLoad( "data/entities/props/furniture_wardrobe.xml", x - 5, y )
end
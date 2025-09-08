dofile_once("data/scripts/lib/utilities.lua")

table.insert( actions,{
    id          = "CC_SEA_OF_METHANE",
    name         = "$action_cc_sea_of_methane",
    author        = "$cc_name_squirrelly",
    origin         = "$cc_branch_name_cc",
    description = "$action_desc_cc_sea_of_methane",
    sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/sea_methane.png",
    type         = ACTION_TYPE_MATERIAL,
    spawn_level                       = "0,4,5,6",
    spawn_probability                 = "1,1,1,1",
    price = 350,
    mana = 140,
    max_uses = 3,
    action         = function()
        add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/sea_methane.xml")
        c.fire_rate_wait = c.fire_rate_wait + 15
    end,
} );

table.insert( actions,{
    id            = "CC_WISPY_FLAME",
    name        = "$action_cc_wispy_flame",
    author        = "$cc_name_squirrelly",
    origin         = "$cc_branch_name_cc",
    description    = "$action_desc_cc_wispy_flame",
    sprite        = "mods/Hydroxide/files/chemical_curiosities/spells/projectiles/wispy_flame.png",
    related_projectiles = {"mods/Hydroxide/files/chemical_curiosities/spells/projectiles/wispy_flame.xml"},
    type        = ACTION_TYPE_PROJECTILE,
    spawn_level                        = "1,2,3,4,5,6,7",
    spawn_probability                = "1,1,0,0,1,0,0",
    price        = 200,
    mana        = 10,
    action        = function()
        add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/projectiles/wispy_flame.xml")
        c.fire_rate_wait = c.fire_rate_wait + 10
    end,
});

table.insert( actions, {
    id            = "CC_LOCAL_SHIFT",
    name        = "$action_cc_local_shift",
    author        = "$cc_name_squirrelly",
    origin         = "$cc_branch_name_cc",
    description    = "$action_desc_cc_local_shift",
    sprite        = "mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.png",
    related_projectiles = {"mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.xml"},
    type         = ACTION_TYPE_PROJECTILE,
    spawn_level                       = "2,3,4,5,6", -- LOCAL_SHIFT
    spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- LOCAL_SHIFT
    price = 400,
    mana = 260,
    max_uses     = 10,
    action        = function()
        add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.xml")
        c.fire_rate_wait    = c.fire_rate_wait + 60
        current_reload_time = current_reload_time + 60
    end,
});

table.insert( actions,  {
        id                  = "CC_METAL_SEASONING",
        name                = "$action_cc_metal_seasoning",
        author                = "$cc_name_squirrelly",
        origin                 = "$cc_branch_name_cc",
        description         = "$action_desc_cc_metal_seasoning",
        sprite              = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/metal_seasoning.png",
        related_projectiles = { "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/metal_seasoning.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,4,5", -- MATERIAL_WATER
        spawn_probability   = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
        price               = 110,
        mana                = 2,
        sound_loop_tag      = "sound_spray",
        action              = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/metal_seasoning.xml")
            c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
});

table.insert( actions, {
        id          = "CC_CLOUD_CRYSTAL",
        name         = "$action_cc_cloud_crystal",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_cloud_crystal",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_crystal.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles    = {"mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_crystal.xml"},
        type         = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability                 = "0.4,0.4,0.4,0.4,0.4,0.4", -- CLOUD_WATER
        price = 100,
        mana = 20,
        max_uses = 15,
        action         = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_crystal.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
});

table.insert( actions, {
        id          = "CC_CLOUD_SPARKLING",
        name         = "$action_cc_cloud_sparkling",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_cloud_sparkling",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_sparkling.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles    = {"mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_sparkling.xml"},
        type         = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability                 = "0.0,0.2,0.2,0.3,0.4,0.5", -- CLOUD_WATER
        price = 200,
        mana = 50,
        max_uses = 3,
        action         = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_sparkling.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
});

table.insert( actions, {
        id          = "CC_GREASE_BLAST",
        name         = "$action_cc_grease_blast",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_grease_blast",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/grease_blast.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/poison_blast_unidentified.png",
        related_projectiles    = {"mods/Hydroxide/files/chemical_curiosities/spells/material_spells/grease_blast.xml"},
        type         = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "1,2,4,6", -- POISON_BLAST
        spawn_probability                 = "0.5,0.6,0.6,0.7", -- POISON_BLAST
        price = 140,
        mana = 30,
        --max_uses = 30,
        custom_xml_file = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/grease_blast_card.xml",
        is_dangerous_blast = true,
        action         = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/grease_blast.xml")
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
        end,
});



table.insert( actions, {
        id          = "CC_RADIOACTIVE_SHOT",
        name         = "Radioactive shot",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "Makes a projectile emit radioactive sparks",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/projectile_modifiers/radioactive_shot.png",
        sprite_unidentified = "mods/Hydroxide/files/chemical_curiosities/spells/projectile_modifiers/radioactive_shot.png",
        related_extra_entities = { "mods/Hydroxide/files/chemical_curiosities/spells/projectile_modifiers/radioactive_shot.xml" },
        type         = ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,3,4,5", -- TENTACLE_RAY
        spawn_probability                 = "0,0,0.4,0.4,0.4", -- TENTACLE_RAY
        price = 150,
        mana = 110,
        max_uses = 16,
        action         = function()
            c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/chemical_curiosities/spells/projectile_modifiers/radioactive_shot.xml,"
            draw_actions( 1, true )
        end,
});

table.insert( actions,     {
        id                  = "CC_URANIUMBALL",
        name                = "$action_cc_radioactive_shot",
        author                = "$cc_name_squirrelly",
        origin                 = "$cc_branch_name_cc",
        description         = "$action_desc_cc_radioactive_shot",
        sprite              = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/uraniumball.png",
        related_projectiles = { "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/uraniumball.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,4,5", -- SOILBALL
        spawn_probability   = "0.5,0.5,0.5,1,1", -- SOILBALL
        price               = 70,
        mana                = 5,
        action              = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/uraniumball.xml")
        end,
});

table.insert( actions,    {
        id          = "CC_ANTIMATTER_FIELD_ENEMY",
        name         = "$action_cc_antimatter_field_enemy",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_antimatter_field_enemy",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/antimatter_field/antimatter_field_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Hydroxide/files/chemical_curiosities/spells/antimatter_field/hitfx_antimatterfield.xml" },
        type         = ACTION_TYPE_MODIFIER,
        spawn_level                       = "4,5",
        spawn_probability                 = "0.3,0.3",
        price = 350,
        mana = 150,
        max_uses = 20,
        action         = function()
            c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/chemical_curiosities/spells/antimatter_field/hitfx_antimatterfield.xml,"
            draw_actions( 1, true )
        end,
});



table.insert( actions,{
    id          = "CC_SEA_OF_LIGHTNING",
    name         = "$action_cc_sea_of_lightning",
    author        = "$cc_name_squirrelly",
    origin         = "$cc_branch_name_cc",
    description = "$action_desc_cc_sea_of_lightning",
    sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/sea_lightning.png",
    type         = ACTION_TYPE_MATERIAL,
    spawn_level                       = "0,4,5,6",
    spawn_probability                 = "0.4,1,0.5,1",
    price = 350,
    mana = 140,
    max_uses = 3,
    action         = function()
        add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/sea_lightning.xml")
        c.fire_rate_wait = c.fire_rate_wait + 15
    end,
});

table.insert( actions, {
    id            = "CC_GUNPOWDER_BUFF",
    name        = "$action_cc_gunpowder_buff",
    author        = "$cc_name_squirrelly",
    origin         = "$cc_branch_name_cc",
    description    = "$action_desc_cc_gunpowder_buff",
    sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/gunpowder_buff.png",
    related_extra_entities = { "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/gunpowder_buff.xml", "data/entities/particles/tinyspark_red.xml" },
    type        = ACTION_TYPE_MODIFIER,
    spawn_level                     = "2,3,4",
    spawn_probability                = "0.5,0.5,0.5",
    price = 90,
    mana = 30,

    action         = function()
        if c.trail_material:find("gunpowder,") then


            local entity_id    = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform( entity_id )

            SetRandomSeed( pos_x + 436, pos_y - 3252 )
            local material_options = { "cc_blasting_powder", "cc_kindling", "cc_thunder_powder" }
            local rare = false
            local rnd = 1
            local material = "gunpowder"

            rnd = Random( 1, #material_options )
            material = material_options[rnd]

            c.trail_material = c.trail_material:gsub("gunpowder,", material .. ",")
        end
        c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/gunpowder_buff.xml,data/entities/particles/tinyspark_red.xml,"
        c.fire_rate_wait = c.fire_rate_wait + 10
        draw_actions( 1, true )
    end,
});


table.insert( actions, {
        id          = "CC_FIRE_TO_GREASE",
        name         = "$action_cc_fire_to_grease",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_fire_to_grease",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/fire_to_grease.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/fire_to_grease.xml", "data/entities/particles/tinyspark_red.xml" },
        type         = ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4", -- FIRE_TO_GREASE
        spawn_probability                 = "0.8,0.8,0.9", -- FIRE_TO_GREASE
        price = 100,
        mana = 25,
        max_uses = 25,
        action         = function()
            c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/chemical_curiosities/spells/material_enhancers/fire_to_grease.xml,data/entities/particles/tinyspark_red.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 6
            draw_actions( 1, true )
        end,
    });


table.insert( actions, {
        id          = "CC_CLOUD_GUNPOWDER",
        name         = "$action_cc_gunpowder_cloud",
        author        = "$cc_name_squirrelly",
        origin         = "$cc_branch_name_cc",
        description = "$action_desc_cc_gunpowder_cloud",
        sprite         = "mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_gunpowder.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles    = {"mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_gunpowder.xml"},
        type         = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "1,2,3,4,5,7", -- CLOUD_WATER
        spawn_probability                 = "0.4,0.2,0.3,0.4,0.5,0.8", -- CLOUD_WATER
        price = 200,
        mana = 50,
        max_uses = 3,
        action         = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/material_spells/cloud_gunpowder.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
    });

    table.insert( actions, {
        id            = "CC_MAGIC_CIRCLE",
        name        = "magic circle",
        origin         = "$cc_branch_name_cc",
        description    = "spawns a magic circle for testing purposes",
        sprite        = "mods/Hydroxide/files/chemical_curiosities/spells/magic_circle/spell_icon.png",
        related_projectiles = {"mods/Hydroxide/files/chemical_curiosities/spells/magic_circle/projectile.xml"},
        type         = ACTION_TYPE_PROJECTILE,
        spawn_level                       = "",
        spawn_probability                 = "",
        price = 400,
        mana = 260,
        max_uses     = 10,
        action        = function()
            add_projectile("mods/Hydroxide/files/chemical_curiosities/spells/magic_circle/projectile.xml")
            c.fire_rate_wait    = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 60
        end,
    });
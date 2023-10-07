local welding = dofile_once("mods/Hydroxide/files/mystical_mixtures/alchemy/action_welding/welding_handler.lua")
alchemical_materials = {
    {
        id = "mm_alchemical_solvent", -- id of the material
        name = "$mat_mm_alchemical_solvent", -- name of the material
        description = "$desc_mm_alchemical_solvent",
        generate_notes = true,
        color = "FF72BFD8", -- visual color
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",
    },
    {
        id = "mm_alchemical_base",
        name = "$mat_mm_alchemical_base",
        description = "$desc_mm_alchemical_base",
        generate_notes = true,
        color = "c77e6996",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",       
    },
    {
        id = "mm_ephemeral_ether",
        name = "$mat_mm_ephemeral_ether",
        description = "$desc_mm_ephemeral_ether",
        generate_notes = true,
        color = "C60AFFD2",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",
        density = 1.1,
    },
    {
        id = "mm_ephemeral_ether_gas",
        name = "$mat_mm_ephemeral_ether_gas",
        description = "$desc_mm_ephemeral_ether_gas",
        color = "410AFFD2",
        texture = nil, -- texture path
        type = "gas",
        tags = "",
        lifetime = 200,
        burnable = true,
        glow = 20,
    },
    {
        id = "mm_gold_solution",
        name = "$mat_mm_gold_solution",
        description = "$desc_mm_gold_solution",
        generate_notes = true,
        color = "FFFFDF86",
        texture = "data/materials_gfx/gold.png", -- texture path
        type = "liquid",
        tags = "[alchemical]",
        density = 3.7,
        glow = 200,
    },
    {
        id = "mm_replicating_agent",
        name = "$mat_mm_replicating_agent",
        description = "$desc_mm_replicating_agent",
        generate_notes = true,
        color = "8AEF5FE6",
        texture = nil, -- texture path
        type = "liquid",
        glow = 150,
        density = 4.6,
    },
    {
        id = "mm_diluted_mana",
        name = "$mat_mm_diluted_mana",
        description = "$desc_mm_diluted_mana",
        generate_notes = true,
        color = "A27ACDE0",
        type = "liquid",
        tags = "[alchemical]",
        density = 2.9,
        glow = 120,
    },
    {
        id = "mm_refined_mana",
        name = "$mat_mm_refined_mana",
        description = "$desc_mm_refined_mana",
        generate_notes = true,
        color = "E500A9AC",
        type = "liquid",
        tags = "[alchemical]",
        density = 3.4,
        glow = 200,
    },
    {
        id = "mm_refined_mana_gas",
        name = "$mat_mm_refined_mana_gas",
        description = "$desc_mm_refined_mana_gas",
        color = "493DACB8",
        texture = nil, -- texture path
        type = "gas",
        tags = "",
        lifetime = 200,
        burnable = true,
        glow = 20,
    },
    {
        id = "mm_arcane_flux",
        name = "$mat_mm_arcane_flux",
        description = "$desc_mm_arcane_flux",
        generate_notes = true,
        color = "A1FF0084",
        type = "liquid",
        tags = "[alchemical]",
        density = 1.1,
        burnable = true,
        fire_hp = 100,
        glow = 250,
    },
    {
        id = "mm_mystic_alloy",
        name = "$mat_mm_mystic_alloy",
        description = "$desc_mm_mystic_alloy",
        generate_notes = true,
        color = "FF916179",
        type = "powder",
        tags = "[alchemical]",
        density = 6,
        burnable = false,
        glow = 50,
        texture="mods/Hydroxide/files/mystical_mixtures/gfx/materials/arcane_metal.png"
    },
}

alchemical_recipes = {
    {
        id = "ether_evaporation",
        probability = 3, 
        inputs = {
            "mm_ephemeral_ether",
            "air",
        },
        outputs = {
            "mm_ephemeral_ether_gas",
            "air",
        },
        func = nil
    },
    {
        id = "mana_evaporation",
        probability = 3, 
        inputs = {
            "mm_refined_mana",
            "air",
        },
        outputs = {
            "mm_refined_mana_gas",
            "air",
        },
        func = nil        
    },
    {
        id = "gold_solution",
        name = "$reac_gold_solution",
        description = "$reac_desc_gold_solution",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "[gold]",
            "[gold]",
            "mm_alchemical_solvent",
        },
        outputs = {
            "mm_gold_solution",
            "mm_gold_solution",
            "mm_ephemeral_ether",
        },
    },
    {
        id = "mana_dilution",
        name = "$reac_mana_dilution",
        description = "$reac_desc_mana_dilution",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "magic_liquid_mana_regeneration",
            "magic_liquid_mana_regeneration",
            "mm_alchemical_base",
        },
        outputs = {
            "mm_diluted_mana",
            "mm_diluted_mana",
            "mm_ephemeral_ether",
        },
    },
    {
        id = "mana_refining",
        name = "$reac_mana_refining",
        description = "$reac_desc_mana_refining",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "mm_diluted_mana",
            "mm_diluted_mana",
            "cc_hydroxide",
        },
        outputs = {
            "mm_refined_mana",
            "mm_ephemeral_ether",
            "mm_ephemeral_ether",
        },
    },    
    {
        id = "mystic_alloy",
        name = "$reac_mystic_alloy",
        description = "$reac_desc_mystic_alloy",
        generate_notes = true,
        probability = 100,
        inputs = {
            "item_box2d",
            "mm_alchemical_solvent",
        },
        outputs = {
            "mm_ephemeral_ether",
            "mm_ephemeral_ether",
        },
        func = function(x, y)
            local wands = EntityGetInRadius( x, y, 10 )
            for k, wand in pairs(wands)do
                local components = EntityGetAllComponents( wand )
                for k, component in pairs(components)do
                    local component_type = ComponentGetTypeName( component )
                    if(component_type == "SpriteComponent")then
                        local sprite = ComponentGetValue2(component, "image_file")
                        if(sprite == "data/items_gfx/broken_wand.png")then
                            local converter = EntityCreateNew("mystical_alloy_creation")
                            EntitySetTransform(converter, x, y)
                            EntityAddComponent2(converter, "LifetimeComponent", {
                                lifetime=2
                            })
                    
                            EntityAddComponent2(converter, "MagicConvertMaterialComponent", {
                                radius=20,
                                from_material=CellFactory_GetType("item_box2d"),
                                to_material=CellFactory_GetType("mm_mystic_alloy"),
                                is_circle=true,
                                loop=true
                            })
                        end
                    end
                end
            end
        end
    },
    {
        id = "arcane_flux_creation",
        name = "$reac_arcane_flux_creation",
        description = "$reac_desc_arcane_flux_creation",
        generate_notes = true,
        probability = 3,
        inputs = {
            "mm_refined_mana",
            "mm_mystic_alloy",
            "air",
        },
        outputs = {
            "mm_arcane_flux",
            "mm_arcane_flux",
            "mm_ephemeral_ether",
        },
    },
    {
        id = "wand_capacity",
        name = "$reac_wand_capacity",
        description = "$reac_desc_wand_capacity",
        generate_notes = true,
        probability = 100, 
        func_probability = 1,
        inputs = { -- three ingredients is the limit
            "mm_gold_solution",
            "mm_alchemical_base",
        },
        outputs = {
            "air",
            "mm_ephemeral_ether",
        },
        func = function(x, y)
            SetRandomSeed( x + 32523, y + 5325 + GameGetFrameNum() )
            local wands = EntityGetInRadiusWithTag(x, y, 16, "wand") or {}
            for k, v in ipairs(wands)do
                local wand = v
                local is_free = (EntityGetRootEntity(v) == v) and not EntityHasTag(v, "capacity_altered")
                if(is_free)then
                    local ability_component = EntityGetFirstComponentIncludingDisabled(v, "AbilityComponent")
                    if(ability_component ~= nil)then
                        local capacity = ComponentObjectGetValue2(ability_component, "gun_config", "deck_capacity")
                        -- randomize the capacity

                        local min_slots = math.max(-(capacity - 1), -3)
                        local max_slots = math.min(5, capacity)

                        local new_capacity = capacity + math.floor(Random(min_slots, max_slots))

                        if new_capacity < 1 then
                            new_capacity = 1
                        end

                        ComponentObjectSetValue2(ability_component, "gun_config", "deck_capacity", new_capacity)
                        -- if new capacity is under old capacity, check if wand has more spells than new capacity

                        local c = EntityGetAllChildren( wand ) or {}
                        EntityAddTag(v, "capacity_altered")
                        
                        if #c > new_capacity then
                            local spells_to_remove = #c - new_capacity
                            for i=1,spells_to_remove do
                                -- 
                                v = c[(#c)-i + 1]
                                local comp2 = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent" )

                                if(comp2 ~= nil)then

                                    EntityRemoveFromParent( v )
                                    EntitySetTransform( v, x, y )
                                    
                                    local all = EntityGetAllComponents( v )
                                    
                                    for a,b in ipairs( all ) do
                                        EntitySetComponentIsEnabled( v, b, true )
                                    end
                                end
                            end
                        end
                    end
                end
            end

        end,
    },    
    {
        id = "mana_capacity",
        name = "$reac_mana_capacity",
        description = "$reac_desc_mana_capacity",
        generate_notes = true,
        probability = 100, 
        func_probability = 1,
        inputs = { -- three ingredients is the limit
            "mm_diluted_mana",
            "mm_alchemical_base",
        },
        outputs = {
            "air",
            "mm_ephemeral_ether",
        },
        func = function(x, y)
            SetRandomSeed( x + 32523, y + 5325 + GameGetFrameNum() )
            local wands = EntityGetInRadiusWithTag(x, y, 16, "wand") or {}
            for k, v in ipairs(wands)do
                local wand = v
                local is_free = (EntityGetRootEntity(v) == v) and not EntityHasTag(v, "mana_altered")
                if(is_free)then
                    local ability_component = EntityGetFirstComponentIncludingDisabled(v, "AbilityComponent")
                    if(ability_component ~= nil)then
                        local mana_max = ComponentGetValue2(ability_component, "mana_max")
   
                        local multiplier = Random(10, 100) / 100
                        local additional_multiplier = math.max(0.25, 1 - (mana_max / 1000))

                        multiplier = multiplier * additional_multiplier

                        local new_mana_max = mana_max * (1 + multiplier)

                        ComponentSetValue2(ability_component, "mana_max", new_mana_max)

                        EntityAddTag(v, "mana_altered")
                    end
                end
            end
        end
    },
    {
        id = "mana_charge",
        name = "$reac_mana_charge",
        description = "$reac_desc_mana_charge",
        generate_notes = true,
        probability = 100, 
        func_probability = 1,
        inputs = { -- three ingredients is the limit
            "mm_refined_mana",
            "mm_alchemical_base",
        },
        outputs = {
            "air",
            "mm_ephemeral_ether",
        },
        func = function(x, y)
            SetRandomSeed( x + 32523, y + 5325 + GameGetFrameNum() )
            local wands = EntityGetInRadiusWithTag(x, y, 16, "wand") or {}
            for k, v in ipairs(wands)do
                local wand = v
                local is_free = (EntityGetRootEntity(v) == v) and not EntityHasTag(v, "mana_charge_altered")
                if(is_free)then
                    local ability_component = EntityGetFirstComponentIncludingDisabled(v, "AbilityComponent")
                    if(ability_component ~= nil)then
                        local mana_max = ComponentGetValue2(ability_component, "mana_charge_speed")

                        local multiplier = Random(100, 200) / 100
                        local additional_multiplier = math.max(0.25, 1 - (mana_max / 1000))

                        multiplier = multiplier * additional_multiplier

                        local new_mana_max = mana_max * (1 + multiplier)

                        ComponentSetValue2(ability_component, "mana_charge_speed", new_mana_max)

                        EntityAddTag(v, "mana_charge_altered")
                    end
                end
            end
        end
    },
    {
        id = "flux_welding",
        name = "$reac_flux_welding",
        description = "$reac_desc_flux_welding",
        generate_notes = true,
        probability = 100, 
        func_probability = 100,
        inputs = { -- three ingredients is the limit
            "mm_arcane_flux",
            "fire",
        },
        outputs = {
            "mm_ephemeral_ether_gas",
            "mm_ephemeral_ether_gas",
        },
        func = function(x, y)
            SetRandomSeed( x + 32523, y + 5325 + GameGetFrameNum() )
            local spells = EntityGetInRadiusWithTag(x, y, 50, "card_action") or {}
            local valid_spells = {}

            for i = 1, #spells do
                local spell = spells[i]
                local root = EntityGetRootEntity(spell)
                if(root == spell)then
                    if(not EntityHasTag(spell, "is_welded"))then
                        GamePrint("found spell")
                        table.insert(valid_spells, spell)
                        EntityAddTag(spell, "is_welded")
                    end
                end
            end

            if(#valid_spells == 0)then
                return
            end


            -- we only want to allow a maximum of 3 spells to be welded together
            if(#valid_spells > 3)then
                local new_valid_spells = {}
                for i = 1, 3 do
                    table.insert(new_valid_spells, valid_spells[i])
                end
                valid_spells = new_valid_spells
            end
            
            local root_spell = valid_spells[Random(1, #valid_spells)]

            local root_x, root_y = EntityGetTransform(root_spell)

            root_y = root_y - 16
            
            EntityLoad("mods/Hydroxide/files/mystical_mixtures/alchemy/action_welding/weld_effect.xml", root_x, root_y)
            
            -- reverse iterate
            for i = #valid_spells, 1, -1 do
                local spell = valid_spells[i]
                if(spell ~= root_spell)then
                    local comp = EntityGetFirstComponentIncludingDisabled( spell, "ItemActionComponent" )
                    if(comp ~= nil)then
                        local action_id = ComponentGetValue2( comp, "action_id" )
                        GamePrint("welding " .. action_id)

                        welding.AddWeld(root_spell, action_id)

                        EntityKill(spell)

                    end
                end
            end
        end
    },
    {
        id = "replicating_agent_1",
        probability = 100,
        inputs = {
            "mm_replicating_agent",
            "[liquid]",
        },
        outputs = {
            "[liquid]",
            "[liquid]",
        },
    },
    {
        id = "replicating_agent_2",
        probability = 100,
        inputs = {
            "mm_replicating_agent",
            "[magic_liquid]",
        },
        outputs = {
            "[magic_liquid]",
            "[magic_liquid]",
        },
    }, 
}
alchemical_materials = {
    {
        id = "MM_alchemical_solvent", -- id of the material
        name = "Alchemical Solvent", -- name of the material
        description = "Alchemical solvent is a material which is used to create mystical solutions.",
        generate_notes = true,
        color = "FF72BFD8", -- visual color
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",
    },
    {
        id = "MM_alchemical_base",
        name = "Alchemical Base",
        description = "The base of all proper alchemy.",
        generate_notes = true,
        color = "c87e6996",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",       
    },
    {
        id = "MM_ephemeral_ether",
        name = "Ephemeral Ether",
        description = "A voletile substance which evaporates quickly.\nA side product of many alchemical processes.\nUses are yet unknown.",
        generate_notes = true,
        color = "C60AFFD2",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",
        density = 1.1,
    },
    {
        id = "MM_ephemeral_ether_gas",
        name = "Ephemeral Ether Gas",
        description = "The evaporated form of Ephemeral Ether.",
        color = "410AFFD2",
        texture = nil, -- texture path
        type = "gas",
        tags = "",
        lifetime = 200,
        burnable = true,
        glow = 20,
    },
    {
        id = "MM_gold_solution",
        name = "Gold Solution",
        description = "A solution of gold in an alchemical solvent.\nIt can be used in a variety of recipes, notably modifying wand capacity.",
        generate_notes = true,
        color = "FFFFDF86",
        texture = "data/materials_gfx/gold.png", -- texture path
        type = "liquid",
        tags = "[alchemical]",
        density = 3.7,
        glow = 200,
    },
    {
        id = "MM_replicating_agent",
        name = "Replicating Agent",
        description = "A substance which through mystical means appears to clone other liquid substances.",
        generate_notes = true,
        color = "8AEF5FE6",
        texture = nil, -- texture path
        type = "liquid",
        glow = 150,
        density = 4.6,
    },
}

alchemical_recipes = {
    {
        id = "ether_evaporation",
        probability = 3, 
        inputs = {
            "MM_ephemeral_ether",
            "air",
        },
        outputs = {
            "MM_ephemeral_ether_gas",
            "air",
        },
        func = nil
    },
    {
        id = "gold_solution",
        name = "A Solution of Gold",
        description = "Gold can be dissolved in an alchemical solvent to be in a more usable form for future recipes.",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "[gold]",
            "[gold]",
            "MM_alchemical_solvent",
        },
        outputs = {
            "MM_gold_solution",
            "MM_gold_solution",
            "MM_ephemeral_ether",
        },
    },
    {
        id = "wand_capacity",
        name = "On the subject of wand capacity",
        description = "Wands are a the best friend of wizards and witches alike.\nHowever they can only hold a limited amount of spells.\nIt is known that a solution of gold together with an achemical base can adjust the capacity of a wand, but it may not always turn out as expected.",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "MM_gold_solution",
            "MM_alchemical_base",
        },
        outputs = {
            "air",
            "MM_ephemeral_ether",
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
        id = "replicating_agent_1",
        probability = 100,
        inputs = {
            "MM_replicating_agent",
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
            "MM_replicating_agent",
            "[magic_liquid]",
        },
        outputs = {
            "[magic_liquid]",
            "[magic_liquid]",
        },
    }, 
}
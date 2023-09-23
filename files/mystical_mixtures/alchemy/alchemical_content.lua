alchemical_materials = {
    {
        id = "alchemical_solvent", -- id of the material
        name = "Alchemical Solvent", -- name of the material
        description = "Alchemical solvent is a material which is used to create mystical solutions.",
        generate_notes = true,
        color = "FF72BFD8", -- visual color
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",
    },
    {
        id = "alchemical_base",
        name = "Alchemical Base",
        description = "The base of all proper alchemy.",
        generate_notes = true,
        color = "c87e6996",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[alchemical]",       
    },
    {
        id = "ephemeral_ether",
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
        id = "ephemeral_ether_gas",
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
        id = "gold_solution",
        name = "Gold Solution",
        description = "Gold Solution is a solution of gold in an alchemical solvent.\nIt can be used in a variety of recipes.",
        generate_notes = true,
        color = "FFFFDF86",
        texture = "data/materials_gfx/gold.png", -- texture path
        type = "liquid",
        tags = "[alchemical]",
        density = 3.7,
        glow = 200,
    },
    {
        id = "replicating_agent",
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
        probability = 1, 
        inputs = {
            "ephemeral_ether",
            "air",
        },
        outputs = {
            "ephemeral_ether_gas",
            "air",
        },
        func = nil
    },
    {
        id = "gold_solution",
        name = "A Solution of Gold",
        description = "Gold can be dissolved in an alchemical solvent to be more usable in future recipes.",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "[gold]",
            "[gold]",
            "alchemical_solvent",
        },
        outputs = {
            "gold_solution",
            "gold_solution",
            "ephemeral_ether",
        },
    },
    {
        id = "replicating_agent_1",
        probability = 100,
        inputs = {
            "replicating_agent",
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
            "replicating_agent",
            "[magic_liquid]",
        },
        outputs = {
            "[magic_liquid]",
            "[magic_liquid]",
        },
    }, 
}
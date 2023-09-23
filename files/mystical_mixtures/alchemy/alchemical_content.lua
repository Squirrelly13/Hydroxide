alchemical_materials = {
    {
        id = "alchemical_solvent", -- id of the material
        name = "Alchemical Solvent", -- name of the material
        description = "Alchemical solvent is a material which is used to create mystical solutions.",
        generate_notes = true,
        color = "FF72BFD8", -- visual color
        texture = nil, -- texture path
        type = "liquid",
        tags = "",
    },
    {
        id = "alchemical_base",
        name = "Alchemical Base",
        description = "The base of all proper alchemy.",
        generate_notes = true,
        color = "c87e6996",
        texture = nil, -- texture path
        type = "liquid",
        tags = "",       
    },
    {
        id = "ephemeral_ether",
        name = "Ephemeral Ether",
        description = "A voletile substance which evaporates quickly.\nA side product of many alchemical processes.\nUses are yet unknown.",
        generate_notes = true,
        color = "C60AFFD2",
        texture = nil, -- texture path
        type = "liquid",
        tags = "",
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
    }
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
        name = "Solution of Gold",
        description = "Gold can be dissolved in an alchemical solvent to be more usable in future recipes.",
        generate_notes = true,
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "[gold]",
            "alchemical_solvent",
            "[fire]",
        },
        outputs = {
            "air",
            "gold_solution",
        },
        blob_radius1 = nil,
        blob_radius2 = nil,
        blob_radius3 = nil,
        func = function(x, y)
            
        end
    }
}
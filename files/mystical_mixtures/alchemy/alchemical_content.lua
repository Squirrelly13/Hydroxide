alchemical_materials = {
    {
        id = "test_liquid", -- id of the material
        name = "Test Liquid", -- name of the material
        color = "FFA38D3C", -- visual color
        texture = nil, -- texture path
        type = "liquid", -- liquid, powder, gas
    }
}

alchemical_recipes = {
    {
        id = "improve_slots",
        name = "On the subject of wand slots",
        description = "test",
        probability = 100, 
        inputs = { -- three ingredients is the limit
            "[gold]",
            "alchemical_base",
        },
        outputs = {
            "air",
            "test_liquid",
        },
        func = nil -- function(x, y)
    }
}
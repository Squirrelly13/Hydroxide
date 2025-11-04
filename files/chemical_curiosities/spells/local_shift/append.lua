local AA = ModSettingGet("Hydroxide.AA_ENABLED")


local AA_matgroups = {
    organic = {
        name = "organics",
        materials = {
            "aa_hungry_slime",
            "aa_hungry_slime_growing",
            "aa_rice",
        }
    },
    potions = {
        name = "potions",
        materials = {
            "aa_icy_inferno",
            "aa_arborium",
            "aa_love",
            "aa_repultium",
            "aa_base_potion",
            "aa_cloning_solution",
            "aa_condensed_gravity",
            "aa_pop_rocks",
            "aa_meagre_offering",
            "aa_rice",
        }
    },
    gas = {
        name = "gasses",
        materials = {
            "aa_potion_gas",
        }
    },
    rock = {
        name = "rock",
        materials = {
            "aa_pop_rocks",
        }
    }
}

local AA_to = {
    { probability = 1, "aa_rice" },
    { probability = 1, "aa_potion_gas" },
}


if AA then
    AppendMaterialGroups(AA_matgroups)
    for _, value in ipairs(AA_to) do
        MaterialsTo[#MaterialsTo+1] = value
    end
end

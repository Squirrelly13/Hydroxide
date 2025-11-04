local MM_materials = {
    {
        material="mm_bingus",
        weight=0.3,
    },
    {
        material="mm_alchemical_solvent",
        weight=.7,
    },
    {
        material="mm_alchemical_base",
        weight=1.1,
    },
}

for _, entry in ipairs(MM_materials) do
    vial_materials[#vial_materials+1] = entry
end
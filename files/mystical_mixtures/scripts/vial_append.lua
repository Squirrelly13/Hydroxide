local MM_materials = {
    {
        material="mm_bingus",
        weight=0.6,
    },
    {
        material="mm_bingus_wetfood",
        weight=0.3,
    },
    {
        material="mm_alchemical_solvent",
        weight=.3,
    },
    {
        material="mm_alchemical_base",
        weight=.3,
    },
}

for _, entry in ipairs(MM_materials) do
    vial_materials[#vial_materials+1] = entry
end
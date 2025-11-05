local MM_materials = {
    {
        material="mm_bingus",
        probability=0.3,
    },
    {
        material="mm_alchemical_solvent",
        probability=.7,
    },
    {
        material="mm_alchemical_base",
        probability=1.1,
    },
}

for _, entry in ipairs(MM_materials) do
    VialMaterials[#VialMaterials+1] = entry
end
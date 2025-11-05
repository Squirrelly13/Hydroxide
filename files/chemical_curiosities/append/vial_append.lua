local CC_materials = {
    {
        material="cc_unstable_metamorphine",
        probability=0.3,
    },
    {
        material="cc_explodePlayer",
        probability=1,
    },
    {
        material="cc_metastasizium",
        probability=.4,
    },
    {
        material="cc_nullium",
        probability=1,
    },
    {
        material="cc_health_tonic",
        probability=.05,
    },
    {
        material="cc_antimatter_liquid",
        probability=.2,
    },
}

for _, entry in ipairs(CC_materials) do
    VialMaterials[#VialMaterials+1] = entry
end
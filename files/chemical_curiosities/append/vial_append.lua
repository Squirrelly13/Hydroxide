local CC_materials = {
    {
        material="cc_unstable_metamorphine",
        weight=0.3,
    },
    {
        material="cc_explodePlayer",
        weight=1,
    },
    {
        material="cc_metastasizium",
        weight=.4,
    },
    {
        material="cc_nullium",
        weight=1,
    },
    {
        material="cc_health_tonic",
        weight=.05,
    },
    {
        material="cc_antimatter_liquid",
        weight=.2,
    },
}

for _, entry in ipairs(CC_materials) do
    vial_materials[#vial_materials+1] = entry
end
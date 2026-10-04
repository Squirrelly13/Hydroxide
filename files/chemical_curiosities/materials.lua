local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua") ---@type nxml

local materials = {
    {
        name = "test_status_material",
        ui_name = "test status mat", --fallback onto `name`
        tags = "", --default ""
        ignore_self_reaction_warning = nil,
        cell_type = "liquid",
        density = 1,
        lifetime = 0,
		liquid_gravity = 0.6,
		gfx_glow = 100,
		liquid_stains = 1,
        cold_freezes_to_material = "",
        status_effects = {
            --stain = {
            --    "CC_TEST_STATUS",
            --},
            ingestion = {
                {
                    id = "CC_TEST_STATUS",
                    amount = .1
                },
            },
        },
    },
}

local xml_mats = {}
for _,mat in ipairs(materials) do
    local xml = nxml.new_element(mat._parent and "CellDataChild" or "CellData")

    if mat.status_effects then
        local status_effects_xml = nxml.new_element("StatusEffects")
        if mat.status_effects.stain then
            local stains_xml = nxml.new_element("Stains")
            for _,stain_effect in ipairs(mat.status_effects.stain) do
                stains_xml:add_child(nxml.new_element("StatusEffect", {type = stain_effect}))
            end
            status_effects_xml:add_child(stains_xml)
        end
        if mat.status_effects.ingestion then
            local ingestion_xml = nxml.new_element("Ingestion")
            for _,ingestion_effect in ipairs(mat.status_effects.ingestion) do
                ingestion_xml:add_child(nxml.new_element("StatusEffect", {type = ingestion_effect.id, amount = tostring(ingestion_effect.amount)}))
            end
            status_effects_xml:add_child(ingestion_xml)
        end
        xml:add_child(status_effects_xml)
    end

    for key, value in pairs(mat) do
        xml:set(key, value)
    end

    xml_mats[#xml_mats+1] = xml
end

for xml in nxml.edit_file("mods/Hydroxide/files/chemical_curiosities/append/materials.xml") do
    xml:add_children(xml_mats)
end
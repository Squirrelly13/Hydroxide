--[[
    <Materials>
        <Reaction probability="1000"
            input_cell1="cc_dormant_crystal"	input_cell2="cc_dormant_crystal"
            output_cell1="cc_dormant_crystal"	output_cell2="cc_dormant_crystal"
            entity="mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_receiver.xml"
        >
        </Reaction>
    </Materials>
]]

dofile("mods/Hydroxide/files/chemical_curiosities/electrolysis/reactions.lua")

local materials_content = [[
<Materials>
]]




--[[
reactions = {
    {
        input = "cc_dormant_crystal",
        output = "fire",
        probability = 100,
    }
}
]]
for _, reaction in ipairs(reactions)do
    local entity = [[
<Entity tags="electrolysis_checker">
    <ElectricityReceiverComponent/>
    <LuaComponent
        script_source_file="mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_checker_update.lua"
        script_material_area_checker_failed="mods/Hydroxide/files/chemical_curiosities/electrolysis/material_checker.lua"
        script_electricity_receiver_switched="mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_handler.lua"
        execute_every_n_frame="2"
    />
    <!--Remove after debugging is done!!-->
    <!--<SpriteComponent
        image_file="mods/Hydroxide/files/chemical_curiosities/electrolysis/debug_marker.png"
        offset_x="0.5"
        offset_y="0.5"
        emissive="1"
    />-->
        ]]

    local entity = entity .. [[
    <MaterialAreaCheckerComponent
        material="]]..reaction.input..[["
        area_aabb.min_x="-0.5"
        area_aabb.min_y="-0.5"
        area_aabb.max_x="0.5"
        area_aabb.max_y="0.5"
    />]]

    materials_content = materials_content .. [[
    <Reaction probability="5"
        input_cell1="]]..reaction.input..[["	input_cell2="]]..reaction.input..[["	input_cell3=""
        output_cell1="]]..reaction.input..[["	output_cell2="]]..reaction.input..[["	output_cell3=""
        entity="mods/Hydroxide/files/chemical_curiosities/electrolysis/]]..reaction.input..[[_receiver.xml"
    >
    </Reaction>
    ]]

    entity = entity .. [[
</Entity>
    ]]

    ModTextFileSetContent("mods/Hydroxide/files/chemical_curiosities/electrolysis/"..reaction.input.."_receiver.xml", entity)
end


materials_content = materials_content .. [[
</Materials>
]]

ModTextFileSetContent("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_reactions.xml", materials_content)

ModMaterialsFileAdd("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_reactions.xml")
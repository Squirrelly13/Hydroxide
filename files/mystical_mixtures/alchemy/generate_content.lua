dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/alchemical_content.lua")

local materials_xml = [[<Materials>
]]

for k, v in ipairs(alchemical_materials)do
    if(v.type == "liquid")then
        materials_xml = materials_xml .. [[
    <CellData 
        name="]]..v.id..[["
        ui_name="]]..v.name..[["
        tags="]]..(v.tags ~= nil and (v.tags .. ",[liquid]") or "[liquid]")..[["
        burnable="]]..(v.burnable and "1" or "0")..[["
        density="]]..(v.density ~= nil and v.density or 3)..[["
        cell_type="liquid"
        wang_color="]]..v.color..[["
        gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
        liquid_gravity="0.6"
        liquid_stains="1"
        lifetime="]]..(v.lifetime ~= nil and v.lifetime or -1)..[["
        >
        <Graphics
            color="]]..v.color..[["
            ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
        >
        </Graphics>
    </CellData>
        ]]
    elseif(v.type == "powder")then
        materials_xml = materials_xml .. [[
        <CellData
            name="]]..v.id..[["
            ui_name="]]..v.name..[["
            tags="]]..(v.tags ~= nil and (v.tags .. ",[sand_other],[corrodible]") or "[sand_other],[corrodible]")..[["
            burnable="]]..(v.burnable and "1" or "0")..[["
            density="]]..(v.density ~= nil and v.density or 15)..[["
            cell_type="liquid"
            wang_color="]]..v.color..[["
            generates_smoke="0"
            liquid_gravity="0.2"
            liquid_sand="1"
            on_fire="0"
            requires_oxygen="0"
            audio_physics_material_event="sand"
            audio_physics_material_wall="sand"
            audio_physics_material_solid="sand"
            show_in_creative_mode="1"
            gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
            lifetime="]]..(v.lifetime ~= nil and v.lifetime or -1)..[["
            >
            <Graphics
                color="]]..v.color..[["
                ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
            >
            </Graphics>
        </CellData>     
        ]]
    elseif(v.type == "gas")then
        materials_xml = materials_xml .. [[
        <CellData
            name="]]..v.id..[["
            ui_name="]]..v.name..[["
            tags="]]..(v.tags ~= nil and (v.tags .. ",[gas]") or "[gas]")..[["
            burnable="]]..(v.burnable and "1" or "0")..[["
            density="]]..(v.density ~= nil and v.density or 1)..[["
            lifetime="]]..(v.lifetime ~= nil and v.lifetime or -1)..[["
            cell_type="gas"
            wang_color="]]..v.color..[["
            generates_smoke="0"
            liquid_gravity="0.1"
            liquid_sand="0"
            on_fire="0"
            requires_oxygen="0"
            gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
            >
            <Graphics
                color="]]..v.color..[["
                ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
            >
            </Graphics>
        </CellData> 
        ]]
    end
end

for k, v in ipairs(alchemical_recipes)do
    
    local input1 = nil
    local input2 = nil
    local input3 = nil

    local output1 = nil
    local output2 = nil
    local output3 = nil

    if(v.inputs == nil)then
        goto continue
    end

    if(#v.inputs == 1)then
        input1 = v.inputs[1]
        input2 = v.inputs[1]
    elseif(#v.inputs == 2)then
        input1 = v.inputs[1]
        input2 = v.inputs[2]
    elseif(#v.inputs >= 3)then
        input1 = v.inputs[1]
        input2 = v.inputs[2]
        input3 = v.inputs[3]
    end

    if(v.outputs == nil)then
        goto continue
    end

    if(#v.outputs == 1)then
        output1 = v.outputs[1]
        output2 = v.outputs[1]
        if(#v.inputs >= 3)then
            output3 = v.outputs[1]
        end
    elseif(#v.outputs == 2)then
        output1 = v.outputs[1]
        output2 = v.outputs[2]
        if(#v.inputs >= 3)then
            output3 = v.outputs[2]
        end
    elseif(#v.outputs >= 3)then
        output1 = v.outputs[1]
        output2 = v.outputs[2]
        output3 = v.outputs[3]
        if(input3 == nil)then
            output3 = nil
        end
    end

    materials_xml = materials_xml .. [[
    <Reaction probability="]]..tostring(v.probability or 100)..[["
        input_cell1="]]..input1..[["	input_cell2="]]..input2..[["	input_cell3="]]..(input3 or "")..[["
        output_cell1="]]..output1..[["	output_cell2="]]..output2..[["	output_cell3="]]..(output3 or "")..[["
        blob_radius1="]]..(v.blob_radius1 or "1")..[[" blob_radius2="]]..(v.blob_radius2 or "1")..[[" blob_radius3="]]..(v.blob_radius3 or "1")..[["
    ]]

    if(v.func ~= nil)then 
        materials_xml = materials_xml .. [[
        entity="data/mystical_mixtures/alchemy/]]..v.id..[[.xml"
    />
    ]]
    
    local entity_xml = [[
    <Entity name="MM_alchemy_handler">
        <LifetimeComponent
            lifetime="2"
        />
        <LuaComponent
            script_source_file="data/mystical_mixtures/alchemy/scripts/]]..v.id..[[.lua"
            execute_on_added="1"
            execute_every_n_frame="0"
            execute_times="-1"
        />
    </Entity>
    ]]

    ModTextFileSetContent("data/mystical_mixtures/alchemy/"..v.id..".xml", entity_xml)

    local script_lua = [[
        dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/alchemical_content.lua")
        local entity_id = GetUpdatedEntityID()
        local x, y = EntityGetTransform(entity_id)
        local recipe_id = "]]..v.id..[["
        for k, v in ipairs(alchemical_recipes)do
            if(v.id == recipe_id)then
                v.func(x, y)
            end
        end
    ]]

    ModTextFileSetContent("data/mystical_mixtures/alchemy/scripts/"..v.id..".lua", script_lua)

    else
        materials_xml = materials_xml .. [[
    />]]
    end
    ::continue::
end

materials_xml = materials_xml .. "</Materials>"

ModTextFileSetContent("data/mystical_mixtures/alchemy_materials.xml", materials_xml)

print(materials_xml)

ModMaterialsFileAdd("data/mystical_mixtures/alchemy_materials.xml")

print("Generated Mystical Mixtures alchemy content.")
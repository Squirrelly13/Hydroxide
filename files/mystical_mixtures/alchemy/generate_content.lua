dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/alchemical_content.lua")

local materials_xml = [[<Materials>
    <CellData 
        name="alchemical_base"
        ui_name="Alchemical Base"
        tags="[liquid]"
        density="2.9"
        cell_type="liquid"
        wang_color="ff706747"
        gfx_glow="0"
        liquid_gravity="0.6"
        liquid_stains="1"
        >
        <Graphics
            color="c87e6996"
        >
        </Graphics>
    </CellData>
]]

for k, v in ipairs(alchemical_materials)do
    if(v.type == "liquid")then
        materials_xml = materials_xml .. [[
    <CellData 
        name="]]..v.id..[["
        ui_name="]]..v.name..[["
        tags="[liquid]"
        density="2.9"
        cell_type="liquid"
        wang_color="]]..v.color..[["
        gfx_glow="0"
        liquid_gravity="0.6"
        liquid_stains="1"
        >
        <Graphics
            color="]]..v.color..[["
            ]]..((v.texture ~= nil) and ("texture_file="..v.texture) or "") ..[[
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
    ]]

    if(v.func ~= nil)then 
        materials_xml = materials_xml .. [[
        entity="data/mystical_mixtures/alchemy/]]..v.id..[[.xml"
    />
    ]]
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
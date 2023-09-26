--[[
    <Materials>
        <Reaction probability="1000"
            input_cell1="CC_dormant_crystal"	input_cell2="CC_dormant_crystal"
            output_cell1="CC_dormant_crystal"	output_cell2="CC_dormant_crystal"
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
        input = "CC_dormant_crystal",
        output = "fire",
        probability = 100,
    }
}
]]
for _, reaction in ipairs(reactions)do
    materials_content = materials_content .. [[
    <Reaction probability="]]..tostring(reaction.probability or 100)..[["
        input_cell1="]]..reaction.input..[["	input_cell2="]]..reaction.input..[["	input_cell3=""
        output_cell1="]]..reaction.input..[["	output_cell2="]]..reaction.input..[["	output_cell3=""
        entity="mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_receiver.xml"
    >
    </Reaction>
    ]]
end

materials_content = materials_content .. [[
</Materials>
]]

ModTextFileSetContent("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_reactions.xml", materials_content)

ModMaterialsFileAdd("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_reactions.xml")
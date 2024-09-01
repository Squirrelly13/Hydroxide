--this mostly consists of grabbed 



ModMaterialsFileAdd("mods/Hydroxide/files/fluent_fluids/materials/materials.xml") --Regular Materials


local gases_xml

local gases = {
    {
        material = "water", --material you are using
        wang_color = "FF2F554C", --id for the new material
        name = "$mat_ff_water_powder", --in-game name (leave blank for just "MATERIAL Powder")
        color = nil, --set custom colour
        texture = nil, --set custom texture
        tags = nil, --additional tags you want to add
        density = 10,
        glow = nil,
        burnable = nil,
    }
}

for k, v in ipairs(gases)do
        gases_xml = gases_xml .. [[
    <CellData 
        name="ff_]]..v.material..[[_powder"
        ui_name="]]..(v.name ~= nil and (v.name) or "$mat_ff_powder_generic")..[["
        wang_color="]]..v.color..[["
        tags="]]..(v.tags ~= nil and (v.tags .. ",[liquid]") or "[liquid]")..[["
        density="]]..(v.density ~= nil and v.density or 3)..[["
        cell_type="liquid"
        liquid_sand="1"
        liquid_gravity="0.2"
        audio_physics_material_event="sand"
        audio_physics_material_wall="sand"
        audio_physics_material_solid="sand"
        gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
        burnable="]]..(v.burnable and "1" or "0")..[["
        fire_hp="]]..(v.fire_hp ~= nil and v.fire_hp or 300)..[["
        on_fire_convert_to_material="]]..(v.on_fire_convert_to_material ~= nil and v.on_fire_convert_to_material or "")..[["
        on_fire="]]..(v.on_fire and "1" or "0")..[["
        temperature_of_fire="]]..(v.temperature_of_fire ~= nil and v.temperature_of_fire or 95)..[["
        autoignition_temperature="10"
        >
        <Graphics
            color="]]..v.color..[["
            ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
        >
        </Graphics>
		<StatusEffects>
			<Ingestion>
				<StatusEffect type="CC_WARP" amount="0.15"/>
			</Ingestion>
		</StatusEffects>
    </CellData>
        ]]
end

--340282366920938463463374607431768211456
--340282366920938463463374607431768211456-340282356779733661637539395458142568447 

local powders_xml

local powders = {
    {
        material = "water", --material you are using
        wang_color = "FF2F554C", --id for the new material
        name = "$mat_ff_water_powder", --in-game name (leave blank for just "MATERIAL Powder")
        color = nil, --set custom colour
        texture = nil, --set custom texture
        tags = nil, --additional tags you want to add
        density = 10,
        glow = 0,
        burnable = nil,
    }
}

for k, v in ipairs(powders)do
        powders_xml = powders_xml .. [[
    <CellData 
        name="ff_]]..v.material..[[_powder"
        ui_name="]]..(v.name ~= nil and (v.name) or "$mat_ff_powder_generic")..[["
        wang_color="]]..v.color..[["
        tags="]]..(v.tags ~= nil and (v.tags .. ",[liquid]") or "[liquid]")..[["
        density="]]..(v.density ~= nil and v.density or 3)..[["
        cell_type="liquid"
        liquid_sand="1"
        liquid_gravity="0.2"
        audio_physics_material_event="sand"
        audio_physics_material_wall="sand"
        audio_physics_material_solid="sand"
        gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
        burnable="]]..(v.burnable and "1" or "0")..[["
        fire_hp="]]..(v.fire_hp ~= nil and v.fire_hp or 300)..[["
        on_fire_convert_to_material="]]..(v.on_fire_convert_to_material ~= nil and v.on_fire_convert_to_material or "")..[["
        on_fire="]]..(v.on_fire and "1" or "0")..[["
        temperature_of_fire="]]..(v.temperature_of_fire ~= nil and v.temperature_of_fire or 95)..[["
        autoignition_temperature="10"
        >
        <Graphics
            color="]]..v.color..[["
            ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
        >
        </Graphics>]]..(v.ingestion ~= nil and [[
		<StatusEffects>
			<Ingestion>
				<StatusEffect type="]]..v.ingestion..[[" amount="]]..(v.ingestion_multiplier ~= nil and v.ingestion_multiplier or .5)..[["/>
			</Ingestion>
		</StatusEffects>]] or nil)..[[
    </CellData>
        ]]
end


local materials_xml = [[<Materials>
]]..gases_xml..powders_xml..candies_xml..[[
</Materials>]]


-- print([[
--         <CellData
--             name="]]..v.id..[["
--             ui_name="]]..v.name..[["
--             tags="]]..(v.tags ~= nil and (v.tags .. ",[sand_other],[corrodible]") or "[sand_other],[corrodible]")..[["
--             burnable="]]..(v.burnable and "1" or "0")..[["
--             density="]]..(v.density ~= nil and v.density or 15)..[["
--             cell_type="liquid"
--             wang_color="]]..v.color..[["
--             generates_smoke="0"
--             liquid_gravity="0.2"
--             liquid_sand="1"
--             on_fire="0"
--             requires_oxygen="0"
--             audio_physics_material_event="sand"
--             audio_physics_material_wall="sand"
--             audio_physics_material_solid="sand"
--             show_in_creative_mode="1"
--             gfx_glow="]]..(v.glow ~= nil and v.glow or 0)..[["
--             lifetime="]]..(v.lifetime ~= nil and v.lifetime or -1)..[["
--             >
--             <Graphics
--                 color="]]..v.color..[["
--                 ]]..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..[[
--             >
--             </Graphics>
--         </CellData>     
-- ]])



local table = {
    {
        material = material,
        wang_color = wang_color,
        name = name or "$mat_ff_powder_generic", --note to self, figure out how to pass the material into the $0
        tags = "[corrodible],[alchemy],[ff_powder]," .. tags
    }
}



--[[







}





CreatePowder(material, wang_color,)
CreatePowder(water,)

    if InheritTags
    tags = {material}.tagsz


        <CellData
            name="ff_{material}_powder"
            ui_name="{material} Powder"
            tags="{tags},[sand_other],[corrodible]") or "[sand_other],[corrodible]").."
            burnable="..(v.burnable and "1" or "0").."
            density="..(v.density ~= nil and v.density or 15).."
            cell_type="liquid"
            wang_color="..v.color.."
            generates_smoke="0"
            liquid_gravity="0.2"
            liquid_sand="1"
            on_fire="0"
            requires_oxygen="0"
            audio_physics_material_event="sand"
            audio_physics_material_wall="sand"
            audio_physics_material_solid="sand"
            show_in_creative_mode="1"
            gfx_glow="..(v.glow ~= nil and v.glow or 0).."
            lifetime="..(v.lifetime ~= nil and v.lifetime or -1).."
            >
            <Graphics
                color="..v.color.."
                ..((v.texture ~= nil) and ("texture_file=\""..v.texture.."\"") or "") ..
            >
            </Graphics>
        </CellData>     
]]










-- Automation stuff:

local nxml = dofile_once("mods/Hydroxide/files/lib/luanxml/nxml.lua")

local gases = nxml.parse(ModTextFileGetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_gases.xml"))
local powders = nxml.parse(ModTextFileGetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_powders.xml"))
local candies = nxml.parse(ModTextFileGetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_candies.xml"))

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
        fire_hp="]]..(v.fire_hp ~= nil and v.fire_hp or 300)..[["
        on_fire_convert_to_material="]]..(v.on_fire_convert_to_material ~= nil and v.on_fire_convert_to_material or "")..[["
        on_fire="]]..(v.on_fire and "1" or "0")..[["
        temperature_of_fire="]]..(v.temperature_of_fire ~= nil and v.temperature_of_fire or 95)..[["
        autoignition_temperature="10"
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

materials_xml = materials_xml .. "</Materials>"

--print(materials_xml)

ModTextFileSetContent("data/mystical_mixtures/alchemy_materials.xml", materials_xml)

ModMaterialsFileAdd("data/mystical_mixtures/alchemy_materials.xml")



if (ModSettingGet("Hydroxide.CC_MATERIALS")) == true then
    
end

if (ModSettingGet("Hydroxide.AA_MATERIALS")) == true then
    
end

if (ModSettingGet("Hydroxide.MM_MATERIALS")) == true then
    
end

ModTextFileSetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_gases.xml", tostring(gases))
ModTextFileSetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_powders.xml", tostring(powders))
ModTextFileSetContent("mods/Hydroxide/files/fluent_fluids/materials/materials_candies.xml", tostring(candies))
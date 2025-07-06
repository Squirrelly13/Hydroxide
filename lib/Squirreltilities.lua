--generally a collection of useful scripts. Not all are made by me. Anything i didnt make is credited as best i can

--useful for splitting one string into a series of strings, used in EntityGetDamageFromMaterial(). Found this on some website.
function stringsplit(inputstr, sep)
	sep = sep or "%s"
	local output = {}
	
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(output, str)
	end
	
	return output
end

--Acquires the designated entity's damage model and returns the material damage of the requested material
function EntityGetDamageFromMaterial(entity, material)
    local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity, "DamageModelComponent")
    if damage_model_component then
        local materials_that_damage = ComponentGetValue2(damage_model_component, "materials_that_damage")
        materials_that_damage = stringsplit(materials_that_damage, ",")

        local materials_how_much_damage = ComponentGetValue2(damage_model_component, "materials_how_much_damage")
        materials_how_much_damage = stringsplit(materials_how_much_damage, ",")

        if material then --if requested material, return damage for that material
            for i, v in ipairs(materials_that_damage) do
                if (materials_that_damage[i] == material) then
                    return tonumber(materials_how_much_damage[i])
                end
            end
        else --if material field blank, return full table of material damage
            local material_damage_table = {}
            for key, value in pairs(materials_that_damage) do
                material_damage_table[value] = materials_how_much_damage[key]
            end
            return material_damage_table
        end
	end
	return nil
end

--Clones the material damage value of a designated template material to be applied to a target material
function EntityMimicMaterialDamage(target, target_material, template_material, just_once)
    if target == 0 then print("No Entity to mimic damage for") return end
    local template_strength = EntityGetDamageFromMaterial(target, template_material)
    if template_strength ~= nil then
        EntitySetDamageFromMaterial(target, target_material, template_strength)
    end
end

--Edits an entity's XML file to mimic a material damage value for a different material
function FileMimicMaterialDamage(target, target_material, template_material)
    local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua")
	local xml = ModDoesFileExist(target) and nxml.parse(ModTextFileGetContent(target))
    if xml == nil then return end

    local template_strength = EntityGetDamageFromMaterial(target, template_material)
    if (template_strength ~= nil) then
        EntitySetDamageFromMaterial(target, target_material, template_strength)
    end
end



--a modified version of a function by Evaisa
function shift_materials_in_range(radius, materials_input, output, e_id)
	local shift_entity = EntityCreateNew("shifting_guy")
	if(e_id ~= nil)then
		local x,y = EntityGetTransform(e_id)
		
		EntitySetTransform(shift_entity, x, y)
		for k, v in ipairs(materials_input)do
			EntityAddComponent2(shift_entity, "MagicConvertMaterialComponent", {
				radius = radius,
				from_material = CellFactory_GetType(v),
				to_material = CellFactory_GetType(output),
				kill_when_finished = true,
				is_circle = true,
				steps_per_frame = 256,
			})
			EntityAddComponent2(shift_entity, "LifetimeComponent", {
				lifetime = 5,
			})
			
			function getMaterialCount(material, inventory)
				local count_per_material_type = ComponentGetValue2( inventory, "count_per_material_type");
				for k,v in pairs(count_per_material_type) do
					if v ~= 0 then --material exists in the inventory
						material_name = CellFactory_GetName(k-1)

						material_amount = v
						if(material_name == material)then
							return material_amount
						end
					end
				end
				return 0
			end
		end
	end
end

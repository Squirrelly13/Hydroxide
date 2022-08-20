--generally a collection of useful scripts.


function stringsplit(inputstr, sep)
	sep = sep or "%s"
	local output = {}
	
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(output, str)
	end
	
	return output
end



function EntityGetDamageFromMaterial(entity, material)
	local value = 0.000
	
	local damage_model_component = EntityGetFirstComponentIncludingDisabled(entity, "DamageModelComponent")
	if damage_model_component then
	
		local materials_that_damage = ComponentGetValue2(damage_model_component, "materials_that_damage")
		materials_that_damage = stringsplit(materials_that_damage, ",")
		
		local materials_how_much_damage = ComponentGetValue2(damage_model_component, "materials_how_much_damage")
		materials_how_much_damage = stringsplit(materials_how_much_damage, ",")
		
		for i, v in ipairs(materials_that_damage) do
			if (materials_that_damage[i] == material) then
				value = tonumber(materials_how_much_damage[i])
				return value
			end
		end
	end
	return nil
end

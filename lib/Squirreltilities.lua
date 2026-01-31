--generally a collection of useful scripts. Not all are made by me. Anything i didnt make is credited as best i can
---@type nxml
local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua")

--useful for splitting one string into a series of strings, used in EntityGetDamageFromMaterial(). Found this on some website.
function stringsplit(inputstr, sep)
	sep = sep or "%s"
	local output = {}

	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(output, str)
	end

	return output
end


---If `material` parameter is passed, will return the amount of damage taken from that material, or nil if none. Otherwise, returns a table of material damage indexed by material name.
---@param entity entity_id
---@param material string
---@return number[]|number|nil
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
---@param entity entity_id
---@param target_material string
---@param template_material string
function EntityMimicMaterialDamage(entity, target_material, template_material)
	if not (entity and entity ~= 0) then print("No Entity to mimic damage for") return end
	local template_strength = EntityGetDamageFromMaterial(entity, template_material)
	if template_strength ~= nil then
		EntitySetDamageFromMaterial(entity, target_material, template_strength)
	end
end

--[[
--Edits an entity's XML file to mimic a material damage value for a different material. NOT IMPLEMENTED
---@param filepath string
---@param target_material string
---@param template_material string
function FileMimicMaterialDamage(filepath, target_material, template_material)
	do return end
	local xml = ModDoesFileExist(filepath) and nxml.parse(ModTextFileGetContent(filepath))
	if xml == nil then return end

	--oh this doesnt work, this needs to be doing nxml stuff, will resolve later
	local template_strength = EntityGetDamageFromMaterial(filepath, template_material)
	if template_strength ~= nil then
		EntitySetDamageFromMaterial(filepath, target_material, template_strength)
	end
end--]]

--allows for a quick way to set the blood_material of an enemy. Most enemies have their DamageModelComponent nested under a Base component, but this function doesn't account for ones that don't. Will fix if necessary
---@param xml_path string
---@param material string
function FileSetBloodMaterial(xml_path, material)
	local xml = ModDoesFileExist(xml_path) and nxml.parse(ModTextFileGetContent(xml_path))
	if xml ~= nil then
		xml:first_of("Base"):first_of("DamageModelComponent").attr.blood_material = material or "air"
		ModTextFileSetContent(xml_path, tostring(xml))
	end
end


---Transforms materials within radius from materials_input to output material
---@param radius number
---@param materials_input string[]
---@param output string
---@param x number
---@param y number
function LocalShift(radius, materials_input, output, x, y)
	local shift_entity = EntityCreateNew("CC_shifting_guy")
	EntitySetTransform(shift_entity, x, y)
	for _, material in ipairs(materials_input)do
		EntityAddComponent2(shift_entity, "MagicConvertMaterialComponent", {
			radius = radius,
			from_material = CellFactory_GetType(material),
			to_material = CellFactory_GetType(output),
			kill_when_finished = true,
			is_circle = true,
			steps_per_frame = 256,
		})
		EntityAddComponent2(shift_entity, "LifetimeComponent", {
			lifetime = 5,
		})
	end
end
--a modified version of a function by Evaisa


---@class (exact) Weighted
---@field probability number

---@class (exact) Seed
---@field [1] number
---@field [2] number

---@generic T : Weighted
---@param t T[]
---@return T
---Function for picking a random table entry on `probability` as weight
function RandomFromTable(t)
	local total_weight = 0
	for _, entry in ipairs(t) do
		total_weight = total_weight + entry.probability
	end

	local rnd = Randomf(0, total_weight)
	for _, entry in ipairs(t) do
		if rnd <= entry.probability then
			return entry
		else rnd = rnd - entry.probability end
	end
	return t[#t]
end

---@generic T : Weighted
---@param t T[]
---@param context any
---@return T|nil
---Compiles entries from `t` into a new table based on optional `condition` value in the entry and passes it through `RandomFromTable`. `context` is passed into the function as a parameter.
function ConditionalRandomFromTable(t, context)
	local temp = {}
	for _, entry in ipairs(t) do
		if entry.condition and not entry:condition(context) then goto continue end
		temp[#temp+1] = entry
		::continue::
	end

	if #temp == 0 then return end
	return RandomFromTable(temp)
end

---@generic T : Weighted
---@param t T[]
---@param seed Seed
---@return T
---Function for picking a procedurally random table entry on `probability` as weight based on `seed`
function ProceduralRandomFromTable(t, seed)
    local total_weight = 0
    for _, entry in ipairs(t) do
        total_weight = total_weight + entry.probability
    end

    local rnd = ProceduralRandomf(seed[1], seed[2], 0, total_weight)
    for _, entry in ipairs(t) do
        if rnd <= entry.probability then
            return entry
        else rnd = rnd - entry.probability end
    end
    return t[#t] --Randomf has a miniscule chance to overflow
end

---handy func i stole that converts an entire table to string, grabbed from [here](https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console)
---@param o table
---@return string
---@diagnostic disable-next-line: lowercase-global
function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

---simple func to get herd id, mostly for other funcs in this file to utilise
---@param entity_id entity_id
---@return int
function GetHerdID(entity_id)
	local genome_comp = EntityGetFirstComponent(entity_id, "GenomeDataComponent")
	if genome_comp then return ComponentGetValue2(genome_comp, "herd_id")
	else return 0 end
end

---Replacement function for the vanilla `utilities.lua` function `shoot_projectile()`
---@param shooter entity_id
---@param entity_file string filepath to projectile.xml
---@param x number
---@param y number
---@param vel_x number?
---@param vel_y number?
---@param send_message bool?
---@return entity_id
function ShootProjectile(shooter, entity_file, x, y, vel_x, vel_y, send_message)
	shooter = shooter or 0
	local entity_id = EntityLoad(entity_file, x, y)
	vel_x = vel_x or 0
	vel_y = vel_y or 0
	send_message =  send_message or true

	local herd_id = GetHerdID(shooter)

	GameShootProjectile(shooter, x, y, x+vel_x, y+vel_y, entity_id, send_message)

	for _, proj_comp in ipairs(EntityGetComponent(entity_id, "ProjectileComponent") or {}) do
		ComponentSetValue2(proj_comp, "mWhoShot", shooter)
		ComponentSetValue2(proj_comp, "mShooterHerdId", herd_id) --should be fine if nil..?
	end

	for _, vel_comp in ipairs(EntityGetComponent(entity_id, "VelocityComponent") or {}) do
		ComponentSetValue2(vel_comp, "mVelocity", vel_x, vel_y)
	end

	return entity_id
end

---Creates a clone using `path` as a base
---@param path string Filepath for the base entity
---@param origin entity_id|nil Original entity from which the clone was derived (optional)
---@param x number
---@param y number
---@param genome string? New genome for the clone (optional)
---@return entity_id
---@return component_id
function CreateClone(path, origin, x, y, genome)
	local entity = EntityLoad(path, x, y)
	if genome then
		for _, comp in ipairs(EntityGetComponent(entity, "GenomeDataComponent") or {}) do
			ComponentSetValue2(comp, "herd_id", StringToHerdId(genome))
		end
	end

	local clone_data = EntityAddComponent2(entity, "VariableStorageComponent", {
		_tags = "no_gold_drop",
		name = "aa_clone_data",
		value_int = origin
	})

	EntityAddComponent2(entity, "LuaComponent", {
		script_source_file="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/cloned_entity.lua",
		execute_on_added = true,
		call_init_function= true,
		execute_every_n_frame = 480,
	})

	EntityAddComponent2(entity, "LuaComponent", {
		script_source_file="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/clone_death.lua",
		execute_on_removed = true,
		execute_every_n_frame = -1,
	})

	return entity, clone_data
end
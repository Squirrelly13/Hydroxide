---@alias APLC_materials {[number]:string|false|nil}

---@class APLC_recipe
---@field mats integer[]
---@field prob number
---@field result integer

---@class APLC_recipes
---@field lc APLC_recipe
---@field ap APLC_recipe

---@class APLC
---@field failed boolean
local aplc = {
	liquid_list = {
		"acid",
		"alcohol",
		"blood",
		"blood_fungi",
		"blood_worm",
		"cement",
		"lava",
		"magic_liquid_berserk",
		"magic_liquid_charm",
		"magic_liquid_faster_levitation",
		"magic_liquid_faster_levitation_and_movement",
		"magic_liquid_invisibility",
		"magic_liquid_mana_regeneration",
		"magic_liquid_movement_faster",
		"magic_liquid_protection_all",
		"magic_liquid_teleportation",
		"magic_liquid_unstable_polymorph",
		"magic_liquid_unstable_teleportation",
		"magic_liquid_worm_attractor",
		"material_confusion",
		"mud",
		"oil",
		"poison",
		"radioactive_liquid",
		"swamp",
		"urine",
		"water",
		"water_ice",
		"water_swamp",
		"magic_liquid_random_polymorph",
	},
	organic_list = {
		"bone",
		"brass",
		"coal",
		"copper",
		"diamond",
		"fungi",
		"gold",
		"grass",
		"gunpowder",
		"gunpowder_explosive",
		"rotten_meat",
		"sand",
		"silver",
		"slime",
		"snow",
		"soil",
		"wax",
		"honey",
	},
	failed = false,
}

---Advance random
---@private
---@param value number
---@return number
function aplc:rng_next(value)
	local high = math.floor(value / 0x1F31D)
	local low = value % 127773
	value = 16807 * low - 2836 * high
	if value <= 0 then value = value + 2147483647 end
	return value
end

---Shuffle bullshit
---@private
---@param t APLC_materials
---@param seed number
---@private
function aplc:shuffle(t, seed)
	local value = math.floor(seed / 2) + 0x30F6
	value = self:rng_next(value)
	for i = #t, 1, -1 do
		value = self:rng_next(value)
		local fid_x = value / 2 ^ 31
		local target = math.floor(fid_x * i) + 1
		t[i], t[target] = t[target], t[i]
	end
end

---Return a copy of material table
---@private
---@param key string
---@return APLC_materials
function aplc:copy_arr(key)
	local t = {}
	for k, v in ipairs(self[key]) do
		t[k] = v
	end
	return t
end

---Picks a material using some bullshit
---@private
---@param value number
---@param materials APLC_materials
---@return number?, string?
function aplc:random_material(value, materials)
	for _ = 1, 1000 do
		value = self:rng_next(value)
		local r_value = value / 2 ^ 31
		local sel_idx = math.floor(#materials * r_value) + 1
		local selection = materials[sel_idx]
		if selection then
			materials[sel_idx] = false
			return value, selection
		end
	end
end

---Recipe function, wtf is this
---@private
---@param rand_state number
---@param seed number
---@return boolean, any, any, any
function aplc:random_recipe(rand_state, seed)
	local liquids = self:copy_arr("liquid_list")
	local organics = self:copy_arr("organic_list")

	local materials = {}
	for i = 1, 3 do
		local num, mat = self:random_material(rand_state, liquids)
		if not num or not mat then return false end
		rand_state = num
		materials[#materials + 1] = CellFactory_GetType(mat)
	end
	local num, mat = self:random_material(rand_state, organics)
	if not num or not mat then return false end
	rand_state = num
	materials[#materials + 1] = CellFactory_GetType(mat)

	rand_state = self:rng_next(rand_state)
	local prob = 10 + math.floor((rand_state / 2 ^ 31) * 91)
	rand_state = self:rng_next(rand_state)

	self:shuffle(materials, seed)
	return true, rand_state, { materials[1], materials[2], materials[3] }, prob
end

---Writes an error and disables a module
---@private
function aplc:fail()
	print("[Chemical Curiosities]: Couldn't parse LC recipe")
	self.failed = true
end

---Returns APLC recipe
---@return APLC_recipes
---@nodiscard
function aplc:get()
	local seed = tonumber(StatsGetValue("world_seed")) or 1
	local rand_state = math.floor(seed * 0.17127000 + 1323.59030000)
	for _ = 1, 6 do
		rand_state = self:rng_next(rand_state)
	end
	local success = false
	local lc_mats = {}
	local lc_prob = 0
	local ap_mats = {}
	local ap_prob = 0
	success, rand_state, lc_mats, lc_prob = self:random_recipe(rand_state, seed)
	if not success then self:fail() end
	success, rand_state, ap_mats, ap_prob = self:random_recipe(rand_state, seed)
	if not success then self:fail() end

	return {
		lc = {
			mats = lc_mats,
			prob = lc_prob,
			result = CellFactory_GetType("magic_liquid_hp_regeneration_unstable"),
		},
		ap = {
			mats = ap_mats,
			prob = ap_prob,
			result = CellFactory_GetType("midas_precursor"),
		},
	}
end

return aplc
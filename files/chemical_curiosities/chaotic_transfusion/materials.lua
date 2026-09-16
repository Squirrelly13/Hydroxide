local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")

local materials = {
	{
		material = "water",
		weight = 6,
	},
	{
		material = "oil",
		weight = 3,
	},
	{
		material = "blood",
		weight = 4,
	},
	{
		material = "slime",
		weight = 6,
	},
	{
		material = "magic_liquid_movement_faster",
		weight = 10,
	},
	{
		material = "magic_liquid_worm_attractor",
		weight = 10,
	},
	{
		material = "magic_liquid_protection_all",
		weight = 1,
	},
	{
		material = "magic_liquid_mana_regeneration",
		weight = 6,
	},
	{
		material = "magic_liquid_teleportation",
		weight = 5,
	},
	{
		material = "magic_liquid_hp_regeneration_unstable",
		weight = 0.02,
	},
	{
		material = "magic_liquid_berserk",
		weight = 10,
	},
	{
		material = "magic_liquid_invisibility",
		weight = 10,
	},
	{
		material = "blood_worm",
		weight = 7,
	},
	{
		material = "blood_cold",
		weight = 7,
	},
	{
		material = "gold_molten",
		weight = 1,
	},
	{
		material = "void_liquid",
		weight = .1,
	},

	{
		material = "cc_veilium",
		weight = 3,
	},
	{
		material = "cc_slicing_liquid",
		weight = 3,
	},
	{
		material = "cc_glittering_liquid",
		weight = 7,
	},
	{
		material = "cc_heftium",
		weight = 5,
	},
	{
		material = "cc_explode_player",
		weight = 8,
	},
	{
		material = "cc_nullium",
		weight = 7,
	},
	{
		material = "cc_health_tonic",
		weight = 1,
	},
	{
		material = "cc_grease",
		weight = 3,
	},
	{
		material = "cc_dormant_crystal_molten",
		weight = 10,
	},
	{
		material = "cc_antimatter_liquid",
		weight = 2,
	},
	{
		material = "cc_persistine",
		weight = 9,
	},
}









local AA_materials = {
	{
		material = "aa_dark_matter",
		weight = 3,
	},
	{
		material = "aa_base_potion",
		weight = 15,
	},
	{
		material = "aa_arborium",
		weight = 5,
	},
	{
		material = "aa_icy_inferno",
		weight = 6,
	},
	{
		material = "aa_pandorium",
		weight = 6,
	},
	{
		material = "aa_pop_rocks",
		weight = .5,
	},
	{
		material = "aa_condensed_gravity",
		weight = 4,
	},
	{
		material = "aa_cloning_solution",
		weight = 4,
	},
}

if AA then
	for _,entry in ipairs(AA_materials) do
		materials[#materials+1] = entry
	end
end

if true then
	table.sort(materials, function(a, b)
		return a.weight > b.weight
	end)
	local max_weight = 0
	for _,entry in ipairs(materials) do
		max_weight = max_weight + entry.weight
	end
	for _,entry in ipairs(materials) do
		print(("[%s] = %.3f%%"):format(entry.material, 100*entry.weight/max_weight))
	end
end


for _,file in ipairs(ModLuaFileGetAppends("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/materials.lua")) do
	materials = dofile(file)()
end

return materials
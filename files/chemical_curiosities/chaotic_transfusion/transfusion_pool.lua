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
		weight = .5,
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
		material = "mimic_liquid",
		weight = 12
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
		material = "cc_nullium",
		weight = 4,
	},
	{
		material = "cc_health_tonic",
		weight = 2,
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
		weight = 7,
	},
}


if GameGetWorldStateEntity() ~= 0 then
	local aplc = dofile_once("mods/Hydroxide/lib/aplc.lua")
	local mats = aplc:get()
	if mats then
		for _,t in ipairs({mats.lc, mats.ap}) do
			for _,material in ipairs(t.mats) do
				materials[#materials+1] = {
					material = CellFactory_GetName(material),
					weight = 5
				}
				print(("Added [%s] ingredient: [%s]"):format(CellFactory_GetName(t.result), CellFactory_GetName(material)))
			end
		end
	end
end




local AA_materials = {
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
		material = "aa_cloning_solution",
		weight = 7,
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


for _,file in ipairs(ModLuaFileGetAppends("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/transfusion_pool.lua")) do
	materials = dofile(file)()
end

return materials
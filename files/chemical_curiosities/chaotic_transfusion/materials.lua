local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")

local materials = {
	{
		material = "slime",
		weight = 10,
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
		weight = 7,
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
		weight = 10,
	},
	{
		material = "blood_cold",
		weight = 10,
	},
	{
		material = "gold_molten",
		weight = .5,
	},
}

local AA_materials = {
	{
		material = "water",
		weight = 1,
	},
}

if AA then
	for _,entry in ipairs(AA_materials) do
		materials[#materials+1] = entry
	end
end


for _,file in ipairs(ModLuaFileGetAppends("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/materials.lua")) do
	materials = dofile(file)()
end

return materials
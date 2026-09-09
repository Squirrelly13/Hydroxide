local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")

local CC_potions = {
	standard = {
		{
			material="cc_hydroxide",
			cost=250,
		},
		{
			material="cc_grease",
			cost=100,
		},
		{
			material="cc_cobaline",
			cost=120,
		},
		{
			material="cc_ferrine",
			cost=120,
		},
	},
	magic = {
		{
			material="cc_hydroxide",
			cost=250,
		},
		{
			material="cc_sparkling_liquid",
			cost=750,
		},
		{
			material="cc_glittering_liquid",
			cost=750,
		},
		{
			material="cc_metamorphine",
			cost=700,
		},
		{
			material="cc_unstable_metamorphine",
			cost=900,
		},
		{
			material="cc_explode_player",
			cost=350,
		},
		{
			material="cc_metastasizium",
			cost=600,
		},
		{
			material="cc_nullium",
			cost=1000,
		},
		{
			material="cc_persistine",
			cost=350,
		},
	}
}

local AA_potions = {
	standard = {},
	magic = {
		{
			material="aa_base_potion",
			cost=300,
		},
		{
			material="aa_icy_inferno",
			cost=300,
		},
		{
			material="aa_pandorium",
			cost=300,
		},
		{
			material="aa_cloning_solution",
			cost=300,
		},
	}
}

if CC then
	for _,value in ipairs(CC_potions.standard) do
		table.insert(materials_standard, value)
	end

	for _,value in ipairs(CC_potions.magic) do
		table.insert(materials_magic, value)
	end
end

if AA then
	for _,value in ipairs(AA_potions.standard) do
		table.insert(materials_standard, value)
	end

	for _,value in ipairs(AA_potions.magic) do
		table.insert(materials_magic, value)
	end
end
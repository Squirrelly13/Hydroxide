local standard = {
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
}

local magic = {
	{
		material="cc_hydroxide",
		cost=250,
	},
	{
		material="cc_slicing_liquid",
		cost=750,
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
		material="cc_ectospasm",
		cost=500,
	},
	{
		material="cc_deceleratium",
		cost=200,
	},
	{
		material="cc_heftium",
		cost=200,
	},
	{
		material="cc_stillium",
		cost=250,
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

for index, value in ipairs(standard) do
	table.insert(materials_standard, value)
end

for index, value in ipairs(magic) do
	table.insert(materials_magic, magic)
end
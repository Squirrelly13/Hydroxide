cc_alchemist_potions = {
	{
		name = "Hydroxide",
		material = "CC_hydroxide",
		cost = 250,
	},
	{
		name = "Slicing Liquid",
		material = "CC_slicing_liquid",
		cost = 850,
	},
	{
		name = "Sparkling Liquid",
		material = "CC_sparkling_liquid",
		cost = 850,
	},
	{
		name = "Glittering Liquid",
		material = "CC_glittering_liquid",
		cost = 850,
	},
	{
		name = "Jitterium",
		material = "CC_jitterium",
		cost = 600,
	},
	{
		name = "Kindling",
		material = "CC_kindling",
		cost = 500,
	},
	{
		name = "Deceleratium",
		material = "CC_deceleratium",
		cost = 200,
	},
	{
		name = "Heftium",
		material = "CC_heftium",
		cost = 200,
	},
	{
		name = "Stillium",
		material = "CC_stillium",
		cost = 250,
	},
	{
		name = "Metamorphine",
		material = "CC_metamorphine",
		cost = 800,
		default_disabled = true,
	},
	{
		name = "Unstable Metamorphine",
		material = "CC_unstable_metamorphine",
		cost = 1500,
		default_disabled = true,
	},
	{
		name = "Agitine",
		material = "CC_agitine",
		cost = 700,
	},
	{
		name = "$mat_rock_hard",
		material = "rock_hard",
		cost = 450,
	},
	{
		name = "Metastasizium",
		material = "CC_metastasizium",
		cost = 600,
	},
	{
		name = "Nullium",
		material = "CC_nullium",
		cost = 600,
	},
	{
		name = "Grease",
		material = "CC_grease",
		cost = 150,
	},
	{
		name = "Molten Solid Crystal",
		material = "Liquid Crystal",
		cost = 400,
	},
	{
		name = "Radioactive Waste",
		material = "CC_radioactive_waste",
		cost = 950,
	},
	{
		name = "Morphine",
		material = "CC_morphine",
		cost = 300,
	},
	{
		name = "Anti-Matter",
		material = "CC_antimatter_gas",
		cost = 700,
		default_disabled = true,
	},
}

if(potions == nil)then
	potions = {}
end

for i, v in ipairs(cc_alchemist_potions)do
	local setting = ModSettingGet("alchemist_potions_"..v.material)
	local enabled = (setting ~= nil and setting) or (v.default_disabled and false) or true

	--[[
		local setting = ModSettingGet("alchemist_potions_"..v.material)
		local enabled = true
		if(setting ~= nil)then
			enabled = setting
		else
			if(v.default_disabled)then
				enabled = false
			end
		end
	]]

	if(enabled)then
		table.insert(potions, v)
	end
end
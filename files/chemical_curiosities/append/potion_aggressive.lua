cc_alchemist_potions = {
	{
		name = "Hydroxide",
		material = "hydroxide",
		cost = 250,
	},
	{
		name = "Slicing Liquid",
		material = "sliceLiquid",
		cost = 850,
	},
	{
		name = "Sparkling Liquid",
		material = "sparkLiquid",
		cost = 850,
	},
	{
		name = "Glittering Liquid",
		material = "glitteringLiquid",
		cost = 850,
	},
	{
		name = "Jitterium",
		material = "twitchyJuice",
		cost = 600,
	},
	{
		name = "Kindling",
		material = "fireStarter",
		cost = 500,
	},
	{
		name = "Deceleratium",
		material = "magic_liquid_movement_slower",
		cost = 200,
	},
	{
		name = "Heftium",
		material = "magic_liquid_slower_levitation",
		cost = 200,
	},
	{
		name = "Stillium",
		material = "magic_liquid_slower_levitation_and_movement",
		cost = 250,
	},
	{
		name = "Metamorphine",
		material = "metamorphine",
		cost = 800,
		default_disabled = true,
	},
	{
		name = "Unstable Metamorphine",
		material = "unstableMetamorphine",
		cost = 1500,
		default_disabled = true,
	},
	{
		name = "Agitine",
		material = "explodePlayer",
		cost = 700,
	},
	{
		name = "$mat_rock_hard",
		material = "rock_hard",
		cost = 450,
	},
	{
		name = "Metastasizium",
		material = "liquid_projectile_trail",
		cost = 600,
	},
	{
		name = "Nullium",
		material = "antimagic",
		cost = 600,
	},
	{
		name = "Grease",
		material = "grease",
		cost = 150,
	},
	{
		name = "Molten Solid Crystal",
		material = "Liquid Crystal",
		cost = 400,
	},
	{
		name = "Radioactive Waste",
		material = "radiationWaste",
		cost = 950,
	},
	{
		name = "Morphine",
		material = "squirrellymorphine",
		cost = 300,
	},
	{
		name = "Anti-Matter",
		material = "antimatter_gas",
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
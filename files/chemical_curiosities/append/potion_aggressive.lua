cc_alchemist_potions = {
	{
		name = "Hydroxide",
		material = "cc_hydroxide",
		cost = 250,
	},
	{
		name = "Slicing Liquid",
		material = "cc_slicing_liquid",
		cost = 850,
	},
	{
		name = "Sparkling Liquid",
		material = "cc_sparkling_liquid",
		cost = 850,
	},
	{
		name = "Glittering Liquid",
		material = "cc_glittering_liquid",
		cost = 850,
	},
	{
		name = "Jitterium",
		material = "cc_ectospasm",
		cost = 600,
	},
	{
		name = "Kindling",
		material = "cc_kindling",
		cost = 500,
	},
	{
		name = "Deceleratium",
		material = "cc_deceleratium",
		cost = 200,
	},
	{
		name = "Heftium",
		material = "cc_heftium",
		cost = 200,
	},
	{
		name = "Stillium",
		material = "cc_stillium",
		cost = 250,
	},
	{
		name = "Metamorphine",
		material = "cc_metamorphine",
		cost = 800,
		default_disabled = true,
	},
	{
		name = "Agitine",
		material = "cc_explodePlayer",
		cost = 700,
	},
	{
		name = "Dense Rock", --[[ lmao ]]
		material = "rock_hard",
		cost = 450,
	},
	{
		name = "Metastasizium",
		material = "cc_metastasizium",
		cost = 600,
	},
	{
		name = "Grease",
		material = "cc_grease",
		cost = 150,
	},
	{
		name = "Molten Solid Crystal",
		material = "cc_dormant_crystal_molten",
		cost = 400,
	},
	--[[ {
		name = "Anti-Matter Gas",
		material = "cc_antimatter_gas",
		cost = 700,
		default_disabled = true,
	}, ]] --tempting, but maybe best not, at least for now
}

if(potions == nil)then
	potions = {}
end

--[[ for i, v in ipairs(cc_alchemist_potions)do
	local setting = ModSettingGet("alchemist_potions_"..v.material)
	local enabled = (setting ~= nil and setting) or (v.default_disabled and false) or true


		local setting = ModSettingGet("alchemist_potions_"..v.material)
		local enabled = true
		if(setting ~= nil)then
			enabled = setting
		else
			if(v.default_disabled)then
				enabled = false
			end
		end


	if(enabled)then
		table.insert(potions, v)
	end
end ]] --disabled for now since it doesnt work, idk how its supposed to work and i feel its better as a small standalone customisation mod
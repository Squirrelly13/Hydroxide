---@diagnostic disable: undefined-global

local CC = {
	{ origin = "CC", probability = 1.0000, "cc_hydroxide" },
	{ origin = "CC", probability = 0.8000, "cc_persistine" },
	{ origin = "CC", probability = 0.6500, "cc_grease" },
	{ origin = "CC", probability = 0.6000, "cc_iron" },
	{ origin = "CC", probability = 0.6000, "cc_cobalt" },
	{ origin = "CC", probability = 0.6000, "cc_preskite" },
	{ origin = "CC", probability = 0.6000, "cc_methane" },
	{ origin = "CC", probability = 0.4000, "cc_explode_player" },
	{ origin = "CC", probability = 0.3000, "cc_kindling" },
	{ origin = "CC", probability = 0.3000, "cc_ectospasm" },
	{ origin = "CC", probability = 0.2500, "cc_slicing_liquid" },
	{ origin = "CC", probability = 0.2200, "cc_nullium" },
	{ origin = "CC", probability = 0.2000, "cc_dormant_crystal_molten" },
	{ origin = "CC", probability = 0.2000, "cc_blasting_powder" },
	{ origin = "CC", probability = 0.2000, "cc_thunder_powder" },
	{ origin = "CC", probability = 0.2000, "cc_morphine" },
	{ origin = "CC", probability = 0.1600, "cc_uranium" },
	{ origin = "CC", probability = 0.1500, "cc_deceleratium" },
	{ origin = "CC", probability = 0.1500, "cc_heftium" },
	{ origin = "CC", probability = 0.1500, "cc_glittering_liquid" },
	{ origin = "CC", probability = 0.1400, "cc_health_tonic" },
	{ origin = "CC", probability = 0.0500, "cc_stillium" },
	{ origin = "CC", probability = 0.0500, "cc_frozen_meat" },
	{ origin = "CC", probability = 0.0500, "cc_antimatter_gas" },
	{ origin = "CC", probability = 0.0500, "cc_antimatter_liquid" },
	{ origin = "CC", probability = 0.0400, "cc_metamorphine" },
	{ origin = "CC", probability = 0.0030, "cc_unstable_metamorphine" },
	{ origin = "CC", probability = 0.0010, "cc_liberum_magicas" },
	{ origin = "CC", probability = 0.0010, "cc_alchemy_powder" },

	{ origin = "CC", probability = 0.2000, "sulphur"},
	{ origin = "CC", probability = 0.2000, "salt"},
}

local AA = 	{
	{ origin = "AA", probability = 0.8000, "aa_base_potion" },
	{ origin = "AA", probability = 0.7000, "aa_soot" },
	{ origin = "AA", probability = 0.5000, "aa_potion_gas" },
	{ origin = "AA", probability = 0.4000, "aa_pandorium" },
	{ origin = "AA", probability = 0.3522, "aa_condensed_gravity" },
	{ origin = "AA", probability = 0.3500, "aa_arborium" },
	{ origin = "AA", probability = 0.3000, "aa_icy_inferno" },
	{ origin = "AA", probability = 0.3000, "aa_repultium" },
	{ origin = "AA", probability = 0.1761, "aa_cloning_solution" },
	{ origin = "AA", probability = 0.0850, "aa_hungry_slime" },
	{ origin = "AA", probability = 0.0200, "aa_chaotic_pandorium" },
	{ origin = "AA", probability = 0.0040, "aa_unstable_pandorium" },
}

if ModSettingGet("Hydroxide.CC_ENABLED") then
	for _, value in ipairs(CC) do
		MaterialOptions[#MaterialOptions+1] = value
	end
end

if ModSettingGet("Hydroxide.AA_ENABLED") then
	for _, value in ipairs(AA) do
		MaterialOptions[#MaterialOptions+1] = value
	end
end
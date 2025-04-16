local append = [[
	{ probability = 0.2000, "sulphur"},]]

local CC = [[
	{ probability = 1.0000, "cc_hydroxide"},
	{ probability = 0.8000, "cc_persistine"},
	{ probability = 0.6500, "cc_grease"},
	{ probability = 0.6000, "cc_iron"},
	{ probability = 0.6000, "cc_cobalt"},
	{ probability = 0.6000, "cc_preskite"},
	{ probability = 0.6000, "cc_methane"},
	{ probability = 0.4000, "cc_explodePlayer"},
	{ probability = 0.3000, "cc_kindling"},
	{ probability = 0.3000, "cc_ectospasm"},
	{ probability = 0.2500, "cc_slicing_liquid"},
	{ probability = 0.2200, "cc_nullium"},
	{ probability = 0.2000, "cc_dormant_crystal_molten"},
	{ probability = 0.2000, "cc_blasting_powder"},
	{ probability = 0.2000, "cc_thunder_powder"},
	{ probability = 0.2000, "cc_morphine"},
	{ probability = 0.1600, "cc_uranium"},
	{ probability = 0.1500, "cc_deceleratium"},
	{ probability = 0.1500, "cc_heftium"},
	{ probability = 0.1500, "cc_glittering_liquid"},
	{ probability = 0.0500, "cc_stillium"},
	{ probability = 0.0500, "cc_frozen_meat"},
	{ probability = 0.0500, "cc_antimatter_gas"},
	{ probability = 0.0500, "cc_antimatter_liquid"},
	{ probability = 0.0500, "cc_devouring_moss"},
	{ probability = 0.0400, "cc_metamorphine"},
	{ probability = 0.0250, "cc_antimatter_powder"},
	{ probability = 0.0080, "cc_health_tonic"},
	{ probability = 0.0030, "cc_unstable_metamorphine"},
	{ probability = 0.0010, "cc_liberum_magicas"},
	{ probability = 0.0010, "cc_alchemy_powder"},]]

local AA = [[
	{ probability = 0.8000, "aa_base_potion"},
	{ probability = 0.7000, "aa_soot"},
	{ probability = 0.5000, "aa_potion_gas"},
	{ probability = 0.4000, "aa_pandorium"},
	{ probability = 0.3522, "aa_condensed_gravity"},
	{ probability = 0.3500, "aa_arborium"},
	{ probability = 0.3000, "aa_icy_inferno"},
	{ probability = 0.3000, "aa_repultium"},
	{ probability = 0.1761, "aa_cloning_solution"},
	{ probability = 0.1500, "aa_compost"},
	{ probability = 0.1000, "aa_pop_rocks"},
	{ probability = 0.0850, "aa_hungry_slime"},
	{ probability = 0.0800, "aa_chaotic_pandorium"},
	{ probability = 0.0040, "aa_unstable_pandorium"},]]


if ModSettingGet("Hydroxide.CC_ENABLED") then
	append = append .. CC
end

if ModSettingGet("Hydroxide.AA_ENABLED") then
	append = append .. AA
end

ModTextFileSetContent("mods/copis_things/files/scripts/projectiles/material_random.lua", string.gsub(ModTextFileGetContent("mods/copis_things/files/scripts/projectiles/material_random.lua"), "-- APPEND MATERIALS HERE", append .. "\n	-- APPEND MATERIALS HERE"))

local options =
{
	{ probability = 0.2000, "sulphur"},

	{ probability = 1.0000, "cc_hydroxide"},
	{ probability = 0.8000, "cc_persistine"},
	{ probability = 0.6500, "cc_grease"},
	{ probability = 0.6000, "cc_iron"},
	{ probability = 0.6000, "cc_cobalt"},
	{ probability = 0.6000, "cc_preskite"},
	{ probability = 0.6000, "cc_methane"},
	{ probability = 0.5000, "cc_explodePlayer"},
	{ probability = 0.5000, "cc_kindling"},
	{ probability = 0.4000, "cc_morphine"},
	{ probability = 0.4000, "cc_ectospasm"},
	{ probability = 0.3000, "cc_deceleratium"},
	{ probability = 0.3000, "cc_heftium"},
	{ probability = 0.2500, "cc_slicing_liquid"},
	{ probability = 0.2200, "cc_nullium"},
	{ probability = 0.2000, "cc_dormant_crystal_molten"},
	{ probability = 0.2000, "cc_blasting_powder"},
	{ probability = 0.2000, "cc_thunder_powder"},
	{ probability = 0.1500, "cc_stillium"},
	{ probability = 0.1500, "cc_glittering_liquid"},
	{ probability = 0.1000, "cc_uranium"},
	{ probability = 0.0500, "cc_frozen_meat"},
	{ probability = 0.0500, "cc_antimatter_gas"},
	{ probability = 0.0500, "cc_antimatter_liquid"},
	{ probability = 0.0500, "cc_devouring_moss"},
	{ probability = 0.0400, "cc_metamorphine"},
	{ probability = 0.0250, "cc_antimatter_powder"},
	{ probability = 0.0080, "cc_health_tonic"},
	{ probability = 0.0030, "cc_unstable_metamorphine"},
	{ probability = 0.0010, "cc_liberum_magicas"},
	{ probability = 0.0010, "cc_alchemy_powder"},

	{ probability = 0.8000, "aa_base_potion"},
	{ probability = 0.7000, "aa_soot"},
	{ probability = 0.5000, "aa_icy_inferno"},
	{ probability = 0.4000, "aa_pandorium"},
	{ probability = 0.4000, "aa_potion_gas"},
	{ probability = 0.3522, "aa_condensed_gravity"},
	{ probability = 0.3500, "aa_arborium"},
	{ probability = 0.3000, "aa_repultium"},
	{ probability = 0.3000, "aa_compost"},
	{ probability = 0.2000, "aa_pop_rocks"},
	{ probability = 0.1761, "aa_cloning_solution"},
	{ probability = 0.0850, "aa_hungry_slime"},
	{ probability = 0.0800, "aa_chaotic_pandorium"},
	{ probability = 0.0040, "aa_unstable_pandorium"},
}
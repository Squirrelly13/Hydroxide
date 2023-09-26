if ModSettingGet("Hydroxide.cc_pixelscenes") == true then
table.insert(g_pixel_scene_01, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/liquidcave/container_01.png",
		visual_file		= "data/biome_impl/liquidcave/container_01_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "CC_nullium", "CC_hydroxide", "CC_agitine", "CC_veilium", "CC_sparkling_liquid", "CC_slicing_liquid", "CC_glittering_liquid", "AA_hitself", "AA_darkmatter", "AA_static_charge", "AA_repultium", "AA_creeping_slime", "AA_base_potion", "AA_love", "AA_icy_inferno", "AA_condensed_gravity", "AA_cloning_solution", "CC_jitterium", "CC_metamorphine", "CC_unstable_metamorphine", "CC_agitine", "CC_metastasizium", "CC_nullium", } }
	});
end

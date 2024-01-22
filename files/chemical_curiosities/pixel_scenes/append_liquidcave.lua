if ModSettingGet("Hydroxide.cc_pixelscenes") == true then
table.insert(g_pixel_scene_01, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/liquidcave/container_01.png",
		visual_file		= "data/biome_impl/liquidcave/container_01_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "cc_nullium", "cc_hydroxide", "cc_explodePlayer", "cc_veilium", "cc_sparkling_liquid", "cc_slicing_liquid", "cc_glittering_liquid", "aa_hitself", "aa_darkmatter", "aa_static_charge", "aa_repultium", "aa_creeping_slime", "aa_base_potion", "aa_love", "aa_icy_inferno", "aa_condensed_gravity", "aa_cloning_solution", "cc_jitterium", "cc_metamorphine", "cc_unstable_metamorphine", "cc_explodePlayer", "cc_metastasizium", "cc_nullium", } }
	});
end

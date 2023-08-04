if ModSettingGet("Hydroxide.cc_pixelscenes") == true then
table.insert(g_pixel_scene_01, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/liquidcave/container_01.png",
		visual_file		= "data/biome_impl/liquidcave/container_01_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "antimagic", "hydroxide", "explodePlayer", "CC_potionBlindness", "sparkLiquid", "sliceLiquid", "glitteringLiquid", "AA_HITSELF", "AA_DARKMATTER", "AA_STATIC_CHARGE", "AA_REPULTIUM", "AA_CREEPING_SLIME", "AA_NEUTRAL_POTION", "AA_LOVE", "AA_ICEFIRE", "AA_GRAVLIQUID", "AA_CLONE", "twitchyJuice", "metamorphine", "unstableMetamorphine", "explodePlayer", "liquid_projectile_trail", "antimagic", } }
	});
end

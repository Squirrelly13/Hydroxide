if ModSettingGet("Hydroxide.CC_pixelscenes") == true then
table.insert(g_pixel_scene_01, {
	prob			= 0.9,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/coalmine/shrinekindling.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/coalmine/shrinekindling_visual.png",
	background_file	= "",
	is_unique		= 0
	});
	
table.insert(g_pixel_scene_02, {--TODO change 0.9 to lower numebr if this works
	prob			= 0.9,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/coalmine/mossPit.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/coalmine/mossPit_visual.png",
	background_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/coalmine/mossPit_background.png",
	is_unique		= 0
	});

table.insert(g_props, {
	prob		= 0.15,
	min_count	= 1,
	max_count	= 1,
	offset_y 	= 0,
	entity	= "mods/Hydroxide/files/Chemical Curiosities/props/physics_barrel_grease.xml"
});



--[[ oiltank ]]--
table.insert(g_oiltank, {
		prob   			= 0.7,
		material_file 	= "data/biome_impl/coalmine/oiltank_1.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_1_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "grease", "sliceLiquid", "fireStarter", "fireStarter","fireStarter", "sliceLiquid", "plasma_fading","squirrellymorphine", "devouringMoss"} }
}); -- common materials

table.insert(g_oiltank, {
		prob   			= 0.008,
		material_file 	= "data/biome_impl/coalmine/oiltank_1.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_1_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "CC_potionBlindness", "fireStarter", "solidCrystal_molten", "magic_liquid_slower_levitation", "sulphur", "squirrellymorphine" } }
}); --magic materials

table.insert(g_oiltank, {
		prob   			= 0.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_2.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_2_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "fireStarter", "sparkLiquid", "sliceLiquid", "solidCrystal_molten", "AA_ICEFIRE", "devouringMoss"} }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_2.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_2_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "oil", "coal", "radioactive_liquid", "grease", "plasma_fading", "plasma_fading", "squirrellymorphine"  } }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_3.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_3_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "water", "coal", "radioactive_liquid", "magic_liquid_teleportation", "explodePlayer", "grease", "grease","sliceLiquid", "lightningPowder" } }
});

table.insert(g_oiltank, {
		prob   			= 1.1,
		material_file 	= "data/biome_impl/coalmine/oiltank_4.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_4_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "sand", "coal", "radioactive_liquid", "magic_liquid_polymorph", "radiationWaste", "grease", "sliceLiquid", "AA_ICEFIRE", "squirrellymorphine", "lightningPowder"} }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_5.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "radioactive_liquid", "coal", "radioactive_liquid", "radiationWaste" } }
});

end
--[[ lanterns ]]--
if ModSettingGet("Hydroxide.cc_props") == "on" then
table.insert(g_lamp, {
	prob   		= 0.7,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/Hydroxide/files/Chemical Curiosities/props/lanterns/lantern_small_methane.xml",
});
end
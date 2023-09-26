if ModSettingGet("Hydroxide.CC_pixelscenes") == true then
table.insert(g_pixel_scene_01, {
	prob			= 0.9,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/coalmine/shrinekindling.png",
	visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/coalmine/shrinekindling_visual.png",
	background_file	= "",
	is_unique		= 0
	});
	
table.insert(g_pixel_scene_02, {--TODO change 0.9 to lower numebr if this works
	prob			= 0.9,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/coalmine/moss_pit.png",
	visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/coalmine/moss_pit_visual.png",
	background_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/coalmine/moss_pit_background.png",
	is_unique		= 0
	});

table.insert(g_props, {
	prob		= 0.15,
	min_count	= 1,
	max_count	= 1,
	offset_y 	= 0,
	entity	= "mods/Hydroxide/files/chemical_curiosities/props/physics_barrel_grease.xml"
});



--[[ oiltank ]]--
table.insert(g_oiltank, {
		prob   			= 0.7,
		material_file 	= "data/biome_impl/coalmine/oiltank_1.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_1_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "CC_grease", "CC_slicing_liquid", "CC_kindling", "CC_kindling","CC_kindling", "CC_slicing_liquid", "plasma_fading","CC_morphine", "CC_devouring_moss"} }
}); -- common materials

table.insert(g_oiltank, {
		prob   			= 0.008,
		material_file 	= "data/biome_impl/coalmine/oiltank_1.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_1_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "CC_veilium", "CC_kindling", "CC_dormant_crystal_molten", "CC_heftium", "sulphur", "CC_morphine" } }
}); --magic materials

table.insert(g_oiltank, {
		prob   			= 0.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_2.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_2_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "CC_kindling", "CC_sparkling_liquid", "CC_slicing_liquid", "CC_dormant_crystal_molten", "AA_icy_inferno", "CC_devouring_moss"} }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_2.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_2_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "oil", "coal", "radioactive_liquid", "CC_grease", "plasma_fading", "plasma_fading", "CC_morphine"  } }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_3.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_3_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "water", "coal", "radioactive_liquid", "magic_liquid_teleportation", "CC_agitine", "CC_grease", "CC_grease","CC_slicing_liquid", "CC_thunder_powder" } }
});

table.insert(g_oiltank, {
		prob   			= 1.1,
		material_file 	= "data/biome_impl/coalmine/oiltank_4.png",
		visual_file		= "data/biome_impl/coalmine/oiltank_4_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "sand", "coal", "radioactive_liquid", "magic_liquid_polymorph", "CC_radioactive_waste", "CC_grease", "CC_slicing_liquid", "AA_icy_inferno", "CC_morphine", "CC_thunder_powder"} }
});

table.insert(g_oiltank, {
		prob   			= 1.2,
		material_file 	= "data/biome_impl/coalmine/oiltank_5.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "water", "oil", "water", "oil", "alcohol", "radioactive_liquid", "coal", "radioactive_liquid", "CC_radioactive_waste" } }
});

end
--[[ lanterns ]]--
if ModSettingGet("Hydroxide.cc_props") then
table.insert(g_lamp, {
	prob   		= 0.7,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/Hydroxide/files/chemical_curiosities/props/lanterns/lantern_small_methane.xml",
});
end
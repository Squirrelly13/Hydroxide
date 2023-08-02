if ModSettingGet("Hydroxide.cc_props") then
table.insert(g_props, {
	prob 		= 0.3,
	min_count	= 1,
	max_count	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/entities/props/physics_barrel_grease.xml"
});

table.insert(g_props, {
	prob		= 0.4,
	min_count	= 1,
	max_count 	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/entities/props/physics_methane_tank.xml"
});

table.insert(g_props, {
	prob		= 0.01,
	min_count	= 1,
	max_count 	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/entities/props/physics_bloomium_tank.xml"
});

table.insert(g_lamp, {
	prob   		= 0.7,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/Hydroxide/files/entities/props/lanterns/lantern_small_methane.xml",
});
end

if ModSettingGet("Hydroxide.cc_pixelscenes") then
	table.insert(g_pixel_scene_01, {
		prob 			= 0.5,
		material_file	= "mods/Hydroxide/files/pixel_scenes/snowcave/pipeline.png",
		visual_file 	= "mods/Hydroxide/files/pixel_scenes/snowcave/pipeline_visual.png",
		background_file	= "mods/Hydroxide/files/pixel_scenes/snowcave/pipeline_background.png",
		is_unique		= 0
	})
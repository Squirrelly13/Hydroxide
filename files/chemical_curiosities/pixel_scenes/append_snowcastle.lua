---@diagnostic disable: undefined-global

table.insert(g_pixel_scene_01, {
	prob			= 1.0,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcastle/alcohol_pipe.png",
	visual_file		= "",
	background_file	= "",
	is_unique		= 0
	});

table.insert(g_pixel_scene_01, {
	prob			= 1.0,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcastle/shaft2.png",
	visual_file		= "",
	background_file	= "",
	is_unique		= 0
	});

table.insert(g_pixel_scene_02, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcastle/hungry_slime.png",
	visual_file		= "",
	background_file	= "",
	is_unique		= 0
	});

table.insert(g_pixel_scene_02, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcastle/methane_room.png",
	visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcastle/methane_room_visual.png",
	background_file	= "",
	is_unique		= 0
	});

table.insert(g_props, {
	prob		= 0.4,
	min_count	= 1,
	max_count 	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/chemical_curiosities/props/physics_methane_tank.xml"
});

if ModSettingGet("Hydroxide.AA_BLOOMIUM") == true then
	table.insert(g_props, {
		prob		= 0.01,
		min_count	= 1,
		max_count 	= 1,
		offset_y	= 0,
		entity	= "mods/Hydroxide/files/arcane_alchemy/props/physics_bloomium_tank.xml"
	});
end
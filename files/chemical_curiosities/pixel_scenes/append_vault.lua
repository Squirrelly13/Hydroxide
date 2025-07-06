---@diagnostic disable: undefined-global
table.insert(g_pixel_scene_01, {
	prob			= 1.0,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/hydroxidetank.png",
	visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/hydroxidetank_visual.png",
	background_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/hydroxidetank_background.png",
	is_unique		= 0
	});

table.insert(g_pixel_scene_02, {
	prob			= 1.0,
	material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/lab3.png",
	visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/lab3_visual.png",
	background_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/vault/lab3_background.png",
	is_unique		= 0
	});


table.insert(g_props, {
	prob 		= 0.5,
	min_count	= 1,
	max_count	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/chemical_curiosities/props/physics_barrel_grease.xml"
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
		prob		= 0.05,
		min_count	= 1,
		max_count 	= 1,
		offset_y	= 0,
		entity	= "mods/Hydroxide/files/arcane_alchemy/props/physics_bloomium_tank.xml"
	});
end
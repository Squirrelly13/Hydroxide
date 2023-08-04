if ModSettingGet("Hydroxide.cc_pixelscenes") == true then
table.insert(g_pixel_scene_04, {
	prob			= 0.8,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/excavationsite/blast_tank.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/blast_tank_visual.png",
	background_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/blast_tank_background.png",
	is_unique		= 0
	});
	
	
table.insert(g_pixel_scene_04, {
	prob			= 0.8,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/veilium_tank.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/veilium_tank_visual.png",
	background_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/veilium_tank_background.png",
	is_unique		= 0
	});
	
table.insert(g_pixel_scene_04, {
	prob			= 0.6,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/metamorphine.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/metamorphine_visual.png",
	background_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/metamorphine_background.png",
	is_unique		= 0
	});


--[[
table.insert(g_pixel_scene_04_alt, {
	prob			= 0.8,
	material_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/blast_tank.png",
	visual_file		= "mods/Hydroxide/files/pixel_scenes/excavationsite/blast_tank_visual.png",
	background_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/blast_tank_background.png",
	is_unique		= 0
	});
	
	
table.insert(g_pixel_scene_04_alt, {
	prob			= 0.8,
	material_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/veilium_tank.png",
	visual_file		= "mods/Hydroxide/files/pixel_scenes/excavationsite/veilium_tank_visual.png",
	background_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/veilium_tank_background.png",
	is_unique		= 0
	});
	
table.insert(g_pixel_scene_04_alt, {
	prob			= 0.6,
	material_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/metamorphine.png",
	visual_file		= "mods/Hydroxide/files/pixel_scenes/excavationsite/metamorphine_visual.png",
	background_file	= "mods/Hydroxide/files/pixel_scenes/excavationsite/metamorphine_background.png",
	is_unique		= 0
	});
]]--
	
table.insert(g_puzzleroom, {
	prob			= 1.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/puzzleroom_04.png",
	visual_file		= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/puzzleroom_04_visual.png",
	background_file	= "",
	is_unique		= 0
	});
-----

table.insert(g_gunpowderpool_01, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_01_blast.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_01_visual.png",
	background_file	= "",
	is_unique		= 0,
	});

table.insert(g_gunpowderpool_01, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_01_kindling.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_01_visual.png",
	background_file	= "",
	is_unique		= 0,
	});
	


table.insert(g_gunpowderpool_02, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_02_blast.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_02_visual.png",
	background_file	= "",
	is_unique		= 0,
	});

table.insert(g_gunpowderpool_02, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_02_kindling.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_02_visual.png",
	background_file	= "",
	is_unique		= 0,
	});	
	
	
	
table.insert(g_gunpowderpool_03, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_03_blast.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_03_visual.png",
	background_file	= "",
	is_unique		= 0,
	});

table.insert(g_gunpowderpool_03, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_03_kindling.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_03_visual.png",
	background_file	= "",
	is_unique		= 0,
	});
	
	
	
table.insert(g_gunpowderpool_04, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_04_blast.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_04_visual.png",
	background_file	= "",
	is_unique		= 0,
	});

table.insert(g_gunpowderpool_04, {
	prob			= 0.5,
	material_file	= "mods/Hydroxide/files/Chemical Curiosities/pixel_scenes/excavationsite/gunpowderpool_04_kindling.png",
	visual_file		= "data/biome_impl/excavationsite/gunpowderpool_04_visual.png",
	background_file	= "",
	is_unique		= 0,
	});
	
end
if ModSettingGet("Hydroxide.cc_props") == true then
table.insert(g_props, {
	prob 		= 0.2,
	min_count	= 1,
	max_count	= 1,
	offset_y	= 0,
	entity	= "mods/Hydroxide/files/Chemical Curiosities/props/physics_barrel_grease.xml"
});

table.insert(g_lamp, {
	prob   		= 0.7,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/Hydroxide/files/Chemical Curiosities/props/lanterns/lantern_small_methane.xml",
});
end
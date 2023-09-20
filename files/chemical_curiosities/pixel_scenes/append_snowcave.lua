if ModSettingGet("Hydroxide.cc_props") == true then
	table.insert(g_props, {
		prob 		= 0.3,
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

	table.insert(g_props, {
		prob		= 0.01,
		min_count	= 1,
		max_count 	= 1,
		offset_y	= 0,
		entity	= "mods/Hydroxide/files/arcane_alchemy/props/physics_bloomium_tank.xml"
	});

	table.insert(g_lamp, {
		prob   		= 0.7,
		min_count	= 1,
		max_count	= 1,
		entity 	= "mods/Hydroxide/files/chemical_curiosities/props/lanterns/lantern_small_methane.xml",
	});
end



if ModSettingGet("Hydroxide.CC_pixelscenes") == true then

	table.insert(g_pixel_scene_01,{
		prob			= 0.5,
		material_file	= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcave/pipeline.png",
		visual_file		= "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcave/pipeline_visual.png",
		background_file = "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/snowcave/pipeline_background.png",
		is_unique		= 0
	
	});

	
	RegisterSpawnFunction( 0xffff00be, "spawn_methane")
	function spawn_methane(x, y)
		if safe( x, y ) then
			EntityLoad( "data/entities/props/dripping_methane_gas.xml", x, y )
		end
	end
end
	
	

if ModSettingGet("Hydroxide.cc_props") == true then
table.insert(g_props, {
	prob		= 0.35,
	min_count	= 1,
	max_count	= 1,
	offset_y 	= 0,
	entity	= "mods/Hydroxide/files/Chemical Curiosities/props/physics_barrel_grease.xml"
});

table.insert(g_lamp, {
	prob   		= 0.7,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/Hydroxide/files/Chemical Curiosities/props/lanterns/lantern_small_methane.xml",
});
end
-- put weighted table here 
SetRandomSeed( StatsGetValue("world_seed"), StatsGetValue("world_seed") )
starterpotions = {
	{	probability = 1.500, "water"},
	{	probability = 1.000, "water_swamp"},
	{ 	probability = 1.000, "water_salt"},
	{	probability = 1.000, "swamp"},
	{	probability = 1.000, "snow"},
	{	probability = 0.800, "blood"},
	{	probability = 0.700, "cc_grease"},
	{	probability = 0.100, "cc_devouring_moss"},
	{	probability = 0.600, "cc_sparkling_liquid"},
	{	probability = 0.600, "cc_slicing_liquid"},
	{	probability = 0.600, "cc_glittering_liquid"},
	{	probability = 0.600, "cc_methane"},
	{	probability = 0.600, "aa_repultium"},
	{	probability = 0.400, "aa_hungry_slime"},
	{	probability = 0.700, "aa_base_potion"},
	{	probability = 0.200, "aa_arborium"},
	{	probability = 0.200, "aa_pop_rocks"},
	{	probability = 0.500, "cc_kindling"},
	{	probability = 0.100, "cc_metamorphine"},
	{	probability = 0.050, "cc_unstable_metamorphine"},
	{	probability = 0.050, "cc_health_tonic"},
	{	probability = 0.500, "cc_frozen_meat"},	
	{	probability = 0.500, "cc_persistine"},
}

magicpotions = { 
"acid",
"magic_liquid_polymorph",
"magic_liquid_random_polymorph",
"magic_liquid_berserk",
"magic_liquid_charm",
"magic_liquid_movement_faster",
"cc_deceleratium",
"cc_heftium",
"cc_veilium",
"cc_agitine",
}


function potion_a_materials()
	rnd = random_create(Random(1,100), Random(1,100))
	local r_value = Random( 1, 100 )
	if( r_value <= 80 ) then
		return tostring(pick_random_from_table_weighted( rnd, starterpotions)[1])
	elseif( r_value <= 99 ) then
		r_value = Random( 0, 100 )
		return random_from_array( magicpotions )
	else
		-- one in a million shot
		r_value = Random( 0, 100000 )
		if( r_value == 666 ) then return "urine" end
		if( r_value == 79 ) then return "gold" end 
		return random_from_array( { "slime", "gunpowder_unstable" } )
	end
end


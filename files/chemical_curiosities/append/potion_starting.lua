-- put weighted table here 
SetRandomSeed( StatsGetValue("world_seed"), StatsGetValue("world_seed") )
starterpotions = {
	{	probability = 1.500, "water"},
	{	probability = 1.000, "water_swamp"},
	{ 	probability = 1.000, "water_salt"},
	{	probability = 1.000, "swamp"},
	{	probability = 1.000, "snow"},
	{	probability = 0.800, "blood"},
	{	probability = 0.700, "CC_grease"},
	{	probability = 0.100, "CC_devouring_moss"},
	{	probability = 0.600, "CC_sparkling_liquid"},
	{	probability = 0.600, "CC_slicing_liquid"},
	{	probability = 0.600, "CC_glittering_liquid"},
	{	probability = 0.600, "CC_methane"},
	{	probability = 0.150, "AA_BLOOM_MAGIC"},
	{	probability = 0.600, "AA_repultium"},
	{	probability = 0.400, "AA_hungry_slime"},
	{	probability = 0.700, "AA_base_potion"},
	{	probability = 0.200, "AA_arborium"},
	{	probability = 0.200, "AA_pop_rocks"},
	{	probability = 0.500, "CC_kindling"},
	{	probability = 0.100, "CC_metamorphine"},
	{	probability = 0.050, "CC_unstable_metamorphine"},
	{	probability = 0.050, "CC_health_tonic"},
	{	probability = 0.300, "CC_morphine"},
	{	probability = 0.500, "CC_frozen_meat"},	
	{	probability = 0.500, "CC_persistine"},
}

magicpotions = { 
"acid",
"magic_liquid_polymorph",
"magic_liquid_random_polymorph",
"magic_liquid_berserk",
"magic_liquid_charm",
"magic_liquid_movement_faster",
"CC_deceleratium",
"CC_heftium",
"CC_veilium",
"CC_agitine",
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


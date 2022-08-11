-- put weighted table here 
SetRandomSeed( StatsGetValue("world_seed"), StatsGetValue("world_seed") )
starterpotions = {
	{	probability = 2.500, "water"},
	{	probability = 1.800, "water_swamp"},
	{ 	probability = 1.800, "water_salt"},
	{	probability = 1.800, "swamp"},
	{	probability = 1.800, "snow"},
	{	probability = 0.700, "grease"},
	{	probability = 0.010, "devouringMoss"},
	{	probability = 0.800, "sulphiricWater"},
	{	probability = 0.500, "sparkLiquid"},
	{	probability = 0.400, "sliceLiquid"},
	{	probability = 0.300, "gliterringLiquid"},
	{	probability = 0.600, "methane"},
	{	probability = 0.050, "AA_MAT_BLOOM_MAGIC"},
	{	probability = 0.300, "AA_MAT_REPULTIUM"},
	{	probability = 0.090, "AA_MAT_HUNGRY_SLIME"},
	{	probability = 0.700, "AA_MAT_NEUTRAL_POTION"},
	{	probability = 0.090, "AA_MAT_ARBORIUM"},
	{	probability = 0.050, "AA_LIQUID_ROCK"},
	{	probability = 0.100, "fireStarter"},
	{	probability = 0.050, "metamorphine"},
	{	probability = 0.005, "unstableMetamorphine"},
	{	probability = 0.001, "increaseMaxHP"},
	{	probability = 0.150, "squirrellymorphine"},
	{	probability = 0.300, "rotten_meat"},	
}

magicpotions = { 
"acid",
"magic_liquid_polymorph",
"magic_liquid_random_polymorph",
"magic_liquid_berserk",
"magic_liquid_charm",
"magic_liquid_movement_faster",
"magic_liquid_movement_slower",
"magic_liquid_slower_levitation",
"potionBlindness",
"explodePlayer",
}


function potion_a_materials()
	rnd = random_create(Random(1,100), Random(1,100))
	local r_value = Random( 1, 100 )
	if( r_value <= 65 ) then
		return tostring(pick_random_from_table_weighted( rnd, starterpotions)[1])
	elseif( r_value <= 70 ) then
		return "blood"
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


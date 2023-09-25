-- put weighted table here 
SetRandomSeed( StatsGetValue("world_seed"), StatsGetValue("world_seed") )
starterpotions = {
	{	probability = 1.500, "water"},
	{	probability = 1.000, "water_swamp"},
	{ 	probability = 1.000, "water_salt"},
	{	probability = 1.000, "swamp"},
	{	probability = 1.000, "snow"},
	{	probability = 0.800, "blood"},
	{	probability = 0.700, "grease"},
	{	probability = 0.100, "devouringMoss"},
	{	probability = 0.600, "sparkLiquid"},
	{	probability = 0.600, "sliceLiquid"},
	{	probability = 0.600, "gliterringLiquid"},
	{	probability = 0.600, "methane"},
	{	probability = 0.150, "AA_BLOOM_MAGIC"},
	{	probability = 0.600, "AA_REPULTIUM"},
	{	probability = 0.400, "AA_HUNGRY_SLIME"},
	{	probability = 0.700, "AA_NEUTRAL_POTION"},
	{	probability = 0.200, "AA_ARBORIUM"},
	{	probability = 0.200, "AA_LIQUID_ROCK"},
	{	probability = 0.500, "fireStarter"},
	{	probability = 0.100, "metamorphine"},
	{	probability = 0.050, "unstableMetamorphine"},
	{	probability = 0.050, "increaseMaxHP"},
	{	probability = 0.300, "squirrellymorphine"},
	{	probability = 0.500, "frozen_meat"},	
	{	probability = 0.500, "ferrineSkin"},
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
"CC_potionBlindness",
"explodePlayer",
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


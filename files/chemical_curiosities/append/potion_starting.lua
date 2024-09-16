-- put weighted table here 
local world_seed = tonumber(StatsGetValue("world_seed")) or 1
SetRandomSeed( world_seed, world_seed )
local starterpotions = {
	{	probability = 1.500, "water"},
	{	probability = 1.000, "water_swamp"},
	{ 	probability = 1.000, "water_salt"},
	{	probability = 1.000, "swamp"},
	{	probability = 1.000, "snow"},
	{	probability = 0.800, "blood"},
}

local cc_starterpotions = {
	{	probability = 0.700, "cc_grease"},
	{	probability = 0.100, "cc_devouring_moss"},
	{	probability = 0.600, "cc_sparkling_liquid"},
	{	probability = 0.075, "cc_unstable_metamorphine"},
	{	probability = 0.050, "cc_health_tonic"},
	{	probability = 0.010, "cc_frozen_meat"},	
	{	probability = 0.500, "cc_persistine"},
	{	probability = 0.400, "cc_dormant_crystal_molten"},
	{	probability = 0.030, "cc_antimatter_gas"},
	{	probability = 0.030, "cc_antimatter_liquid"},
	{	probability = 0.030, "cc_antimatter_powder"},
}

local aa_starterpotions = {
	{	probability = 0.600, "aa_repultium"},
	{	probability = 0.400, "aa_hungry_slime"},
	{	probability = 0.700, "aa_base_potion"},
	{	probability = 0.200, "aa_arborium"},
	{	probability = 0.010, "aa_unstable_pandorium"},
	{	probability = 0.150, "aa_catalyst"},
	{	probability = 0.300, "aa_icy_inferno"},
	{	probability = 0.100, "aa_compost"},
}


local magicpotions = { 
	"acid",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_movement_faster",
}

local cc_magicpotions = {
	"cc_veilium",
	"cc_explodePlayer",
	"cc_metamorphine",
	"cc_slicing_liquid",
	"cc_glittering_liquid",
}

local aa_magicpotions = {
	"aa_darkmatter",
	"aa_base_potion",
	"aa_love",
	"aa_pandorium",
	"aa_chaotic_pandorium",
	"aa_cloning_solution",
}

function combine_table(base, addition)
	for i=1,#addition do
		base[#base+1] = addition[i]
	end
	return base
end
function TableConcat(t1,t2)
 end

function potion_a_materials()

	if true then return "terror_teleportatium" end --function for forcing mat in case of testing

	if (ModSettingGet("Hydroxide.CC_MATERIALS")) then
		starterpotions = combine_table(starterpotions, cc_starterpotions)
		magicpotions = combine_table(magicpotions, cc_magicpotions)
	end
	if (ModSettingGet("Hydroxide.AA_MATERIALS")) then
		starterpotions = combine_table(starterpotions, aa_starterpotions)
		magicpotions = combine_table(magicpotions, aa_magicpotions)
	end

	local date_time = {year = 0, month = 0, day = 0, hour = 0, minute = 0, second = 0}
	date_time.year, date_time.month, date_time.day, date_time.hour, date_time.minute, date_time.second = GameGetDateAndTimeUTC()

	rnd = random_create(Random(1,100), Random(1,100))
	local r_value = Random( 1, 100 )

	if (date_time.month == 4 and date_time.day == 1 and ModSettingGet("Hydroxide.AA_MATERIALS") and r_value >= 10) then
		return "aa_hitself" -- 10% chance on April Fools for joke material
	elseif (date_time.month == 7 and date_time.day == 4 and ModSettingGet("Hydroxide.CC_MATERIALS") and r_value >= 20) then
		return "cc_glittering_liquid" -- 20% chance on 4th of July for fireworks material
	elseif( r_value <= 80 ) then
		return tostring(pick_random_from_table_weighted( rnd, starterpotions)[1])
	elseif( r_value <= 99 ) then
		r_value = Random( 0, 100 )

		local outcome = random_from_array( magicpotions )
		if (outcome == "acid" and Random(1,2) == 1) then --50/50 between acid and hydroxide
			return "cc_hydroxide"
		else
			return outcome
		end

		
	else
		-- one in a million shot
		r_value = Random( 0, 100000 )
		if( r_value == 666 ) then return "urine" end
		if( r_value == 79 ) then return "gold" end 
		if( r_value == 100 ) then return "cc_warp_powder" end
		if( r_value == 77 ) then return "cc_alchemy_powder" end
		if( r_value == 777 ) then return "cc_liberum_magicas" end
		return random_from_array( { "slime", "gunpowder_unstable", "kindling" } )
	end
end


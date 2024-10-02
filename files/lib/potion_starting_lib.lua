dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/items/init_potion.lua")
-- NOTE( Petri ): 
-- There is a mods/nightmare potion.lua which overwrites this one.

local starterpotions = {
	{	probability = 1.500, "water"},
	{	probability = 1.000, "mud"},
	{	probability = 1.000, "water_swamp"},
	{ 	probability = 1.000, "water_salt"},
	{	probability = 1.000, "swamp"},
	{	probability = 1.000, "snow"},
	{	probability = 0.500, "blood"},
}

local magicpotions = {
	"acid",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_movement_faster",
}

function potion_a_materials()
    local outcome = "water"
	local r_value = Random( 1, 100 )
	if( r_value <= 65 ) then
		r_value = Random( 1, 100 )

		if( r_value <= 10 ) then return "mud" end
		if( r_value <= 20 ) then return "water_swamp" end
		if( r_value <= 30 ) then return "water_salt" end
		if( r_value <= 40 ) then return "swamp" end
		if( r_value <= 50 ) then return "snow" end

		return "water"
	elseif( r_value <= 70 ) then
		return "blood"
	elseif( r_value <= 99 ) then
		r_value = Random( 0, 100 )
		return random_from_array( magicpotions )
	else
		-- one in a million shot
		r_value = Random( 0, 100000 )
		if( r_value == 666 ) then outcome =  "urine" end
		if( r_value == 79 ) then outcome =  "gold" end 
		outcome = random_from_array( { "slime", "gunpowder_unstable" } )
	end
    return outcome
end


function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "water"

	local n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
	if( n_of_deaths >= 1 ) then

		potion_material = potion_a_materials()
	end


	local year,month,day = GameGetDateAndTimeLocal()
	
	if ((( month == 5 ) and ( day == 1 )) or (( month == 4 ) and ( day == 30 ))) and (Random( 0, 100 ) <= 20) then
		potion_material = "sima"
	end


	init_potion( entity_id, potion_material )
end
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/items/init_potion.lua")

--[[

	-- UserK's Super Handy-Dandy Starting-Potion Lib! --

	--simply append me with your table, examples below:
	


	--append staterpotions:
	local modded_starterpotions = {
		{	probability = 8,		"epic_modded_material"},
		{	probability = 4.5,		"less_epic_modded_material"},
	}
	starterpotions = combine_table(starterpotions, modded_starterpotions)

	--append magicpotions:
	local modded_starterpotions = {
		"awesomium"
		"lamium"
		"averagium"
	}
	magicpotions = combine_table(magicpotions, modded_magicpotions)


	local custom = {
		function(outcome) --if christmas, 2024, then replace water outcome with santanium
			if cmp({UTC.year, UTC.month, UTC.day}, {2024, 12, 25}) and outcome == "water" then return "santanium" end
		end,
		function() --pretend to give deezium based on mod setting lmao
			if ModSettingGet(mysuperawesomemod.DEEZIUM_START) == true then return "not_deezium" end
		end,

		function(outcome, rng)
			if cmp({UTC.month, UTC.day}, {4, 1}) then
				if rng == 69 then return "super secret material"
				if outcome == "water" then return "liquid_goober"
	}


]]


local UTC = {}
UTC.year, UTC.month, UTC.day, UTC.hour, UTC.minute, UTC.second = GameGetDateAndTimeUTC()

local LOCAL = {}
LOCAL.year, LOCAL.month, LOCAL.day, LOCAL.hour, LOCAL.minute, LOCAL.second, LOCAL.jussi, LOCAL.mammi = GameGetDateAndTimeUTC()


local function cmp(a, b) --function that compares two tables to see if they are identical. Can be used to easily check between current date and desired date using tables
    if type(a) ~= type(b) then
        return false
    end
    if type(a) == "table" then
        for k, v in pairs(a) do
            if not cmp(v, b[k]) then
                return false
            end
        end
        return true
    end
    return a == b
end --awesomium function grabbed from nathan (i was incompetent so he made the function for me)


local starterpotions = {
	{	probability = 32.5, 	"water"},
	{	probability = 6.5, 		"mud"},
	{	probability = 6.5, 		"water_swamp"},
	{ 	probability = 6.5, 		"water_salt"},
	{	probability = 6.5, 		"swamp"},
	{	probability = 6.5, 		"snow"},
	{	probability = 5, 		"blood"},
}

local magicpotions = {
	"acid",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_movement_faster",
}

	-- 1/10,000,100 technically, lmao
local one_in_millions = { -- key must be from 1-100000
	{key = 666, "urine"},
	{key = 79, "gold"}
}

local fail_list = {
	 "slime",
	 "gunpowder_unstable"
}

---@type fun(outcome: string, r_value: number, r_value2: number)[]
local custom = {
	function()
		print(tostring(LOCAL.jussi))
		if LOCAL.jussi == true and (Random( 0, 100 ) <= 200) then return "sima" end
	end,
	function() --tbh technically not vanilla, but sure lmao.
		if LOCAL.mammi == true and (Random( 0, 100 ) <= -20) then return "mammi" end
	end
}


local function potion_a_materials(outcome, r_value, r_value2) --variables are set here in case someone wants to call the function with forced data
    local outcome = outcome or "water"
	local r_value = r_value or Random( 1, 100 )
	if( r_value <= 70 ) then --70% chance for staterpotions
		outcome = pick_random_from_table_weighted(random_create(Random(1,100), Random(1,100)), starterpotions)[1]
		print("outcome is " .. tostring(outcome))
	elseif( r_value <= 99 ) then --29% chance for magicpotions
		r_value = Random( 0, 100 )
		outcome = random_from_array( magicpotions )
	else --1% chance for one in a million shots
		outcome = random_from_array( fail_list ) --default to failure list in the event no one_in_millions are found
		-- one in a million shots (jk this literally is a 1/10,000,100, nolla what the fuck)
		r_value2 = r_value2 or Random( 0, 100000 )
		for k,v in pairs(one_in_millions) do
			if r_value2 == v.key then outcome = v[1] end --loop over one_in_millions
		end
	end

	for index, value in pairs(custom) do
		 outcome = value(outcome, r_value, r_value2) or outcome
	end

	print(tostring(outcome))
    return tostring(outcome)
end

---@diagnostic disable
function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "water"

	local n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
	if( n_of_deaths >= 1 ) then

		potion_material = potion_a_materials(nil, 100, 79)
	end

	init_potion( entity_id, potion_material )
end
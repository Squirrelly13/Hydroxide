---@diagnostic disable: undefined-global, lowercase-global
--[[

									-- UserK's Super Handy-Dandy Starting-Potion Lib! --

	simply override "data/scripts/items/potion_starting.lua" with the "potion_starting.lua" file and then append the file location with your tables and merge functions
	
	
	appending should look something like:

	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/your_mod/file/path/to/your/custom_starting_potion_appends.lua" )


	then your "custom_starting_potion_appends.lua" should have local tables that you then merge into the global tables found in the library. Examples can be found below:

]]


-- THIS IS PRIMARILY GOING TO BE SHOWING HOW TO APPEND THESE LISTS, IF YOU WISH TO KNOW MORE ABOUT HOW THEY WORK, LOOK AT THE LIBRARY FILE FOR COMMENTS EXPLAINING



local ps = PotionStartingLib --we do this at the beginning so we dont have to deal with the really long "PotionStartingLib" all the time

--append staterpotions:
local modded_starterpotions = {
	{	probability = 8,		"epic_modded_material"},
	{	probability = 4.5,		"less_epic_modded_material"},
	{							"honestly_kinda_crap_modded_material"} --probability is an optional field that will default to 10 if left nil
}
ps.starterpotions = ps.CombineTables(ps.starterpotions, modded_starterpotions) --format for combining tables should be lib_table = combine_tabless(lib_table, modded_table)
--this table probably doesnt need to be altered much since its mostly comprised of more mundane materials like waters, blood, mud etc, but its up to you


--append magicpotions:
local modded_magicpotions = { 
	{"awesomium"}, --even if you arent using probability, each material should be contained within its own table
	{"lamium"},
	{"averagium", probability = 30}, --adding probability fields is optional for starterpotions, magicpotions, and failpotions
}
ps.magicpotions = ps.CombineTables(ps.magicpotions, modded_magicpotions)
--this is the main table I would recommend appending, add a couple magical liquids that you think would be interesting to start a run with here



----- ^^^ this is basically all the average modder needs to care about. look below for some additional funny things ^^^ ----







--append one_in_millions
local modded_one_in_millions = {
	{	key = 0,	"existium"}, --"key" can range from 0 to 100,000
	{	key = -1,	"non_existium"}, --anything outside this range cannot be found
}
ps.one_in_millions = ps.CombineTables(ps.one_in_millions, modded_one_in_millions)


--append failpotions
local modded_failpotions = {
	{"just_death"} --idk i ran out of funnies, this just appends like any of the other functions, this one's fairly self-explanatory. Probability is also optional here
}
ps.failpotions = ps.CombineTables(ps.failpotions, modded_failpotions)



--append functions
local modded_functions = {
	function(outcome) --if christmas, 2024, then replace water outcome with santanium
		if ps.CompareTables({ps.UTC.year, ps.UTC.month, ps.UTC.day}, {2024, 12, 25}) and outcome == "water" then return "santanium" end
	end,
	function() --pretend to give deezium based on mod setting lmao
		if ModSettingGet("mysuperawesomemod.DEEZIUM_START") == true then return "not_deezium" end
	end,
	
	function(outcome, r_value)
		if ps.CompareTables({ps.UTC.month, ps.UTC.day}, {4, 1}) then
			if r_value == 69 then return "super_secret_material" end 	--check r_value for 1% chance
			if outcome == "water" then return "liquid_goober" end 		--if water, replace with liquid_goober
		end
	end --(functions probably should not be separated out like this, im just showing that they can be and roughly what it looks like if multiple mods append function stuff to the table)
}
ps.functions = ps.CombineTables(ps.functions, modded_functions)
--this allows you to run your own functions after the initial material has been chosen

--append functions2
local modded_functions2 = {
	function() --would recommend putting your functions together like this where possible btw
		if ps.LOCAL.jussi == true and (Random( 0, 100 ) <= 20) then return "sima" end
		if ps.LOCAL.mammi == true and (Random( 0, 100 ) <= 20) then return "mammi" end
	end
}
functions2 = ps.CombineTables(functions2, modded_functions2)
--this effectively acts as an override, runs outside the main potion_a_materials() function and runs directly after it within the init() function
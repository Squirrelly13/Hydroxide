---@diagnostic disable: undefined-global
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/items/init_potion.lua")


---Default potion material
local potion_material = "water"

---Current UTC time
UTC = {}
UTC.year, UTC.month, UTC.day, UTC.hour, UTC.minute, UTC.second = GameGetDateAndTimeUTC()

---Current Local time (includes jussi and mammi bools)
LOCAL = {}
LOCAL.year, LOCAL.month, LOCAL.day, LOCAL.hour, LOCAL.minute, LOCAL.second, LOCAL.jussi, LOCAL.mammi = GameGetDateAndTimeLocal()


---This function combines tables so you can easily merge your custom tables into the vanilla ones
function CombineTables(base, addition)
	for i=1,#addition do
		base[#base+1] = addition[i]
	end
	return base
end

---Function that compares two tables to see if they are identical. Can be used to easily check between current date and desired date using tables. By Nahtan
function CompareTables(a, b) 
    if type(a) ~= type(b) then
        return false
    end
    if type(a) == "table" then
        for k, v in pairs(a) do
            if not CompareTables(v, b[k]) then
                return false
            end
        end
        return true
    end
    return a == b
end --awesomium function grabbed from nathan (i was incompetent so he made the function for me)

---This function just corrects the tables that lack probability fields. Probability will default to 10 for all material tables
function CorrectTables()
	for index, value in ipairs({starterpotions, magicpotions, failpotions}) do
		for k, v in ipairs(value) do
			if v.probability == nil then v.probability = 10 print(v[1] .. " corrected.") end
		end
	end
end


---starter potions, 70% chance to pull from this table
starterpotions = {
	{	probability = 32.5, 	"water"			},
	{	probability = 6.5, 		"mud"			},
	{	probability = 6.5, 		"water_swamp"	},
	{ 	probability = 6.5, 		"water_salt"	},
	{	probability = 6.5, 		"swamp"			},
	{	probability = 6.5, 		"snow"			},
	{	probability = 5, 		"blood"			},
}

---magic potions, 29% chance to pull from this table
magicpotions = {
	{	"acid"							},
	{	"magic_liquid_polymorph"		},
	{	"magic_liquid_random_polymorph"	},
	{	"magic_liquid_berserk"			},
	{	"magic_liquid_charm"			},
	{	"magic_liquid_movement_faster"	},
}

	-- 1/10,000,100 technically, lmao.
one_in_millions = { -- "key" must be from 1 to 100000
	{	key = 666, 	"urine"},
	{	key = 79, 	"gold"}
}

---Material outcomes if the "one-in-a-million" doesnt hit anything
failpotions = {
	{	"slime"					},
	{	"gunpowder_unstable"	}
}

---Table of custom functions potion_a_materials runs through before returning the chosen material
---@type fun(outcome: string, r_value: number, r_value2: number, data: table)[]
functions = {
	function()
		if CompareTables({LOCAL.month, LOCAL.day}, {5, 1}) or CompareTables({LOCAL.month, LOCAL.day}, {4, 30}) and (Random( 0, 100 ) <= 20) then return "sima" end
	end
}

---Table of custom functions init runs through after potion_a_materials returns the chosen material
---@type fun(potion_material: string, data: table)[]
local functions2 = {
}




---Function that chooses the potion material
local function potion_a_materials(outcome, r_value, r_value2, data) --Variables are available as inputs in case you want to run with forced RNG. data lets you pass extra data if you want
    outcome = outcome or potion_material
	r_value = r_value or Random( 1, 100 )
	r_value2 = r_value2 or Random( 0, 100000 )
	data = data or {}

	local rnd = random_create(r_value, r_value2)
	if( r_value <= 70 ) then --70% chance for staterpotions
		outcome = pick_random_from_table_weighted(rnd, starterpotions)[1]
	elseif( r_value <= 99 ) then --29% chance for magicpotions
		r_value = Random( 0, 100 )
		outcome = pick_random_from_table_weighted(rnd, magicpotions)[1]
	else --1% chance to try for the one_in_millions
		outcome = pick_random_from_table_weighted(rnd, failpotions)[1]
		for k,v in pairs(one_in_millions) do
			if r_value2 == v.key then outcome = v[1] end --loop over one_in_millions
		end
	end

	if functions ~= nil then --in case someone empties the function to skip this step
		for index, value in pairs(functions) do
			 outcome = value(outcome, r_value, r_value2, data) or outcome
		end
	end
	
    return tostring(outcome)
end

---@diagnostic disable
function init( entity_id ) --mostly vanilla function
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y )
	CorrectTables() --add default probabilities

	TEST(100000) --1 billion took about 45 minutes for me to render so 100k-10mil should be good enough for regular tests (probs still super excessive tbh lmao)

	local n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
	if( n_of_deaths >= 1 ) then
		potion_material = potion_a_materials() or potion_material --if potion_a_materials returns nil or smth, default to potion_material
	end

	
	if functions2 ~= nil then
		for index, value in pairs(functions2) do
			potion_material = value(potion_material) or potion_material
   		end
	end

	init_potion( entity_id, potion_material )
end




--Handy script for mass-generating potion outcomes
function TEST(num)
	local keys = {}
	local _table = {}
	
	for i = 1, num do
		if i % (num/100) == 0 then print(i/(num/100).."%") end --prints n% when n is a whole number (basically print current% without decimals)
		local result = potion_a_materials() --simulate potion start
		_table[result] = (_table[result] or 0) + 1 --add string to table, give it +1 every time its returned
	end
	
	local t = {}
	for k, v in pairs(_table) do
	  table.insert(t, { key = k, value = v }) --sort function grabbed from Ribbit and Horscht after very painstakingly futile attempts to explain this to me
	end
	table.sort(t, function(a, b)
	  return a.value > b.value
	end)

	local longest_string
	for i, j in ipairs(t) do --print table
		longest_string = longest_string or string.len(j.value)
		local material_name = j.key .. ','
		local material_amount = j.value .. ','
		local material_percent = j.value/(num/100) .. ','
		local material_percent_rounded = math.floor(((j.value/(num/100)) + 0.5) * 10) * .1
		
		for l = 0, 35 - string.len(material_name) do
			material_name = material_name .. ' '
		end
		for l = 0, longest_string - string.len(tostring(material_amount)) do
			material_amount = ' ' .. material_amount
		end
		for l = 0, 15 - string.len(tostring(material_amount)) - longest_string do
			material_amount = material_amount .. ' '
		end
		for l = 0, 15 - string.len(material_percent) do
			material_percent = material_percent .. ' '
		end
		print(material_name .. " = " .. material_amount .. material_percent .. string.format("%.1f", material_percent_rounded))
	end
end

---@diagnostic disable: undefined-global, lowercase-global

local PS = PotionStartingLib --shorten the ugly PotionStartingLib

local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")
local FF = ModSettingGet("Hydroxide.FF_ENABLED")
local Terror = ModSettingGet("Hydroxide.TERROR_ENABLED")

local cc_starterpotions = {
	{	probability = 3.50,		"cc_grease"},
	{	probability = 3.00,		"cc_sparkling_liquid"},
	{	probability = 2.50,		"cc_persistine"},
	{	probability = 2.00,		"cc_dormant_crystal_molten"},
	{	probability = 1.00,		"cc_frozen_meat"},	
	{	probability = 0.50,		"cc_devouring_moss"},
	{	probability = 0.35,		"cc_unstable_metamorphine"},
	{	probability = 0.30,		"cc_health_tonic"},
	{	probability = 0.15,		"cc_antimatter_liquid"}
}

local cc_magicpotions = {
	{"cc_veilium"},
	{"cc_explodePlayer"},
	{"cc_metamorphine"},
	{"cc_slicing_liquid"},
	{"cc_glittering_liquid"},
}

local cc_one_in_millions = {
	{	key = 77, 	"cc_alchemy_powder"},
	{	key = 777, 	"cc_liberum_magicas"},
	{	key = 778, 	"cc_warp_powder"},
	{	key = 779, 	"cc_paradox_powder"}
}

local cc_failpotions = {
	{"cc_kindling"}
}

local cc_functions = {
	function(outcome, r_value)
		if (PS.CompareTables({PS.LOCAL.month, PS.LOCAL.day}, {7,4}) and Random(1, 5) == 5) then return "cc_glittering_liquid" -- 20% chance on 4th of July for fireworks material
		elseif outcome == "acid" and Random(0,1) then return "cc_hydroxide"
		end
	end
}

if CC then
	PS.starterpotions = PS.CombineTables(PS.starterpotions, cc_starterpotions)
	PS.magicpotions = PS.CombineTables(PS.magicpotions, cc_magicpotions)
	PS.one_in_millions = PS.CombineTables(PS.one_in_millions, cc_one_in_millions)
	PS.failpotions = PS.CombineTables(PS.failpotions, cc_failpotions)
	PS.functions = PS.CombineTables(PS.functions, cc_functions)
end


local aa_starterpotions = {
	{	probability = 0.70, "aa_repultium"},
	{	probability = 0.40, "aa_hungry_slime"},
	{	probability = 0.30, "aa_icy_inferno"},
	{	probability = 0.20, "aa_arborium"},
	{	probability = 0.10, "aa_compost"},
	{	probability = 0.15, "aa_catalyst"},
	{	probability = 0.01, "aa_unstable_pandorium"},
}

local aa_magicpotions = {
	{"aa_base_potion"},
	{"aa_darkmatter"},
	{"aa_base_potion"},
	{"aa_love"},
	{"aa_pandorium"},
	{"aa_chaotic_pandorium"},
	{"aa_cloning_solution"},
}

local aa_functions = {
	function(outcome, r_value)
		if (PS.CompareTables({PS.LOCAL.month, PS.LOCAL.day}, {4,1}) and AA and r_value <= 10) then return "aa_hitself" end -- 10% chance on April Fools for joke material
	end
}

if AA then
	PS.starterpotions = PS.CombineTables(PS.starterpotions, aa_starterpotions)
	PS.magicpotions = PS.CombineTables(PS.magicpotions, aa_magicpotions)
	--one_in_millions = CombineTables(one_in_millions, aa_one_in_millions)
	--failpotions = CombineTables(failpotions, aa_failpotions)
	PS.functions = PS.CombineTables(PS.functions, aa_functions)
end
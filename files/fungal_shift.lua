---@diagnostic disable: undefined-global

local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")
local FF = ModSettingGet("Hydroxide.FF_ENABLED")
local Terror = ModSettingGet("Hydroxide.TERROR_ENABLED")



function AddMaterialsFrom(addition)
	for i=1,#addition do
		materials_from[#materials_from+1] = addition[i]
	end
end
function AddMaterialsTo(addition)
	for i=1,#addition do
		materials_to[#materials_to+1] = { probability = addition[i], material = i}
	end
end


local CC_from = {
	{
		probability = 	0.1,
		materials 	= 	{"cc_devouring_moss"},
	},
	{
		probability = 1.0,
		materials = { "cc_hydroxide" },
	},
	{
		probability = 0.3,
		materials = { "cc_sparkling_liquid", "cc_slicing_liquid", "cc_glittering_liquid" },
	},
	{
		probability = 0.03,
		materials 	= {"cc_antimatter_gas", "cc_antimatter_liquid" },
	},
	{
		probability = 0.6,
		materials = { "cc_veilium", "magic_liquid_invisibility"},
	},
	{
		probability = 0.9,
		materials = {"cc_methane", "acid_gas", "cc_hydroxide_gas", "poison_gas"},
	},
	{
		probability = 0.7,
		materials 	= {"cc_deceleratium", "cc_heftium", "cc_stillium" },
	},

}

local CC_to = {
	cc_methane = 				1.5,
	cc_hydroxide = 				1.00,
	cc_grease = 				0.9,
	cc_thunder_powder = 		0.8,
	cc_veilium = 				0.8,
	cc_persistine = 			0.7,
	cc_explodePlayer = 			0.7,
	cc_ectospasm = 				0.6,
	cc_uranium = 				0.5,
	cc_nullium = 				0.5,
	cc_dormant_crystal_molten = 0.4,
	cc_dormant_crystal = 		0.4,
	cc_cobalt = 				0.3,
	cc_morphine = 				0.3,
	cc_kindling = 				0.2,
	cc_metamorphine = 			0.2,
	cc_methane_rain = 			0.2,
	cc_blasting_powder = 		0.2,
	cc_sparkling_liquid = 		0.1,
	cc_slicing_liquid = 		0.08,
	cc_glittering_liquid = 		0.08,
	cc_antimatter_powder = 		0.05,
	cc_liberum_magicas = 		0.002,
	cc_alchemy_powder = 		0.004,
	cc_unstable_metamorphine = 	0.005,
	cc_health_tonic = 			0.005,
	cc_devouring_moss = 		0.005,

}


local AA_from = {
	{
		probability = 0.6,
		materials 	= {"aa_potion_gas", "aa_base_potion"},
	},
	{
		probability = 0.3,
		materials 	= {"aa_ash"},
	},
}


local AA_to = {
	aa_base_potion = 0.9,
	aa_potion_gas = 0.7,
	aa_icy_inferno = 0.7,
	aa_static_charge = 0.6,
	aa_love = 0.6,
	aa_repultium = 0.4,
	aa_darkmatter = 0.4,
	aa_hungry_slime = 0.4,
	aa_condensed_gravity = 0.3,
	aa_hitself = 0.3,
	aa_arborium = 0.3,
	aa_cloning_solution = 0.2,
	aa_rice = 0.1,
	aa_meagre_offering = 0.07,
	aa_creeping_slime = 0.05,
}




if CC then
	AddMaterialsFrom(CC_from)
	AddMaterialsTo(CC_to)
end

if AA then
	AddMaterialsFrom(AA_from)
	AddMaterialsTo(AA_to)
end

if MM then
end

if FF then
end

if Terror then
end
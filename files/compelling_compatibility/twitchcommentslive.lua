local tcl_mats = TwitchCommentsLive_Materials

local cc_potions = {
	"cc_glitchium",
	"cc_hydroxide",
	"cc_veilium",
	"cc_sparkling_liquid",
	"cc_slicing_liquid",
	"cc_glittering_liquid",
	"cc_ectospasm",
	"cc_deceleratium",
	"cc_heftium",
	"cc_stillium",
	"cc_metamorphine",
	"cc_unstable_metamorphine",
	"cc_explode_player",
	"cc_metastasizium",
	"cc_nullium",
	"cc_health_tonic",
	"cc_grease",
	"cc_dormant_crystal_molten",
	"cc_antimatter_liquid",
	"cc_persistine",
}

local aa_potions = {
	"aa_hitself",
	"aa_dark_matter",
	"aa_static_charge",
	"aa_repultium",
	"aa_hungry_slime",
	"aa_creeping_slime",
	"aa_hungry_slime_growing",
	"aa_base_potion",
	"aa_arborium",
	"aa_love",
	"aa_meagre_offering",
	"aa_icy_inferno",
	"aa_pandorium",
	"aa_unstable_pandorium",
	"aa_chaotic_pandorium",
	"aa_pop_rocks",
	"aa_condensed_gravity",
	"aa_cloning_solution",
}

if ModSettingGet("Hydroxide.CC_ENABLED") then
	local num = #tcl_mats.potions
	for i, material in ipairs(cc_potions) do
		tcl_mats.potions[num+i] = material
	end
end

if ModSettingGet("Hydroxide.AA_ENABLED") then
	local num = #tcl_mats.potions
	for i, material in ipairs(aa_potions) do
		tcl_mats.potions[num+i] = material
	end

	tcl_mats.blacklist.aa_strange_matter = true --this shit is too laggy atm
end
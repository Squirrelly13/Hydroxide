---@diagnostic disable: undefined-global

local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")
local FF = ModSettingGet("Hydroxide.FF_ENABLED")
local Terror = ModSettingGet("Hydroxide.TERROR_ENABLED")

local table = {}

local CC_effects = {
	{
		id="CC_INGESTION_METHANE",
		ui_name="$status_cc_ingestion_methane",
		ui_description="$status_desc_cc_ingestion_methane",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/methane/effect_methane.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/methane/effect_methane.xml",
		protects_from_fire=false,
		is_harmful=true,
	},
	{
		id="CC_BLINDNESS",
		ui_name="$status_cc_blindness",
		ui_description="$status_desc_cc_blindness",
		ui_icon="data/ui_gfx/status_indicators/blindness.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_blindness/effect_blindness.xml",
		protects_from_fire=false,
	 	is_harmful=true,
	},
	{
		id="CC_TWITCHY",
		ui_name="$status_cc_twitchy",
		ui_description="$statusdesc_twitchy",
		ui_icon="data/ui_gfx/status_indicators/twitchy.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_twitchy/effect_twitchy.xml",
		is_harmful=true,
	},
	{
		id="CC_MOVEMENT_SLOWER_2X",
		ui_name="$status_cc_movement_slower_2x",
		ui_description="$status_desc_cc_movement_slower_2x",
		ui_icon="data/ui_gfx/status_indicators/movement_slower.png",
		effect_entity="data/entities/misc/effect_movement_slower_2x.xml",
		is_harmful=true,
	},
	{
		id="CC_LEVITATION_SLOWER",
		ui_name="$status_cc_levitation_slower",
		ui_description="$status_desc_cc_levitation_slower",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/potion_slowness/effect_levitation_slow.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_slowness/effect_slower_levitation.xml",
		is_harmful=true,
	},
	{
		id="CC_EXPLODING",
		ui_name="$status_cc_exploding",
		ui_description="$status_desc_cc_exploding",
		ui_icon="data/ui_gfx/status_indicators/explosive_shots.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/agitine/effect_explosion.xml", -- I know this is used by other materials, but it fits best here, and it's what I assume the effect was originally intended for -UserK
		is_harmful=false, --it *is* harmful but disabling it entirely is cringe :(, I'm instead going to put a check in the mat itself and make it apply Explosion Immunity or smth instead
	},
	{
		id="CC_METASTASIZIUM",
		ui_name="$status_cc_metastasizium",
		ui_description="$status_desc_cc_metastasizium",
		ui_icon="data/ui_gfx/status_indicators/trail_acid.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/metastasizium/effect_trail_metastasizium.xml",
		is_harmful=true,
	},
	{
		id="CC_NULLIUM",
		ui_name="$status_cc_nullium",
		ui_description="$status_desc_cc_nullium",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/effect_nullified.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/effect_nullification.xml",
		is_harmful=true,
	},
	{
		id="CC_EDIT_WANDS_EVERYWHERE",
		ui_name="$status_cc_edit_wands_everywhere",
		ui_description="$status_desc_cc_edit_wands_everywhere",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/tinker_dust/effect_tinker.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/tinker_dust/effect_tinker.xml",
		is_harmful=false,
	},
	{
		id="CC_INCREASEHP",
		ui_name="$status_cc_increase_hp",
		ui_description="$status_desc_cc_increase_hp",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/increase_max_hp/effect_increasehp.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/increase_max_hp/effect_increasehp.xml",
		is_harmful=false,
	},
	{
		id="CC_MORPHINE",
		ui_name="$status_cc_morphine",
		ui_description="$status_desc_cc_morphine",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/morphine/effect_morphine.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/morphine/effect_morphine.xml",
		is_harmful=true,
	},
	{
		id="CC_ANTIMATTER",
		ui_name="$status_cc_antimatter",
		ui_description="$status_desc_cc_antimatter",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/antimatter/effect_antimatter.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/antimatter/effect_antimatter.xml",
		is_harmful=true,
	},
	{
		id="CC_HYDROXIDE",
		ui_name="$status_cc_hydroxide",
		ui_description="$status_desc_cc_hydroxide",
		ui_icon="",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/hydroxide/effect_hydroxide.xml",
		is_harmful=true,
	},
	{
		id="CC_IRONSKIN",
		ui_name="$status_cc_ironskin",
		ui_description="$status_desc_cc_ironskin",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.xml",
		is_harmful=false,
	},

	{
		id="CC_WARP",
		ui_name="$status_cc_warp",
		ui_description="$status_desc_cc_warp",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/warp/effect_warp.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/warp/warp.xml",
		is_harmful=false,
	},
	{
		id="CC_WARP_SICKNESS",
		ui_name="$status_cc_warp_sickness",
		ui_description="$status_desc_cc_warp_sickness",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/warp/effect_warp_sickness.png",
		effect_entity="data/entities/misc/effect_drunk.xml",
		is_harmful=true,
	},
	{
		id="CC_PARADOX",
		ui_name="$status_cc_paradox",
		ui_description="$status_desc_cc_paradox",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/paradox/effect_paradox.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/paradox/paradox.xml",
		is_harmful=false,
	},

	{
		id="CC_NULL_TRIP",
		ui_name="$status_cc_null_trip_1",
		ui_description="$status_desc_cc_null_trip_1",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.xml",
		is_harmful=false,
	},
	{
		id="CC_NULL_TRIP",
		ui_name="$status_cc_null_trip_2",
		ui_description="$status_desc_cc_null_trip_2",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.xml",
		min_threshold_normalized=0.5,
	},
	{
		id="CC_NULL_TRIP",
		ui_name="$status_cc_null_trip_3",
		ui_description="$status_desc_cc_null_trip_3",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.xml",
		min_threshold_normalized=1.5,
	},
	{
		id="CC_NULL_TRIP",
		ui_name="$status_cc_null_trip_4",
		ui_description="$status_desc_cc_null_trip_4",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_trip.xml",
		min_threshold_normalized=3.0,
	}
}




local AA_effects = {
	{
		id="AA_HIT_SELF",
		ui_name="$status_aa_hit_self",
		ui_description="$status_desc_aa_hit_self",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hit_self/effect_hit_self.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hit_self/hit_self.xml",
	},
	{
		id="AA_COLLAPSE",
		ui_name="$status_aa_collapse",
		ui_description="$status_desc_aa_collapse",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/dark_matter/effect_dark_matter.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/dark_matter/dark_matter.xml",
		add_as_child=true
	},
	{
		id="AA_STATIC_CHARGE",
		ui_name="$status_aa_static_charge",
		ui_description="$status_desc_aa_static_charge",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/static_charge/effect_charged.png",
		protects_from_fire=false,
		effect_entity="data/entities/misc/electricity.xml",
	},
	{
		id="AA_SINKING",
		ui_name="$status_aa_sinking",
		ui_description="$status_desc_aa_sinking",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/hunger.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/sinking.xml",
	},
	{
		id="AA_REPULSION",
		ui_name="$status_aa_repulsion",
		ui_description="$status_desc_aa_repulsion",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/repultium/repulsive.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/repultium/repulsion.xml",
	},
	{
		id="AA_SHRINK",
		ui_name="$status_aa_shrunken",
		ui_description="$status_desc_aa_shrunken",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/shrinkium/shrink.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/shrinkium/shrink.xml",
	}, -- old AA effect that is going to be restored thanks to Archaeopteryx so generously allowing us to steal his code from New Enemies -UserK


	{
		id="AA_HUNGRY_VOMIT",
		ui_name="$status_aa_hungry_vomit",
		ui_description="$status_desc_aa_hungry_vomit",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/slime_vomit.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/vomitslime.xml",
	},
	{
		id="AA_LOVE_POTION",
		ui_name="$status_aa_love_potion",
		ui_description="$status_desc_aa_love_potion",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/love/effect_LOVE.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/love/love.xml",
	},
	{
		id="AA_PATH",
		ui_name="$status_aa_path",
		ui_description="$status_desc_aa_path",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/meager_offering/effect_rice.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/meager_offering/path.xml",
	},
	{
		id="AA_ICEFIRE",
		ui_name="$status_aa_icefire",
		ui_description="$status_desc_aa_icefire",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/icy_inferno/effect_icefire.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/icy_inferno/icefire.xml",
	},
	{
		id="AA_GRAVITY",
		ui_name="$status_aa_gravity",
		ui_description="$status_desc_aa_gravity",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/condensed_gravity/effect_gravity.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/condensed_gravity/gravity.xml",
	},
	{
		id="AA_CLONE",
		ui_name="$status_aa_clone",
		ui_description="$status_desc_aa_clone",
		ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/effect_cloning.png",
		protects_from_fire=false,
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/cloned.xml",
	},
	{
		id="AA_VOMIT_SPELLS",
		ui_name="$status_aa_vomit_spells",
		ui_description="$status_desc_aa_vomit_spells",
		ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/pandorium/pandoriumvomit.xml",
		is_harmful=true,
	},
	{
		id="AA_VOMIT_SPELLS_CHAOTIC",
		ui_name="$status_aa_vomit_spells_chaotic",
		ui_description="$status_desc_aa_vomit_spells_chaotic",
		ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/pandorium/chaotic/chaoticpandoriumvomit.xml",
		is_harmful=true,
	},
	{
		id="AA_VOMIT_SPELLS_UNSTABLE",
		ui_name="$status_aa_vomit_spells_unstable",
		ui_description="$status_desc_aa_vomit_spells_unstable",
		ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
		effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/pandorium/unstable/unstablepandoriumvomit.xml",
		is_harmful=true,
	}

--[[
table.insert(status_effects, {
	id="POLYMORPH2",
	ui_name="polymorph test",
	ui_description="you have polymorphed",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/cloned.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/polymorph_test.xml",
});
]]-- not sure what this was used for, possibly used to test cloning, might be worth reading into in the future tho -UserK

--if(ModSettingGet(omega_glue)) then
--table.insert(status_effects, {
--	id="GLUED",
--	ui_name="Glued",
--	ui_description="you feel extremely sticky",
--	ui_icon="mods/Hydroxide/files/gfx/ui/glued.png",
--	protects_from_fire=false,
--	effect_entity="mods/Hydroxide/files/entities/effects/custom_glue/glue_shot.xml",
--});
--end


}




local MM_effects = {

}




local FF_effects = {

}




local Terror_effects = {
	{
		id="TERROR_TELEPORT",
		ui_name="$status_terror_teleport",
		ui_description="$status_desc_terror_teleport",
		ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.png",
		effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.xml",
		is_harmful=true,
	},
}









function AddEffects(addition)
	for i=1,#addition do
		status_effects[#status_effects+1] = addition[i]
	end
end

if CC then
	AddEffects(CC_effects)
end

if AA then
	AddEffects(AA_effects)
end

if MM then

end

if FF then

end

if Terror then
	AddEffects(Terror_effects)
end
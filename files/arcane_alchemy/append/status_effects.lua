table.insert(status_effects, {
	id="AA_HIT_SELF",
	ui_name="$status_aa_hit_self",
	ui_description="$status_desc_aa_hit_self",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hit_self/effect_hit_self.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hit_self/hit_self.xml",
});

table.insert(status_effects, {
	id="AA_COLLAPSE",
	ui_name="$status_aa_collapse",
	ui_description="$status_desc_aa_collapse",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/dark_matter/effect_dark_matter.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/dark_matter/dark_matter.xml",
	add_as_child=true
});

table.insert(status_effects, {
	id="aa_static_charge",
	ui_name="$status_aa_static_charge",
	ui_description="$status_desc_aa_static_charge",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/static_charge/effect_charged.png",
	protects_from_fire=false,
	effect_entity="data/entities/misc/electricity.xml",
});

table.insert(status_effects, {
	id="AA_SINKING",
	ui_name="$status_aa_sinking",
	ui_description="$status_desc_aa_sinking",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/hunger.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/sinking.xml",
});

table.insert(status_effects, {
	id="AA_REPULSION",
	ui_name="$status_aa_repulsion",
	ui_description="$status_desc_aa_repulsion",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/repultium/repulsive.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/repultium/repulsion.xml",
});


table.insert(status_effects, {
	id="AA_SHRINK",
	ui_name="Shrunken",
	ui_description="You have been shrunken",
	ui_icon="mods/Hydroxide/files/gfx/ui/shrink.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/shrink.xml",
}); -- old AA effect that is being restored thanks to Archaeopteryx so generously allowing us to steal his code from New Enemies -UserK

table.insert(status_effects, {
	id="AA_HUNGRY_VOMIT",
	ui_name="$status_aa_hungry_vomit",
	ui_description="$status_desc_aa_hungry_vomit",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/slime_vomit.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/hungry_slime/vomitslime.xml",
});
table.insert(status_effects, {
	id="AA_LOVE_POTION",
	ui_name="$status_aa_love_potion",
	ui_description="$status_desc_aa_love_potion",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/love/effect_LOVE.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/love/love.xml",
});

table.insert(status_effects, {
	id="AA_PATH",
	ui_name="$status_aa_path",
	ui_description="$status_desc_aa_path",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/meager_offering/effect_rice.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/meager_offering/path.xml",
});

table.insert(status_effects, {
	id="AA_ICEFIRE",
	ui_name="$status_aa_icefire",
	ui_description="$status_desc_aa_icefire",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/icy_inferno/effect_icefire.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/icy_inferno/icefire.xml",
});

table.insert(status_effects, {
	id="AA_GRAVITY",
	ui_name="$status_aa_gravity",
	ui_description="$status_desc_aa_gravity",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/condensed_gravity/effect_gravity.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/condensed_gravity/gravity.xml",
});

table.insert(status_effects, {
	id="AA_CLONE",
	ui_name="$status_aa_clone",
	ui_description="$status_desc_aa_clone",
	ui_icon="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/effect_cloning.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/cloned.xml",
});

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



table.insert(status_effects, {
	id="AA_VOMIT_SPELLS",
	ui_name="$status_aa_vomit_spells",
	ui_description="$status_desc_aa_vomit_spells",
	ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/pandorium/unstable/pandoriumvomit.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="AA_VOMIT_SPELLS_UNSTABLE",
	ui_name="$status_aa_vomit_spells_unstable",
	ui_description="$status_desc_aa_vomit_spells_unstable",
	ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
	effect_entity="mods/Hydroxide/files/arcane_alchemy/materials/pandorium/unstable/unstablepandoriumvomit.xml",
	is_harmful=true,
});


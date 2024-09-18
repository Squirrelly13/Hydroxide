---@diagnostic disable: undefined-global


table.insert(status_effects, {
	id="CC_INGESTION_METHANE",
	ui_name="$status_cc_ingestion_methane",
	ui_description="$status_desc_cc_ingestion_methane",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/methane/effect_methane.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/methane/effect_methane.xml",
	protects_from_fire=false,
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_BLINDNESS",
	ui_name="$status_cc_blindness",
	ui_description="$status_desc_cc_blindness",
	ui_icon="data/ui_gfx/status_indicators/blindness.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_blindness/effect_blindness.xml",
	protects_from_fire=false,
 	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_TWITCHY",
	ui_name="$status_cc_twitchy",
	ui_description="$statusdesc_twitchy",
	ui_icon="data/ui_gfx/status_indicators/twitchy.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_twitchy/effect_twitchy.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_MOVEMENT_SLOWER_2X",
	ui_name="$status_cc_movement_slower_2x",
	ui_description="$status_desc_cc_movement_slower_2x",
	ui_icon="data/ui_gfx/status_indicators/movement_slower.png",
	effect_entity="data/entities/misc/effect_movement_slower_2x.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_LEVITATION_SLOWER",
	ui_name="$status_cc_levitation_slower",
	ui_description="$status_desc_cc_levitation_slower",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/potion_slowness/effect_levitation_slow.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/potion_slowness/effect_slower_levitation.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_EXPLODING",
	ui_name="$status_cc_exploding",
	ui_description="$status_desc_cc_exploding",
	ui_icon="data/ui_gfx/status_indicators/explosive_shots.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/agitine/effect_explosion.xml", -- I know this is used by other materials, but it fits best here, and it's what I assume the effect was originally intended for -UserK
	is_harmful=false, --it *is* harmful but disabling it entirely is cringe :(, I'm instead going to put a check in the mat itself and make it apply Explosion Immunity or smth instead
}); 

table.insert(status_effects, {
	id="CC_METASTASIZIUM",
	ui_name="$status_cc_metastasizium",
	ui_description="$status_desc_cc_metastasizium",
	ui_icon="data/ui_gfx/status_indicators/trail_acid.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/metastasizium/effect_trail_metastasizium.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_NULLIUM",
	ui_name="$status_cc_nullium",
	ui_description="$status_desc_cc_nullium",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/effect_nullified.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/effect_nullification.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_EDIT_WANDS_EVERYWHERE",
	ui_name="$status_cc_edit_wands_everywhere",
	ui_description="$status_desc_cc_edit_wands_everywhere",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/tinker_dust/effect_tinker.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/tinker_dust/effect_tinker.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="CC_INCREASEHP",
	ui_name="$status_cc_increase_hp",
	ui_description="$status_desc_cc_increase_hp",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/increase_max_hp/effect_increasehp.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/increase_max_hp/effect_increasehp.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="CC_MORPHINE",
	ui_name="$status_cc_morphine",
	ui_description="$status_desc_cc_morphine",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/morphine/effect_morphine.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/morphine/effect_morphine.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="CC_ANTIMATTER",
	ui_name="$status_cc_antimatter",
	ui_description="$status_desc_cc_antimatter",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/antimatter/effect_antimatter.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/antimatter/effect_antimatter.xml",
	is_harmful=true,
});
	
table.insert(status_effects, {
	id="CC_HYDROXIDE",
	ui_name="$status_cc_hydroxide",
	ui_description="$status_desc_cc_hydroxide",
	ui_icon="",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/hydroxide/effect_hydroxide.xml",
	is_harmful=true,
});



table.insert(status_effects, {
	id="CC_IRONSKIN",
	ui_name="$status_cc_ironskin",
	ui_description="$status_desc_cc_ironskin",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/metals/effect_ironskin.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="CC_WARP",
	ui_name="$status_cc_warp",
	ui_description="$status_desc_cc_warp",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/warp/effect_warp.png",
	effect_entity="mods/Hydroxide/files/chemical_curiosities/materials/warp/warp.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="CC_WARP_SICKNESS",
	ui_name="$status_cc_warp_sickness",
	ui_description="$status_desc_cc_warp_sickness",
	ui_icon="mods/Hydroxide/files/chemical_curiosities/materials/warp/effect_warp_sickness.png",
	effect_entity="data/entities/misc/effect_drunk.xml",
	is_harmful=true,
});
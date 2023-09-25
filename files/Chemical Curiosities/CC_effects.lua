

table.insert(status_effects, {
	id="INGESTION_METHANE",
	ui_name="Methane Poisioning",
	ui_description="Everything is hazy.",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/methane/effect_methane.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/methane/effect_methane.xml",
	protects_from_fire=false,
	is_harmful=true,
});

table.insert(status_effects, {
	id="BLINDNESS",
	ui_name="Blinded",
	ui_description="Your eyes don't seem to be helping much.",
	ui_icon="data/ui_gfx/status_indicators/blindness.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/potionBlindness/effect_blindness.xml",
	protects_from_fire=false,
 	is_harmful=true,
});

table.insert(status_effects, {
	id="TWITCHY",
	ui_name="Twitchy",
	ui_description="$statusdesc_twitchy",
	ui_icon="data/ui_gfx/status_indicators/twitchy.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/potionTwitchy/effect_twitchy.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="MOVEMENT_SLOWER_2X",
	ui_name="Slowed",
	ui_description="You feel sluggish",
	ui_icon="data/ui_gfx/status_indicators/movement_slower.png",
	effect_entity="data/entities/misc/effect_movement_slower_2x.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="LEVITATION_SLOWER",
	ui_name="Heavy",
	ui_description="It feels as if your bones are made of lead",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/potionSlowness/effect_levitation_slow.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/potionSlowness/effect_slower_levitation.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="EXPLODING",
	ui_name="Combusting",
	ui_description="BOOM!!!",
	ui_icon="data/ui_gfx/status_indicators/explosive_shots.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/explodePlayer/effect_explosion.xml",
	is_harmful=true,
}); -- I know this is used by other materials, but it fits best here, and it's what I assume the effect was originally intended for -UserK

table.insert(status_effects, {
	id="METASTASIZIUM",
	ui_name="Infected",
	ui_description="It wants to spread",
	ui_icon="data/ui_gfx/status_indicators/trail_acid.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/metastasizium/effect_trail_metastasizium.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="NULLIUM",
	ui_name="Nullified",
	ui_description="Your mana is being drained.",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/magic_liquid_antimagic/effect_nullified.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/magic_liquid_antimagic/effect_nullification.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="EDIT_WANDS_EVERYWHERE",
	ui_name="Tinker Everywhere",
	ui_description="Were the Gods always singing such a lovely tune?",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/tinkerDust/effect_tinker.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/tinkerDust/effect_tinker.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="INCREASEHP",
	ui_name="Health Generation",
	ui_description="Your maximum health is slowly increasing.",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/increaseMaxHP/effect_increasehp.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/increaseMaxHP/effect_increasehp.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="MORPHINE",
	ui_name="Painkillers",
	ui_description="You feel unstoppable.",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/morphine/effect_morphine.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/morphine/effect_morphine.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="ANTIMATTER",
	ui_name="Annihilation",
	ui_description="Every fiber of your being is being torn apart!",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/antimatter/effect_antimatter.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/antimatter/effect_antimatter.xml",
	is_harmful=true,
});
	
table.insert(status_effects, {
	id="HYDROXIDE",
	ui_name="",
	ui_description="you're dying lmao",
	ui_icon="",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/hydroxide/effect_hydroxide.xml",
	is_harmful=true,
});



table.insert(status_effects, {
	id="IRONSKIN",
	ui_name="Resistance",
	ui_description="You recieve less damage",
	ui_icon="mods/Hydroxide/files/Chemical Curiosities/materials/metalStuff/effect_ironskin.png",
	effect_entity="mods/Hydroxide/files/Chemical Curiosities/materials/metalStuff/effect_ironskin.xml",
	is_harmful=false,
});
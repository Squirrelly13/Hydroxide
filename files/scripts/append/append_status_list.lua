table.insert(status_effects, {
	id="AA_HIT_SELF",
	ui_name="Angry Limb",
	ui_description="Stop hitting yourself",
	ui_icon="mods/Hydroxide/files/gfx/ui/hit_self.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/hit_self.xml",
});

table.insert(status_effects, {
	id="AA_COLLAPSE",
	ui_name="Collapsing",
	ui_description="You are collapsing in on yourself",
	ui_icon="mods/Hydroxide/files/gfx/ui/dark_matter.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/dark_matter.xml",
	add_as_child=true
});

table.insert(status_effects, {
	id="AA_STATIC_CHARGE",
	ui_name="Static charge",
	ui_description="You are electrically charged",
	ui_icon="mods/Hydroxide/files/gfx/ui/charged.png",
	protects_from_fire=false,
	effect_entity="data/entities/misc/electricity.xml",
});

table.insert(status_effects, {
	id="AA_SINKING",
	ui_name="Sinking",
	ui_description="You are being grabbed",
	ui_icon="mods/Hydroxide/files/gfx/ui/hunger.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/sinking.xml",
});

table.insert(status_effects, {
	id="AA_REPULSION",
	ui_name="Repulsion",
	ui_description="A force is throwing you",
	ui_icon="mods/Hydroxide/files/gfx/ui/repulsive.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/repulsion.xml",
});

table.insert(status_effects, {
	id="AA_SHRINK",
	ui_name="Shrunken",
	ui_description="You have been shrunken",
	ui_icon="mods/Hydroxide/files/gfx/ui/shrink.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/shrink.xml",
});

table.insert(status_effects, {
	id="AA_HUNGRY_VOMIT",
	ui_name="Slime vomit",
	ui_description="You feel it crawling back up",
	ui_icon="mods/Hydroxide/files/gfx/ui/crawl.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/vomitslime.xml",
});
table.insert(status_effects, {
	id="LOVE_POTION",
	ui_name="LOVE ME",
	ui_description="PLEASE DONT GO",
	ui_icon="mods/Hydroxide/files/gfx/ui/LOVE.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/love.xml",
});

table.insert(status_effects, {
	id="PATH",
	ui_name="infinite wealth?",
	ui_description="Nearby liquids,gasses,and other objects become rice",
	ui_icon="mods/Hydroxide/files/gfx/ui/rice.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/path.xml",
});

table.insert(status_effects, {
	id="ICEFIRE",
	ui_name="Frozen inferno",
	ui_description="Nearby fire burns into frozen vapour",
	ui_icon="mods/Hydroxide/files/gfx/ui/icefire.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/icefire.xml",
});

table.insert(status_effects, {
	id="GRAVITY",
	ui_name="Gravitational anomaly",
	ui_description="Nearby objects fly towards you",
	ui_icon="mods/Hydroxide/files/gfx/ui/gravity.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/gravity.xml",
});

table.insert(status_effects, {
	id="CLONE",
	ui_name="cloned",
	ui_description="you are being cloned!",
	ui_icon="mods/Hydroxide/files/gfx/ui/cloned.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/cloned.xml",
});

table.insert(status_effects, {
	id="POLYMORPH2",
	ui_name="polymorph test",
	ui_description="you have polymorphed",
	ui_icon="mods/Hydroxide/files/gfx/ui/cloned.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/polymorph_test.xml",
});

--if(ModSettingGet(omega_glue) == "on") then
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
	id="INGESTION_METHANE",
	ui_name="Methane Poisioning",
	ui_description="You are being affected by an invisible threat",
	ui_icon="data/ui_gfx/status_indicators/drunk.png",
	effect_entity="data/entities/misc/effect_methane_poisoning.xml",
	min_threshold_normalized="0.0",
	protects_from_fire=false,
	is_harmful=true,
});

table.insert(status_effects, {
	id="BLINDNESS",
	ui_name="Blinded",
	ui_description="Your eyes don't seem to be helping much.",
	ui_icon="data/ui_gfx/status_indicators/blindness.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_blindness.xml",
	protects_from_fire=false,
 	is_harmful=true,
});

table.insert(status_effects, {
	id="TWITCHY",
	ui_name="Twitchy",
	ui_description="$statusdesc_twitchy",
	ui_icon="data/ui_gfx/status_indicators/twitchy.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_twitchy.xml",
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
	ui_icon="mods/Hydroxide/files/gfx/ui/levitation_slow.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_slower_levitation.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="EXPLODING",
	ui_name="Combusting",
	ui_description="BOOM!!!",
	ui_icon="data/ui_gfx/status_indicators/explosive_shots.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_explosion.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="METASTASIZIUM",
	ui_name="Infected",
	ui_description="It wants to spread",
	ui_icon="data/ui_gfx/status_indicators/trail_acid.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_trail_metastasizium.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="NULLIUM",
	ui_name="Nullified",
	ui_description="Your mana is being drained.",
	ui_icon="mods/Hydroxide/files/gfx/ui/nullified.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_nullification.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="EDIT_WANDS_EVERYWHERE",
	ui_name="Tinker Everywhere",
	ui_description="Were the Gods always singing such a lovely tune?",
	ui_icon="mods/Hydroxide/files/gfx/ui/tinker.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_tinker.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="INCREASEHP",
	ui_name="Health Generation",
	ui_description="Your maximum health is slowly increasing.",
	ui_icon="mods/Hydroxide/files/gfx/ui/increasehp.png",
	effect_entity="mods/Hydroxide/files/entities/misc/effect_increasehp.xml",
	is_harmful=false,
});

table.insert(status_effects, {
	id="MORPHINE",
	ui_name="Painkillers",
	ui_description="You feel unstoppable.",
	ui_icon="mods/Hydroxide/files/gfx/ui/morphine.png",
	effect_entity="mods/Hydroxide/files/entities/effects/morphine.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="ANTIMATTER",
	ui_name="Annihilation",
	ui_description="Every fiber of your being is being torn apart!",
	ui_icon="mods/Hydroxide/files/gfx/ui/antimatter.png",
	effect_entity="mods/Hydroxide/files/entities/effects/antimatter.xml",
	is_harmful=true,
});
	
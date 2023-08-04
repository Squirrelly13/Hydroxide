table.insert(status_effects, {
	id="AA_HIT_SELF",
	ui_name="Angry Limb",
	ui_description="Stop hitting yourself",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_HITSELF/effect_hit_self.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_HITSELF/hit_self.xml",
});

table.insert(status_effects, {
	id="AA_COLLAPSE",
	ui_name="Collapsing",
	ui_description="You are collapsing in on yourself",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_DARKMATTER/effect_dark_matter.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_DARKMATTER/dark_matter.xml",
	add_as_child=true
});

table.insert(status_effects, {
	id="AA_STATIC_CHARGE",
	ui_name="Static charge",
	ui_description="You are electrically charged",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_STATIC_CHARGE/effect_charged.png",
	protects_from_fire=false,
	effect_entity="data/entities/misc/electricity.xml",
});

table.insert(status_effects, {
	id="AA_SINKING",
	ui_name="Sinking",
	ui_description="You are being grabbed",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_HUNGRY_SLIME/hunger.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_HUNGRY_SLIME/sinking.xml",
});

table.insert(status_effects, {
	id="AA_REPULSION",
	ui_name="Repulsion",
	ui_description="A mysterious force struggling to be rid of you",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_REPULTIUM/repulsive.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_REPULTIUM/repulsion.xml",
});

--[[
table.insert(status_effects, {
	id="AA_SHRINK",
	ui_name="Shrunken",
	ui_description="You have been shrunken",
	ui_icon="mods/Hydroxide/files/gfx/ui/shrink.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/shrink.xml",
});
]]-- old AA effect, probably not worth fixing up but I'll leave it here for now -UserK

table.insert(status_effects, {
	id="AA_HUNGRY_VOMIT",
	ui_name="Slime vomit",
	ui_description="You feel it crawling back up",
	ui_icon="mods/Hydroxide/files/gfx/ui/crawl.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_HUNGRY_SLIME/vomitslime.xml",
});
table.insert(status_effects, {
	id="LOVE_POTION",
	ui_name="LOVE ME",
	ui_description="PLEASE DONT GO",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_LOVE/effect_LOVE.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_LOVE/love.xml",
});

table.insert(status_effects, {
	id="PATH",
	ui_name="infinite wealth?",
	ui_description="Nearby liquids,gasses,and other objects become rice",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_PATH/effect_rice.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_PATH/path.xml",
});

table.insert(status_effects, {
	id="ICEFIRE",
	ui_name="Frozen inferno",
	ui_description="Nearby fire burns into frozen vapour",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_ICEFIRE/effect_icefire.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_ICEFIRE/icefire.xml",
});

table.insert(status_effects, {
	id="GRAVITY",
	ui_name="Gravitational anomaly",
	ui_description="Nearby objects fly towards you",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_GRAVLIQUID/effect_gravity.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_GRAVLIQUID/gravity.xml",
});

table.insert(status_effects, {
	id="CLONE",
	ui_name="cloned",
	ui_description="you are being cloned!",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_CLONE/effect_cloning.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_CLONE/cloned.xml",
});

--[[
table.insert(status_effects, {
	id="POLYMORPH2",
	ui_name="polymorph test",
	ui_description="you have polymorphed",
	ui_icon="mods/Hydroxide/files/Arcane Alchemy/materials/AA_CLONE/cloned.png",
	protects_from_fire=false,
	effect_entity="mods/Hydroxide/files/entities/effects/polymorph_test.xml",
});
]]-- not sure what this was used for, possibly used to test cloning, might be worth reading into in the future tho -UserK

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
	id="VOMIT_SPELLS",
	ui_name="Food Poisoning",
	ui_description="This was a terrible snack",
	ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_LIQUID_SPELL/pandoriumvomit.xml",
	is_harmful=true,
});

table.insert(status_effects, {
	id="VOMIT_SPELLS_UNSTABLE",
	ui_name="Food Poisoning",
	ui_description="This was a terrible meal",
	ui_icon="data/ui_gfx/status_indicators/food_poisoning.png",
	effect_entity="mods/Hydroxide/files/Arcane Alchemy/materials/AA_LIQUID_SPELL/unstablepandoriumvomit.xml",
	is_harmful=true,
});


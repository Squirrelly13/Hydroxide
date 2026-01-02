---@diagnostic disable: undefined-global

local cc_glimmers = {
    {
        spellid_suffix = "HYDROXIDE",
        name = "$action_name_cc_glimmer_hydroxide",
        desc = "$action_desc_cc_glimmer_hydroxide",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_hydroxide.png",
        materials = {"cc_hydroxide"},
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        sort_after = 8.11,
        trail_mods = {
            trail_gap = "0.5",
        },
    },
    {
        spellid_suffix = "SLICING_LIQUID",
        name = "$action_name_cc_glimmer_slicing_liquid",
        desc = "$action_desc_cc_glimmer_slicing_liquid",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_slicing_liquid.png",
        materials = {"cc_slicing_liquid"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.12,
    },
    {
        spellid_suffix = "GLITTERING_LIQUID",
        name = "$action_name_cc_glimmer_glittering_liquid",
        desc = "$action_desc_cc_glimmer_glittering_liquid",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_glittering_liquid2.png",
        materials = {"cc_glittering_liquid"},
        cast_delay = 15,
        spawn_tiers = "4,5,6",
        sort_after = 8.13,
    },
    {
        spellid_suffix = "EXPLODE_PLAYER",
        name = "$action_name_cc_glimmer_explode_player",
        desc = "$action_desc_cc_glimmer_explode_player",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_agitine.png",
        materials = {"cc_explode_player"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.14,
    },
    {
        spellid_suffix = "NULLIUM",
        name = "$action_name_cc_glimmer_nullium",
        desc = "$action_desc_cc_glimmer_nullium",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_nullium.png",
        materials = {"cc_nullium"},
        cast_delay = 15,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.3,
        is_rare = true,
    },
    {
        spellid_suffix = "DORMANT_CRYSTAL",
        name = "$action_name_cc_glimmer_dormant_crystal",
        desc = "$action_desc_cc_glimmer_dormant_crystal",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_dormant_crystal1.png",
        materials = {"cc_dormant_crystal"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 7.3,
    },
    {
        spellid_suffix = "URANIUM",
        name = "$action_name_cc_glimmer_uranium",
        desc = "$action_desc_cc_glimmer_uranium",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_uranium.png",
        materials = {"cc_uranium"},
        cast_delay = 8,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
    {
        spellid_suffix = "ANTIMATTER",
        name = "$action_name_cc_glimmer_antimatter_liquid",
        desc = "$action_desc_cc_glimmer_antimatter_liquid",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_antimatter.png",
        materials = {"cc_antimatter_liquid"},
        cast_delay = 9,
        spawn_tiers = "4,5,6",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
}

local aa_glimmers = {

}

local mm_glimmers = {

}



for _,entry in ipairs(ModSettingGet("Hydroxide.CC_ENABLED") and cc_glimmers or {}) do
    entry.mod_prefix = "CC"
    table.insert(glimmer_data, entry)
end
for _,entry in ipairs(ModSettingGet("Hydroxide.CC_ENABLED") and aa_glimmers or {}) do
    entry.mod_prefix = "AA"
    table.insert(glimmer_data, entry)
end
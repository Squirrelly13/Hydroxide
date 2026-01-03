---@diagnostic disable: undefined-global

local cc_glimmers = {
    {
        spellid_suffix = "HYDROXIDE",
        name = "$action_name_cc_glimmer_hydroxide",
        desc = "$action_desc_cc_glimmer_hydroxide",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/hydroxide.png",
        materials = {"cc_hydroxide"},
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        trail_mods = {
            trail_gap = "0.5",
        },
    },
    {
        spellid_suffix = "SLICING_LIQUID",
        name = "$action_name_cc_glimmer_slicing_liquid",
        desc = "$action_desc_cc_glimmer_slicing_liquid",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/slicing_liquid.png",
        materials = {"cc_slicing_liquid"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
    },
    {
        spellid_suffix = "GLITTERING_LIQUID",
        name = "$action_name_cc_glimmer_glittering_liquid",
        desc = "$action_desc_cc_glimmer_glittering_liquid",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/glittering_liquid2.png",
        materials = {"cc_glittering_liquid"},
        cast_delay = 15,
        spawn_tiers = "4,5,6",
    },
    {
        spellid_suffix = "EXPLODE_PLAYER",
        name = "$action_name_cc_glimmer_explode_player",
        desc = "$action_desc_cc_glimmer_explode_player",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/agitine.png",
        materials = {"cc_explode_player"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
    },
    {
        spellid_suffix = "NULLIUM",
        name = "$action_name_cc_glimmer_nullium",
        desc = "$action_desc_cc_glimmer_nullium",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/nullium.png",
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
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/dormant_crystal1.png",
        materials = {"cc_dormant_crystal"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 7.3,
    },
    {
        spellid_suffix = "URANIUM",
        name = "$action_name_cc_glimmer_uranium",
        desc = "$action_desc_cc_glimmer_uranium",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/uranium.png",
        materials = {"cc_uranium"},
        cast_delay = 8,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
    {
        spellid_suffix = "ANTIMATTER",
        name = "$action_name_cc_glimmer_antimatter",
        desc = "$action_desc_cc_glimmer_antimatter",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/CC/antimatter.png",
        materials = {"cc_antimatter_liquid"},
        cast_delay = 9,
        spawn_tiers = "4,5,6",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
}

local aa_glimmers = {
    {
        spellid_suffix = "CHAOTIC_PANDORIUM",
        name = "$action_name_aa_glimmer_chaotic_pandorium",
        desc = "$action_desc_aa_glimmer_chaotic_pandorium",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/AA/chaotic_pandorium.png",
        materials = {"aa_chaotic_pandorium"},
        cast_delay = 9,
        spawn_tiers = "10",
    },
    {
        spellid_suffix = "CONDENSED_GRAVITY",
        name = "$action_name_aa_glimmer_condensed_gravity",
        desc = "$action_desc_aa_glimmer_condensed_gravity",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/AA/condensed_gravity.png",
        materials = {"aa_condensed_gravity"},
        cast_delay = 9,
        spawn_tiers = "4,5,6",
    },
    {
        spellid_suffix = "DARK_MATTER",
        name = "$action_name_aa_glimmer_dark_matter",
        desc = "$action_desc_aa_glimmer_dark_matter",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/AA/dark_matter.png",
        materials = {"aa_dark_matter"},
        cast_delay = 9,
        spawn_tiers = "4,6",
    },
    {
        spellid_suffix = "STATIC_CHARGE",
        name = "$action_name_aa_glimmer_static_charge",
        desc = "$action_desc_aa_glimmer_static_charge",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/AA/static_charge.png",
        materials = {"aa_static_charge"},
        cast_delay = 9,
        spawn_tiers = "1,2,3,4",
    },
}


local sort_pos = 8.11
for _,entry in ipairs(ModSettingGet("Hydroxide.CC_ENABLED") and aa_glimmers or {}) do
    entry.mod_prefix = "AA"
    entry.sort_after = entry.sort_after or sort_pos
    table.insert(glimmer_data, entry)
    sort_pos = sort_pos + .001
end
for _,entry in ipairs(ModSettingGet("Hydroxide.CC_ENABLED") and cc_glimmers or {}) do
    entry.mod_prefix = "CC"
    entry.sort_after = entry.sort_after or sort_pos
    table.insert(glimmer_data, entry)
    sort_pos = sort_pos + .001
end
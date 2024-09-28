---@diagnostic disable: undefined-global

local cc_glimmers = {
    {
        name = "Hydroxide",
        desc = "Gives a projectile a corrosive sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_hydroxide.png",
        materials = {"cc_hydroxide"},
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        sort_after = 8.11,
        trail_mods = {
            trail_gap = "0.5",
        },
        mod_prefix = "CC"
    },
    {
        name = "Slicing Liquid",
        desc = "Gives a projectile a silvery sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_slicing_liquid.png",
        materials = {"cc_slicing_liquid"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.12,
        mod_prefix = "CC"
    },
    {
        name = "Glittering Liquid",
        desc = "Gives a projectile a glittering sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_glittering_liquid2.png",
        materials = {"cc_glittering_liquid"},
        cast_delay = 15,
        spawn_tiers = "4,5,6",
        sort_after = 8.13,
        mod_prefix = "CC"
    },
    {
        name = "Agitine",
        desc = "Gives a projectile a volatile sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_agitine.png",
        materials = {"cc_explodePlayer"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.14,
        mod_prefix = "CC"
    },
    {
        name = "Nullium",
        desc = "Gives a projectile a regenerative sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_nullium.png",
        materials = {"cc_nullium"},
        cast_delay = 15,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.3,
        is_rare = true,
        mod_prefix = "CC"
    },
    {
        name = "Dormant Crystal",
        desc = "Gives a projectile a regenerative sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_dormant_crystal1.png",
        materials = {"cc_dormant_crystal"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 7.3,
        mod_prefix = "CC"
    },
    {
        name = "Uranium",
        desc = "Gives a projectile a regenerative sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_uranium.png",
        materials = {"cc_uranium"},
        cast_delay = 8,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
        mod_prefix = "CC"
    },
    {
        name = "Anti-Matter",
        desc = "Gives a projectile a regenerative sparkly trail",
        image = "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/icons/colour_anti-matter.png",
        materials = {"cc_antimatter_liquid"},
        cast_delay = 9,
        spawn_tiers = "4,5,6",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
        mod_prefix = "CC"
    },
}

local aa_glimmers = {

}

local mm_glimmers = {

}



for _,entry in ipairs(cc_glimmers) do
    table.insert(glimmer_data, entry)
end
for _,entry in ipairs(aa_glimmers) do
    table.insert(glimmer_data, entry)
end
for _,entry in ipairs(mm_glimmers) do
    table.insert(glimmer_data, entry)
end
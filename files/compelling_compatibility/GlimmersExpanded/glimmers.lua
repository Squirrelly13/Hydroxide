---@diagnostic disable: undefined-global
-- addGlimmer("Hydroxide", "Gives a projectile a caustic sparkly trail", {"cc_hydroxide"}, nil, 15, "2,3,4,5,6", 4.1)
-- addGlimmer("Slicing Liquid", "Gives a projectile a sickeningly sparkly trail", {"cc_slicing_liquid"}, nil, nil, nil, 4.21)
-- addGlimmer("Glittering Liquid", "Gives a projectile a sickeningly sparkly trail", {"cc_glittering_liquid"}, nil, nil, nil, 4.21)
-- addGlimmer("Agitine", "Gives a projectile a sickeningly sparkly trail", {"cc_explodePlayer"}, nil, nil, nil, 4.21)
-- addGlimmer("Nullium", "Gives a projectile a sickeningly sparkly trail", {"cc_nullium"}, nil, nil, nil, 4.21)
-- addGlimmer("Dormant Crystal", "Gives a projectile a sickeningly sparkly trail", {"cc_dormant_crystal"}, nil, nil, nil, 4.21)
-- addGlimmer("Uranium", "Gives a projectile a sickeningly sparkly trail", {"cc_uranium"}, nil, nil, nil, 4.21)
-- addGlimmer("Anti-Matter", "Gives a projectile a sickeningly sparkly trail", {"cc_antimatter_powder"}, nil, nil, nil, 4.21)
-- addGlimmer("Condensed Gravity", "Gives a projectile a sickeningly sparkly trail", {"aa_condensed_gravity"}, nil, nil, nil, 4.21)
-- addGlimmer("Cloning Solution", "Gives a projectile a sickeningly sparkly trail", {"aa_cloning_solution"}, nil, nil, nil, 4.21)
-- addGlimmer("Bingus", "Gives a projectile a sickeningly sparkly trail", {"mm_bingus"}, nil, nil, nil, 4.21)

cc_glimmers = {
    {
        name = "Hydroxide",
        desc = "Gives a projectile a corrosive sparkly trail",
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
        materials = {"cc_slicing_liquid"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.12,
        mod_prefix = "CC"
    },
    {
        name = "Glittering Liquid",
        desc = "Gives a projectile a glittering sparkly trail",
        materials = {"cc_glittering_liquid"},
        cast_delay = 15,
        spawn_tiers = "4,5,6",
        sort_after = 8.13,
        mod_prefix = "CC"
    },
    {
        name = "Agitine",
        desc = "Gives a projectile a volatile sparkly trail",
        materials = {"cc_explodePlayer"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 8.14,
        mod_prefix = "CC"
    },
    {
        name = "Nullium",
        desc = "Gives a projectile a regenerative sparkly trail",
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
        materials = {"cc_dormant_crystal"},
        cast_delay = 15,
        spawn_tiers = "3,4,5,6",
        sort_after = 7.3,
        mod_prefix = "CC"
    },
    {
        name = "Uranium",
        desc = "Gives a projectile a regenerative sparkly trail",
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
        materials = {"cc_antimatter_liquid"},
        cast_delay = 9,
        spawn_tiers = "4,5,6",
        sort_after = 7.3,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
        mod_prefix = "CC"
    },
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
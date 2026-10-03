local owner = EntityGetRootEntity(GetUpdatedEntityID())
EntityAddComponent2(owner, "LuaComponent", {
    limit_all_callbacks = true,
    limit_to_every_n_frame = 12,
    limit_how_many_times_per_frame = 1,
    script_damage_received = "mods/Hydroxide/files/chemical_curiosities/materials/slicing_liquid/sharp_reflexes/damage_received.lua"
})

local dmc = EntityGetFirstComponentIncludingDisabled(owner, "DamageModelComponent")
if not dmc then return end

ComponentObjectSetValue2(dmc, "damage_multipliers", "slice",
    ComponentObjectGetValue2(dmc, "damage_multipliers", "slice")-.3
)
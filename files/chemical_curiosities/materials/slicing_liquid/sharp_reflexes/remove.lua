local owner = EntityGetRootEntity(GetUpdatedEntityID())
for _,luacomp in ipairs(EntityGetComponent(owner, "LuaComponent") or {}) do
    if ComponentGetValue2(luacomp, "script_damage_received") == "mods/Hydroxide/files/chemical_curiosities/materials/slicing_liquid/sharp_reflexes/remove.lua" then
        EntityRemoveComponent(owner, luacomp) break
    end
end

local dmc = EntityGetFirstComponentIncludingDisabled(owner, "DamageModelComponent")
if not dmc then return end

ComponentObjectSetValue2(dmc, "damage_multipliers", "slice",
    ComponentObjectGetValue2(dmc, "damage_multipliers", "slice")+.3
)
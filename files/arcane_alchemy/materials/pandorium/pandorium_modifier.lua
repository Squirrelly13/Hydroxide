local entity_id = GetUpdatedEntityID()

local proj_comps = EntityGetComponent(entity_id, "ProjectileComponent") or {}
for index, projectile in ipairs(proj_comps) do
    ComponentSetValue2(projectile, "mWhoShot", 0)
end
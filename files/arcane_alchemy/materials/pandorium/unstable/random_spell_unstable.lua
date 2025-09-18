UnstablePandorium_spells = {}

if #UnstablePandorium_spells == 0 then
    dofile("data/scripts/gun/gun_actions.lua")

    local spells_added = {}
    for k, data in pairs(actions)do
        if data.related_projectiles ~= nil and not (data.pandorium_ignore or data.ai_never_uses or data.recursive) then
            for k2, v in pairs(data.related_projectiles)do
                if not spells_added[v] then
                    table.insert(UnstablePandorium_spells, v)
                    spells_added[v] = true
                end
            end
        end
    end
end

local speed = 600

function init(entity_id)
    local pos_x, pos_y = EntityGetTransform(entity_id)
    SetRandomSeed(pos_x + GameGetFrameNum(), pos_y + entity_id)

    local rotation = math.rad(Random(1, 360))
    local vel_x = math.cos(rotation) * speed
    local vel_y = 0-math.sin(rotation) * speed

    local projectile = EntityLoad(UnstablePandorium_spells[Random(1, #UnstablePandorium_spells)], pos_x, pos_y)

    GameShootProjectile(entity_id, pos_x, pos_y, vel_x + pos_x, vel_y + pos_y, projectile)

    local velcomps = EntityGetComponent(projectile, "VelocityComponent")
    if velcomps ~= nil then ComponentSetValue2(velcomps[1], "mVelocity", vel_x, vel_y) end

    EntityKill(entity_id)
end
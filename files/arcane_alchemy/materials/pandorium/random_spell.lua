Pandorium_spells = {
    "data/entities/projectiles/deck/light_bullet.xml",
    "data/entities/projectiles/deck/tentacle.xml",
    "data/entities/projectiles/deck/arrow.xml",
    "data/entities/projectiles/deck/bullet.xml",
    "data/entities/projectiles/deck/bubbleshot.xml",
    "data/entities/projectiles/deck/disc_bullet.xml",
}

local speed = 200

function init(entity_id)
    local pos_x, pos_y = EntityGetTransform(entity_id)
    SetRandomSeed(GameGetFrameNum(), entity_id)

    local rotation = math.rad(Random(1, 360))
    local vel_x = math.cos(rotation) * speed
    local vel_y = 0-math.sin(rotation) * speed

    local projectile = EntityLoad(Pandorium_spells[Random(1, #Pandorium_spells)], pos_x, pos_y)

    GameShootProjectile(entity_id, pos_x, pos_y, vel_x + pos_x, vel_y + pos_y, projectile)

    local velcomps = EntityGetComponent(projectile, "VelocityComponent")
    if velcomps ~= nil then ComponentSetValue2(velcomps[1], "mVelocity", vel_x, vel_y) end

    EntityKill(entity_id)
end
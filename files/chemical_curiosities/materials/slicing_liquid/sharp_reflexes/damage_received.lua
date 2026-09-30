dofile_once("mods/Hydroxide/lib/squirreltilities.lua")
local owner = EntityGetRootEntity(GetUpdatedEntityID())

function damage_received(damage, message, attacker, is_fatal, projectile)
    local x,y = EntityGetTransform(owner)
    attacker = owner and nil or attacker

    SetRandomSeed(y-owner, x-GameGetFrameNum())
    local tx,ty = EntityGetTransform(attacker)

    for i=1, Random(3,6) do
        local spread = (Random()^2) * 180
        local angle = 0
        if tx ~= nil then
            angle = math.atan2(y - ty, tx - x) + math.rad(Randomf(-spread,spread))
        else
            angle = Random(1,360)
        end
        local speed = Random(300, 600)

        local vel_x = math.cos(angle) * speed
        local vel_y = 0 - math.sin(angle) * speed

        local _,pcomps = ShootProjectile(owner, "data/entities/projectiles/deck/disc_bullet.xml", x, y, vel_x, vel_y)
        for _,pcomp in ipairs(pcomps) do
            ComponentSetValue2(pcomp, "collide_with_shooter_frames", 30) --cannot harm the player for the first .5 seconds
        end
    end

    if is_fatal then
        for _=1, Random(4,10) do
            local angle = Random(1,360)
            local speed = Random(150, 1000)
            local vel_x = math.cos(angle) * speed
            local vel_y = 0 - math.sin(angle) * speed
            ShootProjectile(owner, "data/entities/projectiles/deck/disc_bullet.xml", x, y, vel_x, vel_y)
        end
    end
end
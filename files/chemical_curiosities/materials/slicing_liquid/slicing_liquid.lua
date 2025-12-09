dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)
local angle = math.rad(Random(60,120))
local length = Random(30,800)
local vel_x = math.cos(angle) * length
local vel_y = 0 - math.sin(angle) * length

ShootProjectile(nil, "data/entities/projectiles/deck/disc_bullet.xml", pos_x, pos_y, vel_x, vel_y)

EntityKill(GetUpdatedEntityID())
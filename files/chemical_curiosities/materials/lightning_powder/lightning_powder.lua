dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)
local angle = math.rad(Random(45,135))
local speed = Random(30,60)
local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

ShootProjectile(nil, "data/entities/projectiles/deck/thunder_blast.xml", pos_x, pos_y, vel_x, vel_y)

EntityKill(entity_id)
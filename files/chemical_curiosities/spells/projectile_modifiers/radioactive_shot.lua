dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id    = GetUpdatedEntityID()
local owner = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform(owner)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)

local angle = math.rad(Random(0,359))
local speed = 40

local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

local eid = shoot_projectile_from_projectile(owner, "data/entities/projectiles/deck/orb_laseremitter_weak.xml", pos_x, pos_y, vel_x, vel_y)
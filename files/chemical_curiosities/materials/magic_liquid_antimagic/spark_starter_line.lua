dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)
local angle = math.rad(Random(45,135))
local speed = Random(40,80)
local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

ShootProjectile(entity_id, "mods/Hydroxide/files/chemical_curiosities/materials/kindling/fire_line.xml", pos_x, pos_y, vel_x, vel_y) --fuckk had no idea this also called fire_line.xml, might have to move it in the future -UserK

EntityKill(entity_id)
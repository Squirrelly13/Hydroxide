dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)
local target = EntityGetClosestWithTag(pos_x, pos_y, "enemy")
local tpos_x, tpos_y = EntityGetTransform(target)

local spread = 7
local angle
if tpos_x ~= nil then angle = math.atan2(pos_y - tpos_y, tpos_x - pos_x) + math.rad(Randomf(-spread,spread))
else angle = Random(1,360) end

local speed = Random(600, 1500)
local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

ShootProjectile(nil, "mods/Hydroxide/files/chemical_curiosities/materials/sparkling_liquid/sparkling_particle.xml", pos_x, pos_y, vel_x, vel_y)

EntityKill(entity_id)
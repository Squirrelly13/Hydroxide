dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()

local vel = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent")

local vx, vy = ComponentGetValue2(vel, "mVelocity")

ComponentSetValue2(vel, "mVelocity", vec_rotate(vx,vy, math.rad(Random(-40,40)) ) )
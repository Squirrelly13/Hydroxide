dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()

local vel = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent")
if not vel then return end
local vx, vy = ComponentGetValue2(vel, "mVelocity")

ComponentSetValue2(vel, "mVelocity", vec_rotate(vx,vy, math.rad(Random(-40,40)) ) )
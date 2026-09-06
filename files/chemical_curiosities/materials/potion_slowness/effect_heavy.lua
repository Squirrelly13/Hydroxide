dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local parent = EntityGetParent(GetUpdatedEntityID())

local vel_comp = EntityGetFirstComponent(parent, "VelocityComponent")
if not vel_comp then return end

local vel_x, vel_y = ComponentGetValue2(vel_comp, "mVelocity")
vel_x = vel_x or 0
vel_y = vel_y or 0

vel_y = vel_y / 1 + GetStatusCombined(parent, "CC_LEVITATION_SLOWER")

ComponentSetValue2(vel_comp, "mVelocity", vel_x, vel_y)
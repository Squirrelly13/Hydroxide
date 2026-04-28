dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity)

local cdc = EntityGetFirstComponent(root, "VelocityComponent")
if not cdc then return end

local vel_x, vel_y = ComponentGetValue2(cdc, "mVelocity") or 0, 0
print(("(%s, %s)"):format(vel_x, vel_y))

vel_y = vel_y * 1 + GetStainPercentage(root, "CC_LEVITATION_SLOWER") * 50 + GetIngestionSeconds(entity, "CC_LEVITATION_SLOWER")

ComponentSetValue2(cdc, "mVelocity", vel_x, vel_y)
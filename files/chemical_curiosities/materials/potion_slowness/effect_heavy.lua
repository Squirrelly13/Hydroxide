local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity)

local cdc = EntityGetFirstComponent(root, "VelocityComponent")
if not cdc then return end

local vel_x, vel_y = ComponentGetValue2(cdc, "mVelocity") or 0, 0
print(("(%s, %s)"):format(vel_x, vel_y))

local weight = 0
vel_y = vel_y + weight

ComponentSetValue2(cdc, "mVelocity", vel_x, vel_y)
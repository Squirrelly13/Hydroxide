dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

local root = EntityGetParent( entity)

if(root == entity)then return end


local component = EntityGetFirstComponent(root, "CharacterDataComponent")

local vel_x, vel_y = 0, 0
vel_x, vel_y = ComponentGetValueVector2(component, "mVelocity")

if(vel_y ~= nil) then
local multiplier = 20
vel_y = vel_y + multiplier

ComponentSetValueVector2(component, "mVelocity", vel_x, vel_y)
end
dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

local root = EntityGetParent( entity)

if(root == entity)then return end


local component = EntityGetFirstComponent(root, "CharacterDataComponent")

local vel_x, vel_y = ComponentGetValueVector2(component, "mVelocity")


local multiplier = 10
local vel_y = vel_y + multiplier

ComponentSetValueVector2(component, "mVelocity", vel_x, vel_y)

dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

local root = EntityGetClosestWithTag(x, y, "mortal")

local component = EntityGetFirstComponent(entity, "IKLimbAttackerComponent")
if not component then return end
ComponentSetValue2(component, "mTargetEntity", root)
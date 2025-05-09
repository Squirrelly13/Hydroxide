dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local animal_ai_component = EntityGetFirstComponentIncludingDisabled(owner, "AnimalAIComponent")



if animal_ai_component then
  local creature_detection_range_x = ComponentGetValue2(animal_ai_component, "creature_detection_range_x")
  local creature_detection_range_y = ComponentGetValue2(animal_ai_component, "creature_detection_range_y")
  ComponentSetValue2(animal_ai_component, "creature_detection_range_x", creature_detection_range_x * 0.05)
  ComponentSetValue2(animal_ai_component, "creature_detection_range_y", creature_detection_range_y * 0.05)
--[[ else
  local comp = EntityGetFirstComponent(owner, "GameEffectComponent")
  if not comp then return end
  ComponentSetValue2(comp, "frames", GetStainPercentage(owner, "CC_BLINDNESS") * 10)
  print(GetStainPercentage(owner, "CC_BLINDNESS") * 10) ]]
end

dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local animal_ai_component = EntityGetFirstComponentIncludingDisabled(owner, "AnimalAIComponent")

if (EntityGetWithName( "grayscaleController") == 0) then
	local controller = EntityLoad("mods/Hydroxide/files/entities/effects/methane/grayscaleController.xml", 0,0)
	EntitySetName( controller, "grayscaleController")
end


if not animal_ai_component then
EntitySetName(entity_id, "MethaneStain")
end
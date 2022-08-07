local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local animal_ai_component = EntityGetFirstComponentIncludingDisabled(owner, "AnimalAIComponent")

local vsc = EntityGetFirstComponentIncludingDisabled( owner, "VariableStorageComponent" )

if not animal_ai_component then

	GameSetPostFxParameter("grayscale", 0, 0, 0, 0)
	
	ComponentSetValue( vsc, "value_float", 0)
end
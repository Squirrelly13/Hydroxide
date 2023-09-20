dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform(entity_id)

local enemies = EntityGetWithTag("enemy")
local enemyCount = #enemies

--print("Enemies loaded: " .. enemyCount)

if (enemyCount <= 200) then

	for i, comp in ipairs(EntityGetComponent(entity_id, "VariableStorageComponent") or {}) do
		if ComponentGetValue2(comp, "name") == "is_cloned_entity" then
			do return end
		end
	end

	local animalPath = ""

	if(EntityHasTag(entity_id, "player_unit")) then
		animalPath = "data/entities/animals/failed_alchemist.xml"
	else
		local spriteComponent = EntityGetFirstComponent( entity_id, "SpriteComponent")
		local spritePath = ComponentGetValue( spriteComponent, "image_file" )
		animalPath = string.gsub(spritePath, "data/enemies_gfx/", "data/entities/animals/")
	end

	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

	local clonnedCreature = EntityLoad(animalPath, x + Random(15, -15), y + Random(5, 10))


	if(animalPath == "data/entities/animals/failed_alchemist.xml")then

		genome = EntityGetFirstComponent(clonnedCreature, "GenomeDataComponent")
	
		if(genome ~= nil and genome ~= 0)then
			ComponentSetValue2(genome, "herd_id", StringToHerdId("mage_swapper"))
		end
  
	end

	EntityAddComponent2(clonnedCreature, "VariableStorageComponent", {
		_tags = "no_gold_drop", 
	})
	
	EntityAddComponent2(clonnedCreature, "VariableStorageComponent", {
		name = "is_cloned_entity"
	})

end
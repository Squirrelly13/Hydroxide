local root = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(root)

local enemies = EntityGetWithTag("enemy")
local enemyCount = #enemies

--print("Enemies loaded: " .. enemyCount)

if (enemyCount <= 200) then

	for i, comp in ipairs(EntityGetComponent(root, "VariableStorageComponent") or {}) do
		if ComponentGetValue2(comp, "name") == "is_cloned_entity" then
			do return end
		end
	end

	local animalPath = ""

	if(EntityHasTag(root, "player_unit")) then
		animalPath = "data/entities/animals/failed_alchemist.xml"
	else
		local spriteComponent = EntityGetFirstComponent(root, "SpriteComponent")
		if not spriteComponent then return end
		local spritePath = ComponentGetValue2(spriteComponent, "image_file")
		animalPath = spritePath:gsub("data/enemies_gfx/", "data/entities/animals/")
	end

	SetRandomSeed(GameGetFrameNum(), x + y + root)

	local clonnedCreature = EntityLoad(animalPath, x + Random(15, -15), y + Random(5, 10))


	if(animalPath == "data/entities/animals/failed_alchemist.xml")then

		local genome = EntityGetFirstComponent(clonnedCreature, "GenomeDataComponent")

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
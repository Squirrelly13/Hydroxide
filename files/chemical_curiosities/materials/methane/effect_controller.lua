dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

if(not EntityHasTag(owner, "player_unit"))then
	return
end

local count = GetStainPercentage(owner, "CC_INGESTION_METHANE")

local multiplier = (ModSettingGet("Hydroxide.CC_METHANE_EFFECT_MULTIPLIER") or 100) / 100

count = count * multiplier

GameSetPostFxParameter("grayscale", 0, 0, 0, count)

if (count <= 0) then
	EntityKill(entity_id)
end
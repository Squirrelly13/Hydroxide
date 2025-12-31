dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local owner = EntityGetParent(GetUpdatedEntityID())
if not (EntityHasTag(owner, "player_unit") or EntityHasTag(owner, "player_polymorphed")) then return end

local count = math.min(GetStatusCombined(owner, "CC_INGESTION_METHANE"), 1)
local multiplier = (ModSettingGet("Hydroxide.CC_METHANE_EFFECT_MULTIPLIER") or 100) * .01

count = count * multiplier
GameSetPostFxParameter("greyscale", 0, 0, 0, count)
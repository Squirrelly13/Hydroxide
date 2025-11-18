dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local owner = EntityGetParent(GetUpdatedEntityID())
if not IsPlayer(owner) then return end

local count = GetStatusCombined(owner, "CC_INGESTION_METHANE")
local multiplier = (ModSettingGet("Hydroxide.CC_METHANE_EFFECT_MULTIPLIER") or 100) * .01

count = count * multiplier
GameSetPostFxParameter("greyscale", 0, 0, 0, count)
dofile_once("mods/Hydroxide/files/lib/status_helper.lua") --Handy lib we have, idk if it was made internally but i assume its grabbed some somewhere else like noita wiki, many thanks to whomever wrote it
dofile_once("data/scripts/lib/utilities.lua") --lib that idk its probs vital to a bunch of the functions i used


--Get the target (one with the effect)

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
local owner = EntityGetParent(entity_id)


--Get the vcomp and stored data off of it
local vscomp = EntityGetFirstComponent(entity_id, "VariableStorageComponent") -- find the VarComp on the effect entity (this holds all the data we need to hold onto)
if not vscomp then return end --make sure it has it (it should but idk noita is weird)
local previous_ingestion = ComponentGetValue2(vscomp, "value_float") --grab the ingestion from the last frame (is 0 by default if this is the first frame)
local counter = ComponentGetValue2(vscomp, "value_int") --grab the current coundown number (again, 0 by default)
local do_explosion = ComponentGetValue2(vscomp, "value_bool") --grab the current do_explosion bool (this should go off every 2 seconds)


--get the Stain% and Ingestion Amount and derive a General Multiplier from it

local stain = GetStainPercentage(owner, "CC_EXPLODING") --Get Stain% as value from 0 to 1
local inges = GetIngestionSeconds(owner, "CC_EXPLODING") --Get Ingestion Seconds (1:1 in terms of seconds, 10% of flask = 30 seconds)

local multiplier = ((stain + .3)^2.7 * 1.5) + (inges^1.2 * .02) --Combine them using some fun mildly-exponential math stuff (healvily decrease Ingestion to avoid it completely throwing off the Stain%)


--logic for if there should be an explosion:

if inges > previous_ingestion then --if more has been ingested since the last frame:
    ComponentSetValue2(vscomp, "value_int", 0) --set counter to 0
    ComponentSetValue2(vscomp, "value_float", inges) --set new ingestion record to current
    return --exit script

elseif ComponentGetValue2(vscomp, "value_int") < 5 and inges + previous_ingestion ~= 0 then --if counter is less than 5 AND the player has ingested the effect:
    GamePlaySound("data/audio/Desktop/ui.bank", "ui/streaming_integration/new_vote", pos_x, pos_y) --play tick sound effect (i need to find/make a better one or make it louder)
    ComponentSetValue2(vscomp, "value_int", counter + 1) --increment the counter by 1
    return --exit script

elseif inges == 0 and do_explosion == false then --effect should run every 2 seconds but the script runs every 1 second, so i have a script 
    ComponentSetValue2(vscomp, "value_bool", true)
    return --exit script

-- if ingestion is not more than previous ingestion AND counter is equal >= 5 AND the do_explosion check == true, move to the rest of the code that summons the explosion
end


--explosion code:

local explosion = EntityLoad( "data/entities/projectiles/explosion.xml", pos_x, pos_y ) --load the explosion

local comp = EntityGetFirstComponent(explosion, "ProjectileComponent") --grab its Projectile comp (since we wanna overwrite all the important stuff)
if not comp then return end

--print(GetStainPercentage("Agitine Stats:\n".. owner, "CC_EXPLODING") .. "\n" .. GetIngestionSeconds(owner, "CC_EXPLODING").."\nPost Calc:\n".. a .. "\n" .. b .. "\n" .. multiplier)

--Apply the multiplier in various ways to the explosion stats (i spent like an entire day tweaking these and im still not full satisfied :devastatated:)
ComponentObjectSetValue2(comp, "config_explosion", "camera_shake", 13 * math.min(20, multiplier)) --how much the camera shakes
ComponentObjectSetValue2(comp, "config_explosion", "damage", 4 * multiplier^1.5) --damage (uncapped cuz funny and no reason to limit it)
ComponentObjectSetValue2(comp, "config_explosion", "explosion_radius", 12 * math.min(50, multiplier^.8)) --radius of the explosion (obviously limited for good reasons)
ComponentObjectSetValue2(comp, "config_explosion", "ray_energy", 20000 * math.min(1200, multiplier^1.8)) --the strength of the exposion (damage it does to pixels)
ComponentObjectSetValue2(comp, "config_explosion", "who_is_responsible", owner) --identify the explosion origin (so they get kill credit probs)
ComponentObjectSetValue2(comp, "config_explosion", "sparks_count_min", 5 * math.min(20, multiplier^1.4)) --minimum particle sparks
ComponentObjectSetValue2(comp, "config_explosion", "sparks_count_max", (5 * math.min(100, multiplier))^1.3) --maximum particle sparks
ComponentObjectSetValue2(comp, "config_explosion", "max_durability_to_destroy", 14) --ensures this can break through high-level materials if it has enough ray_energy

if GameHasFlagRun("PERK_PICKED_IRON_STOMACH") and inges ~= 0 then --if player has picked IRON_STOMACH and Ingestion is not 0:
    ComponentObjectSetValue2(comp, "config_explosion", "dont_damage_this", owner) --set the explosion to not harm the owner
end
EntityRemoveIngestionStatusEffect(owner, "CC_EXPLODING") --Remove all of the ingested effect (leaves the stain)
ComponentSetValue2(vscomp, "value_bool", false) --reset the do_explosion bool so the effect continues to only take effect every 2 seconds


EntityKill( entity_id ) --tbh idk, it was here when i got here, it shouldnt be killing the status entity cuz that has the vscomp on it and the script works fine, so idk ig he can stay.
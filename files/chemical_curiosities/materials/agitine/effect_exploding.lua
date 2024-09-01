dofile_once("mods/Hydroxide/files/lib/status_helper.lua")
dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
local owner = EntityGetParent(entity_id)




local vscomp = EntityGetFirstComponent(entity_id, "VariableStorageComponent")
if not vscomp then return end
local previous_ingestion = ComponentGetValue2(vscomp, "value_float")
local counter = ComponentGetValue2(vscomp, "value_int")
local do_explosion = ComponentGetValue2(vscomp, "value_bool")



local a = GetStainPercentage(owner, "CC_EXPLODING")
local b = GetIngestionPercentage(owner, "CC_EXPLODING")
local multiplier = ((a + .3)^2.7 * 2) + (b^1.2 * .01)

if b > previous_ingestion then
    ComponentSetValue2(vscomp, "value_int", 0)
    ComponentSetValue2(vscomp, "value_float", b)
    --print(b .. " > " .. previous_ingestion)
    return
elseif ComponentGetValue2(vscomp, "value_int") < 5 and b + previous_ingestion ~= 0 then
    --print(counter .. " < " .. 5)
    GamePlaySound("data/audio/Desktop/ui.bank", "ui/streaming_integration/new_vote", pos_x, pos_y)
    ComponentSetValue2(vscomp, "value_int", counter + 1)
    return
elseif do_explosion == false then
    ComponentSetValue2(vscomp, "value_bool", true)
    return
end



local explosion = EntityLoad( "data/entities/projectiles/explosion.xml", pos_x, pos_y )

local comp = EntityGetFirstComponent(explosion, "ProjectileComponent")
if not comp then return end

print(GetStainPercentage("Agitine Stats:\n".. owner, "CC_EXPLODING") .. "\n" .. GetIngestionPercentage(owner, "CC_EXPLODING").."\nPost Calc:\n".. a .. "\n" .. b .. "\n" .. multiplier)

ComponentObjectSetValue2(comp, "config_explosion", "camera_shake", 13 * math.min(20, multiplier))
ComponentObjectSetValue2(comp, "config_explosion", "damage", 4 * multiplier^1.5)
--print(4*multiplier^1.5)
ComponentObjectSetValue2(comp, "config_explosion", "explosion_radius", 16 * math.min(40, multiplier^.8))
ComponentObjectSetValue2(comp, "config_explosion", "ray_energy", 20000 * math.min(1200, multiplier^1.8))
--print(20000 * math.min(400, multiplier^3))
ComponentObjectSetValue2(comp, "config_explosion", "who_is_responsible", owner)
ComponentObjectSetValue2(comp, "config_explosion", "sparks_count_min", (6 * math.min(20, multiplier))^2)
ComponentObjectSetValue2(comp, "config_explosion", "sparks_count_max", (13 * math.min(20, multiplier))^2)
ComponentObjectSetValue2(comp, "config_explosion", "max_durability_to_destroy", 14)

if GameHasFlagRun("PERK_PICKED_IRON_STOMACH") and b ~= 0 then
    print("adding dont_damage_shooter tag")
    --ComponentSetValue2(comp, "explosion_dont_damage_shooter", true)
    --ComponentSetValue2(comp, "mWhoShot", owner)
    ComponentObjectSetValue2(comp, "config_explosion", "dont_damage_this", owner)
    --EntityKill( owner ) --KILL YOU!!!!!!!!!!!
end
EntityRemoveIngestionStatusEffect(owner, "CC_EXPLODING")
EntityKill( entity_id )
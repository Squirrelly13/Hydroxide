---@diagnostic disable: undefined-global
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

function get_random_from( target )
	local rnd = Random(1, #target)

	return tostring(target[rnd])
end

function get_random_between_range( target )
	local minval = target[1]
	local maxval = target[2]

	return Random(minval, maxval)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )
if not ability_comp then return end

local wand = { }
wand.name = {"Nerf Gun"}
wand.deck_capacity = {3,3}
wand.actions_per_round = 1
wand.reload_time = {10,10}
wand.shuffle_deck_when_empty = 0 --0=NoShuffle
wand.fire_rate_wait = {20,20}
wand.spread_degrees = {5,5}
wand.speed_multiplier = 1
wand.mana_charge_speed = {40,40}
wand.mana_max = {100,100}

--AddGunAction( entity_id, "DIGGER" )
--AddGunAction( entity_id, "DIGGER" )

AddGunAction( entity_id, "AA_ALCHEMY_NERF_DARTS" )
AddGunAction( entity_id, "AA_ALCHEMY_NERF_DARTS" )
AddGunAction( entity_id, "AA_ALCHEMY_NERF_DARTS" )

local mana_max = get_random_between_range( wand.mana_max )
local deck_capacity = get_random_between_range( wand.deck_capacity )

ComponentSetValue2( ability_comp, "ui_name", get_random_from( wand.name ) )

ComponentObjectSetValue2( ability_comp, "gun_config", "reload_time", get_random_between_range( wand.reload_time ) )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "fire_rate_wait", get_random_between_range( wand.fire_rate_wait ) )
ComponentSetValue2( ability_comp, "mana_charge_speed", get_random_between_range( wand.mana_charge_speed ) )

ComponentObjectSetValue2( ability_comp, "gun_config", "actions_per_round", wand.actions_per_round )
ComponentObjectSetValue2( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue2( ability_comp, "gun_config", "shuffle_deck_when_empty", wand.shuffle_deck_when_empty )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "spread_degrees", get_random_between_range( wand.spread_degrees ) )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "speed_multiplier", wand.speed_multiplier )

ComponentSetValue2( ability_comp, "mana_max", mana_max )
ComponentSetValue2( ability_comp, "mana", mana_max )

local action_count = 1
local modifier_count = math.min( deck_capacity - action_count, Random( 1) )
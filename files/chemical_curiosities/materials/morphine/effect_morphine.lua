dofile_once("data/scripts/lib/utilities.lua")

local max_hp = 0
local hp 	 = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )
if not vsc then return end
local trueHP = tonumber(ComponentGetValue2( vsc, "value_float" ))

--print("morphine.lua: trueHP before math: " .. trueHP)
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
if not damagemodel then return end
max_hp 	= ComponentGetValue2( damagemodel, "max_hp" ) 
 
hp		= ComponentGetValue2( damagemodel, "hp"	 ) 

local diff 	= max_hp - hp
if diff == 0 then return end

trueHP = trueHP - (diff * .5) --morphine provides 50% damage resistance



if (trueHP <= 0) then
	EntityInflictDamage( root, 5 * max_hp, "DAMAGE_OVEREATING", "$death_cc_morphine", "PLAYER_RAGDOLL_CAMERA", -500, 0)
end
ComponentSetValue2(damagemodel, "hp", max_hp)

ComponentSetValue2( vsc, "value_float", trueHP)

--print("Morphine")
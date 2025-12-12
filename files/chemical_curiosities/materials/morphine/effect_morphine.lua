local entity = GetUpdatedEntityID()
local root = EntityGetParent(entity)

local vsc = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent")
if not vsc then return end
local true_hp = tonumber(ComponentGetValue2(vsc, "value_float"))

--print("morphine.lua: trueHP before math: " .. trueHP)
local damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent")
if not damagemodel then return end

local max_hp
local hp

max_hp 	= ComponentGetValue2(damagemodel, "max_hp")
hp		= ComponentGetValue2(damagemodel, "hp"	)

local diff 	= max_hp - hp
if diff == 0 then return end

true_hp = true_hp - (diff * .25) --morphine provides 75% damage resistance

if (true_hp <= 0) then --if the player's true HP is equal to or below 0, trigger kill effect
	EntityInflictDamage(root, 5 * max_hp, "NONE", "$death_cc_morphine", "PLAYER_RAGDOLL_CAMERA", -500, 0)
end

ComponentSetValue2(damagemodel, "hp", max_hp)
ComponentSetValue2(vsc, "value_float", true_hp)
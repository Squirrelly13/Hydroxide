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

max_hp = ComponentGetValue2(damagemodel, "max_hp")
hp = ComponentGetValue2(damagemodel, "hp"	)



local function take_damage(dmg)
	if dmg > 0 then dmg = dmg * .25 end --morphine provides 75% damage resistance (discounted if damage is below 0)
	true_hp = true_hp - dmg

	if true_hp <= 0 then --if the player's true HP is equal to or below 0, trigger kill effect
		EntityInflictDamage(root, 5 * max_hp, "NONE", "$death_cc_morphine", "PLAYER_RAGDOLL_CAMERA", 0, 0)
	end

	ComponentSetValue2(damagemodel, "hp", max_hp)
	ComponentSetValue2(vsc, "value_float", true_hp)
end


function damage_about_to_be_received(incoming_damage, x, y, attacker, crit)
	if true_hp <= 0 then return incoming_damage, crit end --prevent feedback loops

	SetRandomSeed(true_hp + x, incoming_damage - y)
	if Random() * 100 <= crit then --simulate crits
		incoming_damage = incoming_damage * 5 * math.max(crit * .01, 1)
	end
	take_damage(incoming_damage)
end

local damage_taken = max_hp - hp
if damage_taken ~= 0 then take_damage(damage_taken) end
local entity = GetUpdatedEntityID()
local root = EntityGetParent(entity)

local vsc = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent")
if not vsc then return end
local true_hp = tonumber(ComponentGetValue2(vsc, "value_float")) or 4

local damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent")
if not damagemodel then return end

ComponentSetValue2(damagemodel, "max_hp", true_hp)
if true_hp <= 0 then EntityInflictDamage(root, true_hp, "NONE", "$death_cc_morphine", "PLAYER_RAGDOLL_CAMERA", 0, 0) end

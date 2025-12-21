local entity = GetUpdatedEntityID()
local root = EntityGetParent(entity)

local vsc = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent")
if not vsc then return end
local damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent")
if not damagemodel then return end


local max_hp = tonumber(ComponentGetValue2(damagemodel, "max_hp"))
local trueHP = tonumber(ComponentGetValue2(damagemodel, "hp"))

ComponentSetValue2(vsc, "value_float", trueHP)
ComponentSetValue2(damagemodel, "hp", max_hp)
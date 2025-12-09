local entity = GetUpdatedEntityID()
local root = EntityGetParent(entity)

for _,damagemodel in ipairs(EntityGetComponent(root, "DamageModelComponent") or {}) do
	local max_hp = tonumber(ComponentGetValue2(damagemodel, "max_hp")) or 0
	ComponentSetValue2(damagemodel, "max_hp", max_hp * 1.01)
end
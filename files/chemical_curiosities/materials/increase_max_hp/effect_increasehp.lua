local entity = GetUpdatedEntityID()
local root = EntityGetParent(entity)

for _,damagemodel in ipairs(EntityGetComponent(root, "DamageModelComponent") or {}) do
	local max_hp = tonumber(ComponentGetValue2(damagemodel, "max_hp"))
	local hp = tonumber(ComponentGetValue2(damagemodel, "hp"))

	local new_max_hp = max_hp * 1.01^(1/60) --increase max hp by 1% every second
	hp = math.max(hp-(new_max_hp-max_hp), 0.4) --lose HP equal to the Max HP gained, down to 10 HP

	ComponentSetValue2(damagemodel, "max_hp", new_max_hp)
	ComponentSetValue2(damagemodel, "hp", hp)
end
local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

for _, c in ipairs(EntityGetAllChildren(owner) or {}) do
	if EntityGetName(c) == "cc_shield_manager" then return end
end

print("adding shield")
local shield_entity = EntityLoad("mods/Hydroxide/files/chemical_curiosities/shield/shield_manager.xml")
if owner == 0 or owner == nil then print("err, invalid owner") return end
EntityAddChild(owner, shield_entity)
print(shield_entity)
print(owner)



local dmc = EntityGetFirstComponent(owner, "DamageModelComponent")
if dmc == nil then return end print("found dmc")
local max_hp = ComponentGetValue2(dmc, "max_hp")

for _, varcomp in ipairs(EntityGetComponent(shield_entity, "VariableStorageComponent") or {}) do
	if ComponentGetValue2(varcomp, "name") == "shield_hp" then
		ComponentSetValue2(varcomp, "value_float", max_hp) print("setting shield_hp to " .. max_hp)
	end
end
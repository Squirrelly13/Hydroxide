local entity_id = GetUpdatedEntityID()

for _,comp in ipairs(EntityGetComponent(entity_id, "InventoryGuiComponent") or{}) do
	ComponentSetValue2(comp, "mActive", false)
end

for _,child in ipairs(EntityGetAllChildren(entity_id) or {}) do
	local name = EntityGetName(child)
	if name == "inventory_quick" or name == "inventory_full" then
		if #(EntityGetAllChildren(child) or {}) == 0 then EntityKill(child) end
	else
		local ge_comp = EntityGetFirstComponent(child, "GameEffectComponent")
		local ui_comp = EntityGetFirstComponent(child, "UIIconComponent")
		if ge_comp and ui_comp then
			ComponentSetValue2(ui_comp, "is_perk", ComponentGetValue2(ge_comp, "frames") < 0)
		end --toggle the timer depending on if the effect is permanent or not
	end
end
local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local var_comps = EntityGetComponent(GetUpdatedEntityID(), "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end

for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then
        if ComponentGetValue2(varcomp, "value_int") >= 0 then
            ComponentSetValue2(varcomp, "value_int", ComponentGetValue2(varcomp, "value_int") - 1)

        else if ComponentGetValue2(varcomp, "value_int") == -1 then EntityKill(entity_id) end --remove the component entirely if radiation reaches 0

        end
	end
end
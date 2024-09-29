local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end

local radcount
local radstage

local stage1 = 15
local stage2 = 100
local stage3 = 200
local stage4 = 300
local stage5 = 400
local stage6 = 500
local stage7 = 15
local stage8 = 15
local stage9 = 15
local stage10 = 15
local stage11 = 15
local stage12 = 15
local stage13 = 15


for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then radcount = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "radstage" then radstage = varcomp
	end
end





print(ComponentGetValue2(radcount, "value_int"))
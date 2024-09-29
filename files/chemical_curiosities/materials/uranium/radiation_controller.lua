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
local stage7 = 600
local stage8 = 700
local stage9 = 800
local stage10 = 900
local stage11 = 1000
local stage12 = 1100
local stage13 = 1200


local vomit = false
local vomit = false



for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then radcount = varcomp
    --elseif ComponentGetValue2(varcomp, "name") == "radstage" then radstage = varcomp
	end
end

local stage = ComponentGetValue2(radstage, "value_int")

if ComponentGetValue2(radcount, "value_int") >= stage1 then
	stage = 1
	vomit = true
end

if ComponentGetValue2(radcount, "value_int") >= stage2 then
	stage = 2
	
end

if ComponentGetValue2(radcount, "value_int") >= stage3 then
	stage = 3
	
end

if ComponentGetValue2(radcount, "value_int") >= stage4 then
	stage = 4
	
end

if ComponentGetValue2(radcount, "value_int") >= stage5 then
	stage = 5
	
end

if ComponentGetValue2(radcount, "value_int") >= stage6 then
	stage = 6
	
end

if ComponentGetValue2(radcount, "value_int") >= stage7 then
	stage = 7
	
end

if ComponentGetValue2(radcount, "value_int") >= stage8 then
	stage = 8
	
end

if ComponentGetValue2(radcount, "value_int") >= stage9 then
	stage = 9
	
end

if ComponentGetValue2(radcount, "value_int") >= stage10 then
	stage = 10
	
end

if ComponentGetValue2(radcount, "value_int") >= stage11 then
	stage = 11
	
end

if ComponentGetValue2(radcount, "value_int") >= stage12 then
	stage = 12
	
end

if ComponentGetValue2(radcount, "value_int") >= stage13 then
	stage = 13
	
end






print(ComponentGetValue2(radcount, "value_int"))
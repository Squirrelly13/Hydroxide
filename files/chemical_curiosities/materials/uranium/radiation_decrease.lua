dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/RAD_ENUMS.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)

local var_comps = EntityGetComponent(GetUpdatedEntityID(), "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end
local radcount
local leggytracker
local leggyentity = -1

for index, varcomp in ipairs(var_comps) do
    local name = ComponentGetValue2(varcomp, "name")
    if name == "leggytracker" then
        leggytracker = varcomp
        leggyentity = ComponentGetValue2(leggytracker, "value_int") or -1 --grab leggy entity
    
    elseif name == "radcount" then
        radcount = ComponentGetValue2(varcomp, "value_int")
        if radcount >= 0 then
            ComponentSetValue2(varcomp, "value_int", radcount - 1) --decrease rad by 1
        else if radcount == -1 then EntityKill(entity_id) end --remove the component entirely if radiation reaches -1
        end
	end
end

print(tostring(STAGE5))

if leggyentity > 0 and radcount < STAGE5 then
    print("ATTEMPTING TO REMOVE " .. leggyentity)
    local leggyvarcomps = EntityGetComponent(leggyentity,"VariableStorageComponent") --check if leggy is permanent
	if leggyvarcomps == nil then KillLeggy()
    elseif ComponentGetValue2(leggyvarcomps[1], "value_bool") ~= true then KillLeggy()
    end 
end

function KillLeggy()
    EntityKill(leggyentity) ComponentSetValue2(leggytracker, "value_int", -1)
end

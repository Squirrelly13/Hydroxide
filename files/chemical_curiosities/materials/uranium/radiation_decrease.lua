dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/RAD_ENUMS.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)
local owner_children = EntityGetAllChildren(owner) or {}

local var_comps = EntityGetComponent(GetUpdatedEntityID(), "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end
local radcount
local leggytracker
local leggyentity = -1

for index, varcomp in ipairs(var_comps) do
    local name = ComponentGetValue2(varcomp, "name")
    --get leggytracker
    if name == "leggytracker" then
        leggytracker = varcomp
        leggyentity = ComponentGetValue2(leggytracker, "value_int") or -1 --grab leggy entity

    --get and decrease radcount
    elseif name == "radcount" then
        radcount = math.min(ComponentGetValue2(varcomp, "value_int"), 510)
        if radcount >= 0 then
            ComponentSetValue2(varcomp, "value_int", radcount - 1) --decrease rad by 1
        else if radcount == -1 then EntityKill(entity_id) end --remove the component entirely if radiation reaches -1
        end
	end
end

local stage
if radcount < STAGE13 then
    stage = 12
end

if radcount < STAGE12 then
    stage = 11

end

if radcount < STAGE11 then
    stage = 10

end

if radcount < STAGE10 then
    stage = 9

end

if radcount < STAGE9 then
    stage = 8

end

if radcount < STAGE8 then
    stage = 7

end

if radcount < STAGE7 then
    stage = 6

end

if radcount < STAGE6 then
    stage = 5

end

--leggy remove
if leggyentity > 0 and radcount < STAGE5 then
    stage = 4
    print("ATTEMPTING TO REMOVE " .. leggyentity)
    local leggyvarcomps = EntityGetComponent(leggyentity,"VariableStorageComponent") --check if leggy is permanent
	if leggyvarcomps == nil then KillLeggy()
    elseif ComponentGetValue2(leggyvarcomps[1], "value_bool") ~= true then KillLeggy()
    end
end

if radcount < STAGE4 then
    stage = 3

end

if radcount < STAGE3 then
    stage = 2
    --positioning remove
    for k,v in ipairs(owner_children) do
        if EntityGetName(v) == "mutagenPositioning" then EntityKill(v) end
    end
end

if radcount < STAGE2 then
    stage = 1

end


if stage then
	local ui_comps = EntityGetComponent(entity_id, "UIIconComponent")
	if ui_comps ~= nil then
		local radstatus = ui_comps[1]
		ComponentSetValue2(radstatus, "name", GameTextGet("$statis_cc_radstage_" .. tostring(stage), radcount))
		ComponentSetValue2(radstatus, "description", GameTextGet("$statis_cc_desc_radstage_" .. tostring(stage), radcount))
		ComponentSetValue2(radstatus, "icon_sprite_file", "mods/Hydroxide/files/chemical_curiosities/materials/uranium/icons/icon_" .. stage .. ".png")
	end
end


function KillLeggy()
    EntityKill(leggyentity) ComponentSetValue2(leggytracker, "value_int", -1) --kill the entity and reset the id stored in the leggytracker
end

dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local variable_storage = EntityGetComponent(entity, "VariableStorageComponent")

local holder = nil
local controller = nil


for k, v in pairs(variable_storage)do
    local name = ComponentGetValue2(v, "name")

    if(name == "controller")then
        controller = tonumber(ComponentGetValue2(v, "value_string"))
    elseif(name == "holder")then
        holder = tonumber(ComponentGetValue2(v, "value_string"))
    end
end

if(controller ~= nil and holder ~= nil)then

    local verletphysics_comp_found = false
    local last_point_index = 0
    edit_component( entity, "VerletPhysicsComponent", function(comp,vars)
        verletphysics_comp_found = true
        last_point_index = ComponentGetValue( comp, "num_points" )
    end)

    local x1, y1 = EntityGetTransform(holder)
    local x2, y2 = EntityGetTransform(controller)

    if verletphysics_comp_found then
        local index = 0

        edit_all_components( entity, "VerletWorldJointComponent", function(comp,vars)
           
            if index == 0 then
                ComponentSetValueVector2( comp, "world_position", x1, y1 )
            else
                ComponentSetValueVector2( comp, "world_position", x2, y2 )
                vars.verlet_point_index = last_point_index
            end

            index = index + 1
        end)
    end
end 
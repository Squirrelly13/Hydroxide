dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local variable_storage = EntityGetComponent(entity, "VariableStorageComponent")

local verlet_file = ""
local radius = "100"
local move_speed = "10"
local tag = ""
local enable_raytrace = "0"
local velocity_falloff = "0"
local projectile_file = ""

for k, v in pairs(variable_storage)do
    local name = ComponentGetValue2(v, "name")

    if(name == "verlet_file")then
        verlet_file = ComponentGetValue2(v, "value_string")
    elseif(name == "attack_radius")then
        radius = ComponentGetValue2(v, "value_string")      
    elseif(name == "projectile_file")then
        projectile_file = ComponentGetValue2(v, "value_string")      
    elseif(name == "attack_speed")then
        move_speed = ComponentGetValue2(v, "value_string") 
    elseif(name == "enable_raytrace")then
        enable_raytrace = ComponentGetValue2(v, "value_string")
    elseif(name == "velocity_falloff")then
        velocity_falloff = ComponentGetValue2(v, "value_string")
    elseif(name == "target_tag")then
        tag = ComponentGetValue2(v, "value_string")     
    end
end

if(verlet_file ~= nil)then
    local verlet_controller = EntityLoad(projectile_file,x,y)
    local verlet = EntityLoad(verlet_file,x,y)

    if(verlet ~= nil)then
        controller_string = tostring(verlet_controller)
        EntityAddComponent(verlet, "VariableStorageComponent", {
            name="controller",
            value_string=controller_string,
        })
        holder_string = tostring(entity)
        EntityAddComponent(verlet, "VariableStorageComponent", {
            name="holder",
            value_string=holder_string,
        })
        
        EntityAddComponent(verlet_controller, "LuaComponent", {
            script_source_file="mods/Hydroxide/files/scripts/misc/verlet_mover.lua",
            execute_on_added="1",
            execute_every_n_frame="0",
        })

        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="holder",
            value_string=holder_string,
        })

        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="attack_radius",
            value_string=radius,
        })

        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="attack_speed",
            value_string=move_speed,
        })

        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="target_tag",
            value_string=tag,
        })

        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="enable_raytrace",
            value_string=enable_raytrace,
        })    
        
        EntityAddComponent(verlet_controller, "VariableStorageComponent", {
            name="velocity_falloff",
            value_string=velocity_falloff,
        })       

        local x2, y2 = EntityGetTransform(verlet_controller)

        if is_valid_entity( verlet ) then
            EntityAddComponent( verlet, "VerletWorldJointComponent" )
            EntityAddComponent( verlet, "VerletWorldJointComponent" )
        end
        
        local verletphysics_comp_found = false
        local last_point_index = 0
        edit_component( verlet, "VerletPhysicsComponent", function(comp,vars)
            verletphysics_comp_found = true
            last_point_index = ComponentGetValue( comp, "num_points" )
        end)
        
        if verletphysics_comp_found then

            local index = 0
        
            edit_all_components( verlet, "VerletWorldJointComponent", function(comp,vars)
                
                if index == 0 then
                    ComponentSetValueVector2( comp, "world_position", x, y )
                else
                    ComponentSetValueVector2( comp, "world_position", x2, y2 )
                    vars.verlet_point_index = last_point_index
                end
        
                index = index + 1
            end)
    
        end   

        EntityAddComponent(verlet, "LuaComponent", {
            script_source_file="mods/Hydroxide/files/scripts/misc/verlet_controller.lua",
            execute_on_added="1",
            execute_every_n_frame="0",
        })

    end

else
    print("[ERROR] verlet_file not found, create a VariableStorageComponent in verlet holder entity with the name 'verlet_file' and a value_string containing the file path.")
end
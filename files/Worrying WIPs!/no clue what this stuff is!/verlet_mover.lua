dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local variable_storage = EntityGetComponent(entity, "VariableStorageComponent")

local holder = nil
local radius = 100
local move_speed = 10
local tag = nil
local enable_raytrace = 0
local velocity_falloff = 0

if(variable_storage ~= nil)then
    for k, v in pairs(variable_storage)do
        local name = ComponentGetValue2(v, "name")
        if(name == "holder")then
            holder = tonumber(ComponentGetValue2(v, "value_string"))
        elseif(name == "attack_radius")then
            radius = tonumber(ComponentGetValue2(v, "value_string"))        
        elseif(name == "attack_speed")then
            move_speed = tonumber(ComponentGetValue2(v, "value_string")) 
        elseif(name == "enable_raytrace")then
            enable_raytrace = tonumber(ComponentGetValue2(v, "value_string")) 
        elseif(name == "velocity_falloff")then
            velocity_falloff = tonumber(ComponentGetValue2(v, "value_string")) 
        elseif(name == "target_tag")then
            tag = ComponentGetValue2(v, "value_string")     
        end
    end

    velocity_falloff = velocity_falloff / 100

    local raytrace_enabled = (enable_raytrace == 1)

    if(holder ~= nil)then
        local holder_x, holder_y = EntityGetTransform(holder)

        local nearby = EntityGetInRadiusWithTag(holder_x, holder_y, radius, tag)

        if(nearby[1] ~= nil)then
            local closest = EntityGetClosestWithTag(holder_x, holder_y, tag)

            local closest_x, closest_y = EntityGetTransform(closest)

            local direction_x = closest_x - x
            local direction_y = closest_y - y

            local len = math.sqrt((direction_x*direction_x) + (direction_y*direction_y))

            local dir_x = direction_x / len
            local dir_y = direction_y / len       
        
            local did_hit, hit_x, hit_y = RaytraceSurfaces( closest_x, closest_y, x + dir_x, y + dir_y)

            local hit_entities = EntityGetInRadiusWithTag( hit_x, hit_y, 10, tag)

            if(hit_entities[1] == nil or raytrace_enabled == false)then
                edit_component( entity, "VelocityComponent", function(comp,vars)
                    local velocity_x, velocity_y = ComponentGetValueVector2( comp, "mVelocity")
            
                    local force_x = (velocity_x*velocity_falloff) +  (dir_x * move_speed)
                    local force_y = (velocity_y*velocity_falloff) + (dir_y * move_speed)
                
                    ComponentSetValue( comp, "gravity_x", 0 )
                    ComponentSetValue( comp, "gravity_y", 0 )
                    ComponentSetValueVector2( comp, "mVelocity", force_x, force_y )
            
                end)
            else
                local direction_x = holder_x - x
                local direction_y = holder_y - y
            
                local len = math.sqrt((direction_x*direction_x) + (direction_y*direction_y))
        
                local dir_x = direction_x / len
                local dir_y = direction_y / len    
        
                edit_component( entity, "VelocityComponent", function(comp,vars)
                    local velocity_x, velocity_y = ComponentGetValueVector2( comp, "mVelocity") 
        
                    local force_x = (velocity_x*velocity_falloff) +  (dir_x * move_speed)
                    local force_y = (velocity_y*velocity_falloff) + (dir_y * move_speed)
                
                    ComponentSetValue( comp, "gravity_x", 0 )
                    ComponentSetValue( comp, "gravity_y", 0 )
                    ComponentSetValueVector2( comp, "mVelocity", force_x, force_y )
            
                end)               
            end
        else

            local direction_x = holder_x - x
            local direction_y = holder_y - y
        
            local len = math.sqrt((direction_x*direction_x) + (direction_y*direction_y))

            local dir_x = direction_x / len
            local dir_y = direction_y / len    

            edit_component( entity, "VelocityComponent", function(comp,vars)
                local velocity_x, velocity_y = ComponentGetValueVector2( comp, "mVelocity") 

                local force_x = (velocity_x*velocity_falloff) +  (dir_x * move_speed)
                local force_y = (velocity_y*velocity_falloff) + (dir_y * move_speed)
            
                ComponentSetValue( comp, "gravity_x", 0 )
                ComponentSetValue( comp, "gravity_y", 0 )
                ComponentSetValueVector2( comp, "mVelocity", force_x, force_y )
        
            end)    
        end
    end 
end
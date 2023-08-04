dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local variable_storage = EntityGetComponent(entity, "VariableStorageComponent")

local verlet_files = ""

local subverlet_files = {}

local point_count = 0

SetRandomSeed(x,y)

for k, v in pairs(variable_storage)do
    local name = ComponentGetValue2(v, "name")
    
    if(name == "subverlet_files")then
        verlet_files = ComponentGetValue2(v, "value_string")
    end
end

if(verlet_files ~= nil)then
    for word in string.gmatch(verlet_files, '[^,]+') do
       -- print(word)
        table.insert(subverlet_files, word)
    end
    local verletphysics_comp_found = false
    edit_component( entity, "VerletPhysicsComponent", function(comp,vars)
        verletphysics_comp_found = true
        point_count = ComponentGetValue( comp, "num_points" )
    end)

    if(verletphysics_comp_found )then
        local verlet_entities = {}
        for k, v in pairs(variable_storage)do
            local name = ComponentGetValue2(v, "name")

            if(string.match(name, "verletentity_"))then
                local verlet_entity = ComponentGetValue2(v, "value_string")
                table.insert(verlet_entities, verlet_entity)
            end
        end

        local verlet_physics = EntityGetFirstComponent(entity, "VerletPhysicsComponent")

        print(ComponentGetMetaCustom(verlet_physics, "positions"))

        local sprite_components = EntityGetComponent(entity, "SpriteComponent")

        for k, component in pairs(sprite_components)do
            sprite_offset_x = ComponentGetValue2(component, "offset_x")
            sprite_offset_y = ComponentGetValue2(component, "offset_y")

            --EntitySave(entity, "verlet_entity.xml")

            local verlet_x = x + sprite_offset_x
            local verlet_y = y + sprite_offset_y

            if(verlet_entities[1] == nil)then
                local verlet_file = subverlet_files[1]
             --   print(verlet_file)
                local verlet_entity = EntityLoad(verlet_file, verlet_x, verlet_y)
                local joint = EntityAddComponent( verlet_entity, "VerletWorldJointComponent" )

                ComponentSetValueVector2( joint, "world_position", verlet_x, verlet_y )
                
                EntityAddComponent(entity, "VariableStorageComponent", {
                    name = "verletentity_"..k,
                    value_string = verlet_entity
                })
            else
                local verlet_entity = verlet_entities[k]

               -- EntitySetTransform(verlet_entity, verlet_x, verlet_y)
                local joint = EntityGetFirstComponent(verlet_entity, "VerletWorldJointComponent")

                ComponentSetValueVector2( joint, "world_position", verlet_x, verlet_y )
             --[[  edit_all_components( verlet_entity, "VerletWorldJointComponent", function(comp,vars)
                    ComponentSetValueVector2( comp, "world_position", verlet_x, verlet_y )
               end)]]
            end
        end
    end
end
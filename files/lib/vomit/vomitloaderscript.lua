dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local root = EntityGetClosestWithTag(x, y, "mortal")

local root_x, root_y = EntityGetTransform(root)

local variable_storage = EntityGetComponent(entity, "VariableStorageComponent")

local root_children = EntityGetAllChildren(root)

local has_vomit = false

for k, v in pairs(root_children)do
    if(EntityHasTag(v, "vomit_entity"))then
        has_vomit = true
        --GamePrint("already has vomit")

    end
end

if(has_vomit ~= true)then
    for k, v in pairs(variable_storage)do
        local name = ComponentGetValue2(v, "name")

        if(name == "vomit_material")then

            local material = ComponentGetValue2(v, "value_string")

            local time = GameGetFrameNum()

            local previous_vomit_time = tonumber(GlobalsGetValue("last_vomited_time_"..material, "-500"))
    
            local time_difference = time - previous_vomit_time         

            if(time_difference > 400)then
                GlobalsSetValue("last_vomited_time_"..material, tostring(time))

                local vomit = EntityLoad("mods/Hydroxide/files/lib/vomit/vomit.xml", x, y)
                EntityAddChild(root, vomit)

                local particle_emitter = EntityGetFirstComponent(vomit, "ParticleEmitterComponent")

                ComponentSetValue2(particle_emitter, "emitted_material_name", material)
            end
        end
    end
end
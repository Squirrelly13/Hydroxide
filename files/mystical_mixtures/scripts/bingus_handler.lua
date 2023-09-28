local entity = GetUpdatedEntityID()

local var_storage_comps = EntityGetComponentIncludingDisabled( entity, "VariableStorageComponent" ) or {}

local volume_var = nil
for i,comp in ipairs( var_storage_comps ) do
    local var_name = ComponentGetValue( comp, "name" )
    if( var_name == "bingus_volume" ) then
        volume_var = comp
        break
    end
end

local volume = ComponentGetValue2( volume_var, "value_float" )

function interacting( entity_who_interacted, entity_interacted, interactable_name )


    if volume > 0.5 then
        volume = 0.001
    else
        volume = 1
    end

    ComponentSetValue2( volume_var, "value_float", volume )
end

local audio_loop = EntityGetFirstComponentIncludingDisabled( entity, "AudioLoopComponent" )

ComponentSetValue2( audio_loop, "m_volume", volume )
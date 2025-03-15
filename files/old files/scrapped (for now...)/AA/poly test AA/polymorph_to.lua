dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform(player)

local storages = EntityGetComponent( entity_id, "VariableStorageComponent" )

if(player == get_players()[1])then

    polymorph_target = nil

    if ( storages ~= nil ) then
        for i,comp in ipairs( storages ) do
            name = ComponentGetValue2( comp, "name" )
            if ( name == "polymorph_target" ) then
                polymorph_target = ComponentGetValue2( comp, "value_string" )
                break
            end
        end
    end

    if(polymorph_target ~= nil)then

        components = EntityGetAllComponents(player)

        for k, v in pairs(components)do
            if(ComponentGetTypeName(v) ~= "ControlsComponent" and ComponentGetTypeName(v) ~= "FogOfWarRadiusComponent" and ComponentGetTypeName(v) ~= "GameStatsComponent" and ComponentGetTypeName(v) ~= "SpriteStainsComponent"  and ComponentGetTypeName(v) ~= "StatusEffectDataComponent" and ComponentGetTypeName(v) ~= "GameEffectComponent" and ComponentGetTypeName(v) ~= "LuaComponent")then
                EntityRemoveComponent(player, v)
            end
        end

        EntityLoadToEntity( polymorph_target, player )
    end
end
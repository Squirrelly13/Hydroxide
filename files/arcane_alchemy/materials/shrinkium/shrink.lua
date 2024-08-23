dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y, r = EntityGetTransform(entity)

local root = EntityGetClosestWithTag(x, y, "mortal")

local is_polymorphed = false

local children = EntityGetAllChildren(root)
if children ~= nil then
    for _, child in ipairs(children) do
        local comps = EntityGetComponentIncludingDisabled(child, "GameEffectComponent")
        if(comps ~= nil)then
            for i,comp in ipairs(comps) do
                local effect = ComponentGetValue2(comp, "effect")
                if(effect ~= nil)then
                    if(effect == "POLYMORPH_RANDOM" or effect == "POLYMORPH")then
                        is_polymorphed = true
                        --EntityKill(child)
                    end
                end
            end
        end
    end
end

if(is_polymorphed == false)then
    EntitySetTransform(root, x, y, r, 0.5, 0.5)

    local children = EntityGetAllChildren(root)

    local children = EntityGetAllChildren(root)
    if(children ~= nil)then
        for k, child in pairs(children) do
            if(child ~= nil)then
                if(child ~= 0)then
                    if(EntityGetName(child) == "arm_r")then
                        local cx, cy, cr = EntityGetTransform(child)
                        EntitySetTransform(child, cx, cy, cr, 0.5, 0.5)
                    end
                end
            end
        end
    end

    local hotspots = EntityGetComponent(root, "HotspotComponent")
    if(hotspots ~= nil)then
        for k, hotspot in pairs(hotspots) do
            if(hotspot ~= nil)then
                if(hotspot ~= 0)then
                    local rx, ry = ComponentGetValue2(hotspot, "offset")
                    GlobalsSetValue(root.."_hotspot_"..hotspot.."_x", tostring(rx))
                    GlobalsSetValue(root.."_hotspot_"..hotspot.."_y", tostring(ry))
                    ComponentSetValue2(hotspot, "offset", rx / 2, ry / 2)
                end
            end
        end
    end

    local hitboxes = EntityGetComponent(root, "HitboxComponent")
    if(hitboxes ~= nil)then
        for k, hitbox in pairs(hitboxes) do
            if(hitbox ~= nil)then
                if(hitbox ~= 0)then

                    GlobalsSetValue(root.."_hitbox_"..hitbox.."_min_x", tostring(ComponentGetValue2(hitbox, "aabb_min_x")))
                    GlobalsSetValue(root.."_hitbox_"..hitbox.."_min_y", tostring(ComponentGetValue2(hitbox, "aabb_min_y")))
                    GlobalsSetValue(root.."_hitbox_"..hitbox.."_max_x", tostring(ComponentGetValue2(hitbox, "aabb_max_x")))
                    GlobalsSetValue(root.."_hitbox_"..hitbox.."_max_y", tostring(ComponentGetValue2(hitbox, "aabb_max_y")))


                    ComponentSetValue2(hitbox, "aabb_max_x", tonumber(ComponentGetValue2(hitbox, "aabb_max_x")) / 2)
                    ComponentSetValue2(hitbox, "aabb_max_y", tonumber(ComponentGetValue2(hitbox, "aabb_max_y")) / 2)
                    ComponentSetValue2(hitbox, "aabb_min_x", tonumber(ComponentGetValue2(hitbox, "aabb_min_x")) / 2)
                    ComponentSetValue2(hitbox, "aabb_min_y", tonumber(ComponentGetValue2(hitbox, "aabb_min_y")) / 2)
                end
            end
        end
    end

    local component = EntityGetFirstComponent(root, "CharacterDataComponent")
    if(component ~= nil)then
        if(component ~= 0)then

            GlobalsSetValue(root.."_collision_"..component.."_min_x", tostring(ComponentGetValue2(component, "collision_aabb_min_x")))
            GlobalsSetValue(root.."_collision_"..component.."_min_y", tostring(ComponentGetValue2(component, "collision_aabb_min_y")))
            GlobalsSetValue(root.."_collision_"..component.."_max_x", tostring(ComponentGetValue2(component, "collision_aabb_max_x")))
            GlobalsSetValue(root.."_collision_"..component.."_max_y", tostring(ComponentGetValue2(component, "collision_aabb_max_y")))
            
            ComponentSetValue2(component, "collision_aabb_min_x", tonumber(ComponentGetValue2(component, "collision_aabb_min_x") / 2))
            ComponentSetValue2(component, "collision_aabb_min_y", tonumber(ComponentGetValue2(component, "collision_aabb_min_y") / 2))
            ComponentSetValue2(component, "collision_aabb_max_x", tonumber(ComponentGetValue2(component, "collision_aabb_max_x") / 2))
            ComponentSetValue2(component, "collision_aabb_max_y", tonumber(ComponentGetValue2(component, "collision_aabb_max_y") / 2))
        end
    end

    --[[
    function TryAdjustDamageMultipliers( entity, resistances )
        local damage_models = EntityGetComponent( entity, "DamageModelComponent" );
        if damage_models ~= nil then
            for index,damage_model in pairs( damage_models ) do
                for damage_type,multiplier in pairs( resistances ) do
                    local resistance = tonumber(ComponentObjectGetValue( damage_model, "damage_multipliers", damage_type ));
                    resistance = resistance * multiplier;
                    ComponentObjectSetValue( damage_model, "damage_multipliers", damage_type, tostring(resistance) );
                end
            end
        end
    end

    TryAdjustDamageMultipliers( root, {
        ice = 2,
        electricity = 2,
        radioactive = 2,
        slice = 2,
        projectile = 2,
        healing = 2,
        physics_hit = 2,
        explosion = 2,
        poison = 2,
        melee = 2,
        drill = 2,
        fire = 2,
    });]]
end
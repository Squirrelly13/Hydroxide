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

    EntitySetTransform(root, x, y, r, 1, 1)

    local children = EntityGetAllChildren(root)
    if(children ~= nil)then
        for k, child in pairs(children) do
            if(child ~= nil)then
                if(child ~= 0)then
                    if(EntityGetName(child) == "arm_r")then
                        local cx, cy, cr = EntityGetTransform(child)
                        EntitySetTransform(child, cx, cy, cr, 1, 1)
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
                    if(GlobalsGetValue(root.."_hotspot_"..hotspot.."_x") ~= nil)then
                        local rx, ry = tonumber(GlobalsGetValue(root.."_hotspot_"..hotspot.."_x")), tonumber(GlobalsGetValue(root.."_hotspot_"..hotspot.."_y"))
                        ComponentSetValue2(hotspot, "offset", rx, ry)
                    end
                    
                end
            end
        end
    end
    local hitboxes = EntityGetComponent(root, "HitboxComponent")
    if(hitboxes ~= nil)then
        for k, hitbox in pairs(hitboxes) do
            if(hitbox ~= nil)then
                if(hitbox ~= 0)then


                    local coll1 = GlobalsGetValue(root.."_hitbox_"..hitbox.."_min_x")
                    local coll2 = GlobalsGetValue(root.."_hitbox_"..hitbox.."_min_y")
                    local coll3 = GlobalsGetValue(root.."_hitbox_"..hitbox.."_max_x")
                    local coll4 = GlobalsGetValue(root.."_hitbox_"..hitbox.."_max_y")



                    if(coll1 ~= nil)then
                        ComponentSetValue2(hitbox, "aabb_max_x", tonumber(col1))
                        ComponentSetValue2(hitbox, "aabb_max_y", tonumber(col2))
                        ComponentSetValue2(hitbox, "aabb_min_x", tonumber(col3))
                        ComponentSetValue2(hitbox, "aabb_min_y", tonumber(col4))
                    end
                end
            end
        end
    end

    local component = EntityGetFirstComponent(root, "CharacterDataComponent")

    if(component ~= nil)then
        if(component ~= 0)then

            local coll1 = GlobalsGetValue(root.."_collision_"..component.."_min_x")
            local coll2 = GlobalsGetValue(root.."_collision_"..component.."_min_y")
            local coll3 = GlobalsGetValue(root.."_collision_"..component.."_max_x")
            local coll4 = GlobalsGetValue(root.."_collision_"..component.."_max_y")
            if(coll1 ~= nil)then
                ComponentSetValue2(component, "collision_aabb_min_x", tonumber(col1))
                ComponentSetValue2(component, "collision_aabb_min_y", tonumber(col2))
                ComponentSetValue2(component, "collision_aabb_max_x", tonumber(col3))
                ComponentSetValue2(component, "collision_aabb_max_y", tonumber(col4))
            end
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
        ice = 0.5,
        electricity = 0.5,
        radioactive = 0.5,
        slice = 0.5,
        projectile = 0.5,
        healing = 0.5,
        physics_hit = 0.5,
        explosion = 0.5,
        poison = 0.5,
        melee = 0.5,
        drill = 0.5,
        fire = 0.5,
    });]]
end
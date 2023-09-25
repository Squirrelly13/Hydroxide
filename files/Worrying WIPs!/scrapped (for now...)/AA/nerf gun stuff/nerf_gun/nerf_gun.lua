entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
if(GlobalsGetValue("nerf_gun_secret", "nothing") == "nothing")then
    GlobalsSetValue("nerf_gun_secret", tostring(0))
end

nerf_secret_value = tonumber(GlobalsGetValue("nerf_gun_secret"))

nerf_secret_value = nerf_secret_value + 1

GlobalsSetValue("nerf_gun_secret", tostring(nerf_secret_value))

--GamePrint("Counter: "..nerf_secret_value)

if(nerf_secret_value > 30)then
    wands = EntityGetInRadius( x, y, 10 )
    for k, wand in pairs(wands)do
        components = EntityGetAllComponents( wand )
        for k, component in pairs(components)do
            component_type = ComponentGetTypeName( component )
            if(component_type == "SpriteComponent")then
                sprite = ComponentGetValue2(component, "image_file")
                if(sprite == "data/items_gfx/broken_wand.png")then
                    EntityKill(wand)
                    EntityLoad("mods/Hydroxide/files/entities/nerf_gun/nerf_gun.xml", x, y)
                    GlobalsSetValue("nerf_gun_secret", tostring(0))
                end
            end
        end
        --[[
        sprites = EntityGetFirstComponentIncludingDisabled(wand, "SpriteComponent")
        if(sprites ~= nil)then
            for k, sprite in pairs(sprites)do
                --GamePrint("eeeee")
                sprite = ComponentGetValue2(sprite, "image_file")
                if(sprite == "data/items_gfx/broken_wand.png")then
                    EntityKill(wand)
                    EntityLoad("mods/Hydroxide/files/entities/nerf_gun/nerf_gun.xml", x, y)
                    GlobalsSetValue("nerf_gun_secret", tostring(0))
                end
            end
        end
        ]]
    end
    EntityKill(entity_id)
end
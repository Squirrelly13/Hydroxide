dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

local root = EntityGetRootEntity( entity_id )

local x, y = EntityGetTransform(root)

local possible_wands = EntityGetInRadiusWithTag(x, y, 200, "item_physics")
if(possible_wands ~= nil)then
    for k, entity in pairs(possible_wands)do
        if(EntityHasTag(entity, "modified_broken") ~= true)then
            
            EntityAddTag(entity, "modified_broken")
            local physics_shape_components = EntityGetComponent(entity, "PhysicsImageShapeComponent")
            if(physics_shape_components ~= nil)then
                for k, component in pairs(physics_shape_components)do
                    local image = ComponentGetValue2(component, "image_file")
                    if(image == "data/items_gfx/broken_wand.png" )then

                        EntityAddComponent(entity, "LuaComponent", {
                            script_material_area_checker_success="mods/Hydroxide/files/scripts/misc/convert_to_nerf_gun.lua",
                        })
                                               
                        local area_checker = EntityAddComponent(entity, "MaterialAreaCheckerComponent", {
                            update_every_x_frame="20",
                            look_for_failure="0",  
                            material="AA_MAGICPLASTIC",
                            material2="item_box2d",
                            kill_after_message="0",
                        })
                        print("wand modified")
                        ComponentSetValue2(area_checker, "area_aabb", -4, -4, 4, 0)
                        ComponentSetValue2(area_checker, "_tags", "enabled_in_world")
                    end
                end
            end
        end
    end
end

EntityKill(GetUpdatedEntityID())
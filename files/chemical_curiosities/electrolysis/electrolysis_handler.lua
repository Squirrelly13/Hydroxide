dofile("mods/Hydroxide/files/chemical_curiosities/electrolysis/reactions.lua")

function electricity_receiver_switched( is_electrified )
    -- if pixel is receiving electricity
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(x + 32532, y + GameGetFrameNum())
    if(is_electrified)then
        local converter = EntityCreateNew("electrolysis_converter")
        EntitySetTransform(converter, x, y)
        EntityAddComponent2(converter, "LifetimeComponent", {
            lifetime=2
        })

        for _, reaction in ipairs(reactions)do
            if(Random(1, 100) <= reaction.probability)then
                -- check if from material is surrounded by []
                local from_material = reaction.input
                local to_material = reaction.output
                local input_is_tag = false
                if(string.sub(from_material, 1, 1) == "[")then
                    input_is_tag = true
                end

                if(input_is_tag)then
                    EntityAddComponent2(converter, "MagicConvertMaterialComponent", {
                        radius=3,
                        is_circle=true,
                        from_material_tag=from_material,
                        to_material=to_material,
                        loop=true
                    })
                else
                    EntityAddComponent2(converter, "MagicConvertMaterialComponent", {
                        radius=3,
                        from_material=from_material,
                        to_material=to_material,
                        is_circle=true,
                        loop=true
                    })
                end
            end
        end
    end
end
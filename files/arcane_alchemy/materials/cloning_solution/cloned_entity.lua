local entity_id = GetUpdatedEntityID()

for _, comp in ipairs(EntityGetComponent(entity_id, "VariableStorageComponent") or {}) do
	if ComponentGetValue2(comp, "name") == "aa_clone_data" then
        if not EntityGetIsAlive(ComponentGetValue2(comp, "value_int")) then
            EntityAddComponent2(entity_id, "LifetimeComponent", {
                lifetime = Random(300, 1320) --disappear after 5-22 seconds
            })
        end
    end
end


function init()
    local x,y = EntityGetTransform(entity_id)
    --EntityLoad("mods/Hydroxide/files/arcane_alchemy/materials/cloning_solution/clone_particle_effect.xml", x, y)
    SetRandomSeed(x,y)
    local sounds = {
        "player_projectiles/wall/destroy",      -- field_create_1
        "player_projectiles/touch_gold/create", -- field_create_2
        "player_projectiles/field/destroy",     -- field_create_3
    }
    GamePlaySound("data/audio/Desktop/projectiles.bank", sounds[Random(1, #sounds)], x, y)
end
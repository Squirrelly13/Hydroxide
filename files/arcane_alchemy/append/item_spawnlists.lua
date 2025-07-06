---@diagnostic disable: undefined-global
local function register_item(listname, weight, entity, offset) -- use this to register an item in spawn table
    if ( type( listname ) == "string" ) then
        local newmin = spawnlists[listname].rnd_max + 1
        local newmax = newmin + weight
        local tbl = {
            value_min = newmin,
            value_max = newmax,
            offset_y = offset,
            load_entity = entity
        }
        table.insert(spawnlists[listname].spawns, tbl)
        spawnlists[listname].rnd_max = newmax
    elseif ( type( listname ) == "table" ) then
        local newmin = listname.rnd_max + 1
        local newmax = newmin + weight
        local tbl = {
            value_min = newmin,
            value_max = newmax,
            offset_y = offset,
            load_entity = entity
        }
        table.insert(listname.spawns, tbl)
        listname.rnd_max = newmax
    end
end


local items = {
    {
        weight = 40,
        entity = "mods/Hydroxide/files/arcane_alchemy/items/vials/vial.xml",
        offset = -5
    },
}

if ModSettingGet("Hydroxide.TERROR_ENABLED") == true and ModSettingGet("Hydroxide.AA_ENABLED") ~= false then

    --table.insert(items, {weight = 1000000, entity = "mods/Hydroxide/files/arcane_alchemy/items/runestone_terror/runestone_terror.xml", offset = 0})

end


for i, v in ipairs(items) do
    --print("Registering item: " .. v.entity)
    register_item("potion_spawnlist", v.weight, v.entity, v.offset)
end
local chaotic = {
    PROJECTILES = {
    },
    STATIC_PROJECTILES = {
    },
    MODIFIERS = {
    },
    UTILITY ={
    }
}

dofile_once("data/scripts/gun/gun.lua")
for k, data in pairs(actions)do
    --print(data.id ~= nil and data.id or "nil :(")
    if(data.pandorium_ignore)then goto continue end
    if data.type == 0 then table.insert(chaotic.PROJECTILES, data.id) end
    if data.type == 1 then table.insert(chaotic.PROJECTILES, data.id) end
    if data.type == 2 then table.insert(chaotic.MODIFIERS, data.id) end
    if data.type == 6 then table.insert(chaotic.UTILITY, data.id) end
    ::continue::
end

return chaotic
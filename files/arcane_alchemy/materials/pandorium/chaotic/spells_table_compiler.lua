local chaotic = {
    MODIFIERS = {
    },
    PROJECTILES = {
    },
}

dofile_once("data/scripts/gun/gun.lua")
for k, data in pairs(actions)do
    --print(data.id ~= nil and data.id or "nil :(")
    if(data.pandorium_ignore)then goto continue end
    if data.type == 0 then table.insert(chaotic.PROJECTILES, data.id) 
        --print("Added \"" .. data.id .. "\" to chaotic.PROJECTILES at position " .. k .. ", verifying: " .. chaotic.PROJECTILES[k])
    end
    if data.type == 2 then table.insert(chaotic.MODIFIERS, data.id) 
        --print("Added \"" .. data.id .. "\" to chaotic.MODIFIERS at position " .. k .. ", verifying: " .. chaotic.MODIFIERS[k])
    end
    ::continue::
end

return chaotic
local chaotic = {
    PROJECTILES = {
    },
    MODIFIERS = {
    },
    UTILITY ={
    }
}

local include = {
    COPITH_SUMMON_HAMIS = true,
}

local exclude = {

}

function IsValidProjectile(spell_id)
    if true then return true end --comment this line out to toy around with the stuff above

    if exclude[spell_id] == true then return false end
    if include[spell_id] ~= true then return false end

    return true
end

dofile_once("data/scripts/gun/gun.lua")
for k, data in pairs(actions)do
    --print(data.id ~= nil and data.id or "nil :(")
    if(data.pandorium_ignore)then goto continue end
    if data.type == 0 and IsValidProjectile(data.id) then table.insert(chaotic.PROJECTILES, data.id) end
    if data.type == 1 and IsValidProjectile(data.id) then table.insert(chaotic.PROJECTILES, data.id) end
    if data.type == 2 then table.insert(chaotic.MODIFIERS, data.id) end
    if data.type == 6 then table.insert(chaotic.UTILITY, data.id) end
    ::continue::
end

return chaotic
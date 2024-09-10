local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()

local chaotic = {
    PROJECTILES = {
    },

    STATIC_PROJECTILES = {
    },

    MODIFIERS = {
    },

    MATERIALS = {
    },

    UTILITY ={
    },

    GLIMMERS = {
    },

    data = {
        month = month,
        day = day,
    },
}

local include = {
    COPITH_SUMMON_HAMIS = true,
}

local exclude = {
    ALL_NUKES = true,
    ALL_DISCS = true,
    ALL_ROCKETS = true,
    ALL_DEATHCROSSES = true,
    RANDOM_MODIFIER = true,
}

function IsValidProjectile(spell)
    --if true then return true end --crying and shaking rn, this line of code stumped me for like an hour cuz i forgot it existed :sob:

    if exclude[spell.id] == true then print(spell.id .. " has been EXCLUDED") return false
    --if include[spell.id] == true then print(spell.id .. " has been INCLUDED") return true end
    elseif not string.find(spell.spawn_level, "1,") then return false
    elseif string.find(spell.id, "NUKE") then return false
    end

    print(spell.id .. " IS VALID")
    return true
end

dofile_once("data/scripts/gun/gun.lua")
for k, data in pairs(actions)do
    --print(data.id ~= nil and data.id or "nil :(")
    if(data.pandorium_ignore)then goto continue end
    if data.type == 0 and IsValidProjectile(data) then table.insert(chaotic.PROJECTILES, data.id) end
    if data.type == 1 and IsValidProjectile(data) then table.insert(chaotic.STATIC_PROJECTILES, data.id) end
    if data.type == 2 and IsValidProjectile(data) then table.insert(chaotic.MODIFIERS, data.id) end
    if data.type == 4 and IsValidProjectile(data) then table.insert(chaotic.STATIC_PROJECTILES, data.id) end
    --if data.type == 6 and IsValidProjectile(data) then table.insert(chaotic.UTILITY, data.id) end
    if string.find(data.id, "COLOUR") then table.insert(chaotic.GLIMMERS, data.id) end
    ::continue::
end


for k,v in pairs(chaotic) do
    for a,b in pairs(v) do
        print(b .. " ADDED TO " .. k)
    end
    print("")
    print("")
end



return chaotic
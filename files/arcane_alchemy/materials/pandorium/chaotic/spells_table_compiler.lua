dofile_once("data/scripts/gun/gun.lua")

local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()

local chaotic = {
    PROJECTILES = {},
    STATIC_PROJECTILES = {},
    MODIFIERS = {},
    MATERIALS = {},
    UTILITY = {},
    GLIMMERS = {},

    data = {
        gimmer_chance = month == 6 and .6 or .05,
    },
}

local exclude = {
    NUKE = true,
    NUKE_GIGA = true,
    BOMB_HOLY = true,
    ALL_NUKES = true,
    ALL_DISCS = true,
    ALL_ROCKETS = true,
    ALL_DEATHCROSSES = true,
    RANDOM_MODIFIER = true,
    FIREBALL_RAY_ENEMY = true, --lame-ass spells why do they last a minute
    LIGHTNING_RAY_ENEMY = true,
    TENTACLE_RAY_ENEMY = true,
    ORBIT_SHOT = true, --does nothing but spam errors in logs cuz it doesnt bother checking for mWhoShot

    APOTHEOSIS_NUKE_RAY = true,
    APOTHEOSIS_NUKE_RAY_ENEMY = true,

    OVERCAST_FOLLOW = true, --modifier that drags player to projectile, doesnt check for caster
}


function IsValidProjectile(spell)
    --if true then return true end --crying and shaking rn, this line of code stumped me for like an hour cuz i forgot it existed :sob:

    if ("," .. spell.spawn_level .. ","):find(",[012],") then --[[print(spell.id .. " IS VALID")]] return true end
    --fancy string shenanigans here and in the modifier script grabbed from Nathan and other lovel ppl from noitacord
    return false
end

function IsValidModifier(spell)
    if string.find(spell.id, "COLOUR") or spell.is_glimmer then table.insert(chaotic.GLIMMERS, spell.id) end
    if ("," .. spell.spawn_level .. ","):find(",[012345],") then --[[print(spell.id .. " IS VALID")]] return true end

    return false
end

for k, data in pairs(actions)do
    if data.pandorium_ignore or data.ai_never_uses or exclude[data.id] then goto continue end

    if data.type == 0 and IsValidProjectile(data) then table.insert(chaotic.PROJECTILES, data.id)
    elseif data.type == 1 and IsValidProjectile(data) then table.insert(chaotic.STATIC_PROJECTILES, data.id)
    elseif data.type == 2 and IsValidModifier(data) then table.insert(chaotic.MODIFIERS, data.id)
    elseif data.type == 4 and IsValidProjectile(data) then table.insert(chaotic.STATIC_PROJECTILES, data.id)
    end
    --if data.type == 6 and IsValidProjectile(data) then table.insert(chaotic.UTILITY, data.id) end
    ::continue::
end

--[[ handy debugging print-out
for k,v in pairs(chaotic) do
    for a,b in pairs(v) do
        print(b .. " ADDED TO " .. k)
    end
end--]]


local include = {
    COPITH_SUMMON_HAMIS = true,
}

return chaotic
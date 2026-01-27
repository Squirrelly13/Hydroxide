---@type nxml
local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua")
nxml.error_handler = function() end


--s2p fix for cpand and just in general
ModTextFileSetContent("data/scripts/projectiles/spells_to_power.lua",
    "local ComponentObjectSetValue = ComponentObjectSetValue2\n\n" ..
    ModTextFileGetContent("data/scripts/projectiles/spells_to_power.lua")
)


for xml in nxml.edit_file("data/entities/items/pickup/greed_curse.xml") do
    xml.attr.name = xml.attr.name or "curse_of_greed"
end
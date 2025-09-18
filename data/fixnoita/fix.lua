ModTextFileSetContent("data/scripts/projectiles/spells_to_power.lua",
    ModTextFileGetContent("data/scripts/projectiles/spells_to_power.lua")
        :gsub("ComponentObjectSetValue(", "ComponentObjectSetValue2(")
)
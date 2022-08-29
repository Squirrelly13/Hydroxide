function AddComponent(entity_file, component)
    local ent = ModTextFileGetContent(entity_file)
    local comp = ModTextFileGetContent(component)
    ent = string.gsub(ent, "(</Entity>)", comp .. "\n%1\n")
    ModTextFileSetContent(entity_file, ent)
end

local electricity_entities = {	"data/entities/misc/electricity.xml", 
								"data/entities/misc/electricity_weak.xml", 
								"data/entities/misc/electricity_medium.xml", 
								"data/entities/misc/arc_electric.xml",
								"data/entities/projectiles/lightning.xml",
								"data/entities/projectiles/lightning_thunderburst.xml",
								"data/entities/projectiles/lightning_thunderskull.xml",
								"data/entities/projectiles/thunderburst_thundermage.xml",
								"data/entities/projectiles/deck/lightning.xml",
								"data/entities/projectiles/deck/lightning_extra_arcs.xml",
								"data/entities/projectiles/deck/lightning_weak.xml",
								"data/entities/projectiles/deck/thunder_blast.xml",
								}

for k, v in ipairs(electricity_entities) do
    AddComponent(v, "mods/Hydroxide/files/electrolysis/electrolysis.xml")
end


local projectiles = { "data/entities/base_projectile.xml" }

for k, v in ipairs(projectiles) do
	AddComponent(v, "mods/Hydroxide/files/electrolysis/electrolysis.xml")
end
dofile_once("data/scripts/lib/utilities.lua")

function InjectOre(biomefile, orefile)
    local pattern = "(<[%s]-Materials[%s]-name=\"[^\"]*\"[%s]->)"
    local biome = ModTextFileGetContent(biomefile)
    local ore = ModTextFileGetContent(orefile)
    biome = string.gsub(biome, pattern, "%1\n" .. ore)
    ModTextFileSetContent(biomefile, biome)
end

function getDigit(num, digit)
	local n = 10 ^ digit
	local n1 = 10 ^ (digit - 1)
	return math.floor((num % n) / n1)
end


local rand = 0


rand = math.random(1,10)
if (rand < 5) then 
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt1.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt1.xml")

	else
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver1.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver1.xml")
end

rand = math.random(1,10)
if (rand < 5) then 
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver2.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver2.xml")

	else
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt2.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt2.xml")
end


-- coal pits --
--fix

rand = math.random(1,10)

if (rand <= 5) then 
	InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_crystals.xml")
else
	InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_toxic.xml")
end





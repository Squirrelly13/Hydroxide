function InjectOre(biomefile, orefile)
    local pattern = "(<[%s]-Materials[%s]-name=\"[^\"]*\"[%s]->)"
    local biome = ModTextFileGetContent(biomefile)
    local ore = ModTextFileGetContent(orefile)
    biome = string.gsub(biome, pattern, "%1\n" .. ore)
    ModTextFileSetContent(biomefile, biome)
end


local seed = 0
local rand = 0

seed = StatsGetValue("world_seed")
rand = 0
function getDigit(num, digit)
	local n = 10 ^ digit
	local n1 = 10 ^ (digit - 1)
	return math.floor((num % n) / n1)
end

	--InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_toxic.xml")

-- mines --
math.randomseed(seed + 11)
rand = math.random(1,10)
if (rand < 5) then 
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt1.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt1.xml")

	else
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver1.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver1.xml")
end

math.randomseed(seed + 12)
rand = math.random(1,10)
if (rand < 5) then 
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt2.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_cobalt2.xml")
	else
	InjectOre("data/biome/coalmine.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver2.xml")
	InjectOre("data/biome/coalmine_alt.xml", "mods/Hydroxide/files/oreGen/ores_metals_silver2.xml")
end


-- coal pits --

rand = getDigit(seed, 2)
if (rand <= 1) then 
	InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_crystals.xml")
elseif (rand <= 2 ) then
	InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_toxic.xml")
elseif (rand <= 5 ) then
	InjectOre("data/biome/excavationsite.xml", "mods/Hydroxide/files/oreGen/ores_excavationsite_metal.xml")
end





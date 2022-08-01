dofile_once("data/scripts/lib/utilities.lua")

SetRandomSeed( ({GameGetDateAndTimeLocal()})[5], ({GameGetDateAndTimeLocal()})[6])

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

ore_types = {
	{	probability = 1.000, "random_metals",	},
	{	probability = 0.300, "toxic",			},
	{	probability = 0.400, "crystals"			},
	{	probability = 0.050, "concrete",		},
	{	probability = 0.005, "radioactive",		},
	{ 	probability = 0.100, "toxic_ice",		},
	{ 	probability = 0.100, "frozen_meat",		},
	
	
}

ores_weighted = {
	{	probability = 1.0000, "random_metals" 	},
	{	probability = 0.3000, "toxic" 			},
	{	probability = 0.1000, "crystals"		},
	{	probability = 0.2500, "concrete"		},
}

metals_1 = {
	{	ore_type = "metals_cobalt1",	},
	{	ore_type = "metals_iron1",		},
	{	ore_type = "metals_preskite1",	},
	{	ore_type = "metals_silver1",	},
	{	ore_type = "metals_brass1",		},
}

metals_2 = {
	{	ore_type = "metals_cobalt2",	},
	{	ore_type = "metals_iron2",		},
	{	ore_type = "metals_preskite2",	},
	{	ore_type = "metals_silver2",	},
	{	ore_type = "metals_brass2",		},
}

ore_coalmines = {
	{	probability = 1.000, "random_metals",	},
	{	probability = 0.100, "toxic",			},
	{	probability = 0.100, "crystals"			},
}

ore_excavationsite = {
	{	probability = 1.000, "random_metals",	},
	{	probability = 0.400, "toxic",			},
	{	probability = 0.100, "crystals"			},
}

metals_excavationsite = {
	{	ore_type = "metals_cobalt2",	},
	{	ore_type = "metals_iron2",		},
	{	ore_type = "metals_preskite2",	},
	{	ore_type = "metals_silver2",	},
	{	ore_type = "metals_brass2",		},
	{	ore_type = "metals_gold",		},
	{	ore_type = "metals_cobalt2",	},
	{	ore_type = "metals_iron2",		},
	{	ore_type = "metals_preskite2",	},
	{	ore_type = "metals_silver2",	},
	{	ore_type = "metals_brass2",		},
}

ore_snowcave = {
	{ 	probability = 0.700, "random_metals",	},
	{ 	probability = 0.800, "toxic_ice",		},
	{ 	probability = 0.600, "frozen_meat",		},
}
	

ore_snowcastle = {
	{	probability = 0.800, "concrete" 		},
	{	probability = 0.600, "toxic"			},
	{	probability = 0.700, "random_metals"	},
}


function addOresToBiome(biome, ore_list)
	
	
	local rnd = random_create(9123,58925+({GameGetDateAndTimeLocal()})[5] )
	local oreType = tostring(pick_random_from_table_weighted( rnd, ore_list)[1])
	print ("oretype: " .. oreType)
	
	local ores = ""
	
	if (oreType == "random_metals") then
		
		local metal1 = random_from_array(metals_1)
		local metal2 = random_from_array(metals_2)
		
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal1.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal2.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	else 
		ores = "mods/Hydroxide/files/oreGen/ores_" .. oreType .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	end
end

function addOresToBiomeMetals(biome, ore_list, metal_list_1, metal_list_2) --most biomes use the normal metal lists, but if i want to make a biome have other metal lists, this is helpful

	local rnd = random_create(9123,58925+GameGetFrameNum() )
	local oreType = tostring(pick_random_from_table_weighted( rnd, ore_list)[1])
	print ("oretype: " .. oreType)
	
	local ores = ""
	
	if (oreType == "random_metals") then
		
		local metal1 = random_from_array(metal_list_1)
		local metal2 = random_from_array(metal_list_2)
		
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal1.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal2.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	else 
		ores = "mods/Hydroxide/files/oreGen/ores_" .. oreType .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	end
end

print("minute: " .. ({GameGetDateAndTimeLocal()})[5] )

addOresToBiome("data/biome/coalmine.xml", ore_coalmines)
addOresToBiome("data/biome/coalmine_alt.xml", ore_coalmines)

addOresToBiomeMetals("data/biome/excavationsite.xml", ore_excavationsite, metals_1, metals_excavationsite) 

addOresToBiome("data/biome/snowcave.xml", ore_snowcave) -- give custom list

addOresToBiome("data/biome/snowcastle.xml", ore_snowcastle)

addOresToBiome("data/biome/rainforest.xml", ore_types)	-- give custom list

addOresToBiome("data/biome/fungicave.xml", ore_types) 

addOresToBiome("data/biome/vault.xml", ore_types)


addOresToBiome("data/biome/crypt.xml", ore_types) --add a ton of potions to this
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
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "toxic",			},
	{	ore_type 	= "crystals"		},
	{	ore_type	= "concrete",		},
--	{	ore_type	= "radioactive",	},
}

ore_coalmines = {
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "random_metals",	},
	{	ore_type 	= "random_metals",	},
	{	ore_type	= "concrete",		},
	{	ore_type 	= "toxic",			},
	{	ore_type 	= "crystals"		},
	{	ore_type	= "toxic",			},
	{	ore_type	= "crystals",		},
}

ore_snowcastle = {
	{	ore_type	= "concrete" 		},
	{	ore_type	= "toxic"			},
	{	ore_type 	= "random_metals"	},
	{	ore_type 	= "random_metals"	},
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

function addOresToBiome(biome, ore_list)

	local oreType = random_from_array(ore_list)
	print ("oretype: " .. oreType.ore_type)
	
	local ores = ""
	
	if (oreType.ore_type == "random_metals") then
		
		local metal1 = random_from_array(metals_1)
		local metal2 = random_from_array(metals_2)
		
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal1.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal2.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	else 
		ores = "mods/Hydroxide/files/oreGen/ores_" .. oreType.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	end
end
function addOresToBiomeMetals(biome, ore_list, metal_list_1, metal_list_2) --most biomes use the normal metal lists, but if i want to make a biome have other metal lists, this is helpful

	local oreType = random_from_array(ore_list)
	print ("oretype: " .. oreType.ore_type)
	
	local ores = ""
	
	if (oreType.ore_type == "random_metals") then
		
		local metal1 = random_from_array(metals_list_1)
		local metal2 = random_from_array(metals_list_2)
		
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal1.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
		ores = "mods/Hydroxide/files/oreGen/ores_" .. metal2.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	else 
		ores = "mods/Hydroxide/files/oreGen/ores_" .. oreType.ore_type .. ".xml"
		print("adding " .. ores .. " to " .. biome)
		InjectOre(biome, ores)
	end
end

print("minute: " .. ({GameGetDateAndTimeLocal()})[5] )

addOresToBiome("data/biome/coalmine.xml", ore_coalmines)
addOresToBiome("data/biome/coalmine_alt.xml", ore_coalmines)

addOresToBiome("data/biome/excavationsite.xml", ore_types)

addOresToBiome("data/biome/snowcave.xml", ore_types) -- give custom list

addOresToBiome("data/biome/snowcastle.xml", ore_snowcastle)

addOresToBiome("data/biome/rainforest.xml", ore_types)	-- give custom list

addOresToBiome("data/biome/fungicave.xml", ore_types)

addOresToBiome("data/biome/vault.xml", ore_types)


addOresToBiome("data/biome/crypt.xml", ore_types)
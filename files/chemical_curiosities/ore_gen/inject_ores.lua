dofile_once("data/scripts/lib/utilities.lua")

local world_seed = tonumber(StatsGetValue("world_seed")) or 1
SetRandomSeed( world_seed, world_seed )

function InjectOre(biomefile, orefile)
	local biome = ModTextFileGetContent(biomefile)
    local ore = ModTextFileGetContent(orefile)
	biome=biome:gsub("<MaterialComponent",ore.."\n%1",1)
	ModTextFileSetContent(biomefile,biome)
end

--mostly to reduce space.
local ore_root_dir="mods/Hydroxide/files/chemical_curiosities/ore_gen/ores/"

--standard materials that aren't interesting on their own.
orelist_mundane={
	ore_root_dir.."ores_metals_brass1.xml",
	ore_root_dir.."ores_metals_brass2.xml",
	ore_root_dir.."ores_metals_iron1.xml",
	ore_root_dir.."ores_metals_iron2.xml",
}

--metals
orelist_metals_common={
	ore_root_dir.."ores_metals_brass1.xml",
	ore_root_dir.."ores_metals_brass2.xml",
	ore_root_dir.."ores_metals_cobalt1.xml",
	ore_root_dir.."ores_metals_cobalt2.xml",
	ore_root_dir.."ores_metals_iron1.xml",
	ore_root_dir.."ores_metals_iron2.xml",
	ore_root_dir.."ores_metals_preskite1.xml",
	ore_root_dir.."ores_metals_preskite2.xml",
}

--metals, but rare
orelist_metals_rare={
	ore_root_dir.."ores_metals_shock1.xml",
	ore_root_dir.."ores_metals_shock2.xml",
	ore_root_dir.."ores_metals_silver1.xml",
	ore_root_dir.."ores_metals_silver2.xml",
	ore_root_dir.."ores_metals_gold.xml",
	--ore_root_dir.."ores_radioactive.xml",
}

--cold stuff
orelist_cold={
	ore_root_dir.."ores_frozen_meat.xml",
	ore_root_dir.."ores_toxic_ice.xml",
}

--idk
orelist_misc={
	ore_root_dir.."ores_lava.xml",
	ore_root_dir.."ores_toxic.xml",
}

--magic stuff
orelist_magical={
	ore_root_dir.."ores_antimagic.xml",
	ore_root_dir.."ores_arborium.xml",
	ore_root_dir.."ores_crystals.xml",
}

--stuff that may be harmful.
orelist_dangerous={
	ore_root_dir.."ores_crystals.xml",
	ore_root_dir.."ores_lava.xml",
	ore_root_dir.."ores_toxic.xml",
	--ore_root_dir.."ores_radioactive.xml",
}

--plants. mhm.
orelist_biological={
	ore_root_dir.."ores_toxic.xml",
	ore_root_dir.."ores_arborium.xml",
	ore_root_dir.."ores_arborium.xml",
}

if ModSettingGet("Hydroxide.AA_BLOOMIUM") and ModSettingGet("Hydroxide.AA_BLOOMIUM_VEINS") then
	orelist_magical[#orelist_magical+1]=ore_root_dir.."ores_bloom.xml"
	orelist_biological[#orelist_biological+1]=ore_root_dir.."ores_bloom.xml"
	orelist_biological[#orelist_biological+1]=ore_root_dir.."ores_bloom.xml"
end


biomelist_coalmines={
	orelist_metals_common,
	orelist_metals_common,
	orelist_metals_rare,
	orelist_biological,
	orelist_dangerous,
	orelist_mundane,
	orelist_mundane,
}

biomelist_excavationsite={
	orelist_metals_common,
	orelist_metals_common,
	orelist_metals_rare,
	orelist_metals_rare,
	orelist_metals_rare,
	orelist_misc,
	orelist_misc,
	orelist_dangerous,
	orelist_mundane,
}

biomelist_snowcave={
	orelist_metals_common,
	orelist_metals_rare,
	orelist_cold,
	orelist_cold,
	orelist_cold,
	ore_root_dir.."ores_crystals.xml",
	ore_root_dir.."ores_crystals.xml",
}

biomelist_snowcastle={
	orelist_metals_common,
	orelist_metals_rare,
	orelist_cold,
	orelist_cold,
	ore_root_dir.."ores_crystals.xml",
	orelist_magical,
	orelist_magical,
	ore_root_dir.."ores_concrete.xml",
	ore_root_dir.."ores_concrete.xml",
	ore_root_dir.."ores_concrete.xml",
}

biomelist_rainforest={
	orelist_metals_common,
	orelist_metals_common,
	orelist_metals_rare,
	orelist_metals_rare,
	orelist_biological,
	orelist_biological,
	orelist_biological,
	orelist_magical,
	orelist_magical,
}

biomelist_vault={
	orelist_metals_common,
	orelist_metals_common,
	orelist_metals_rare,
	orelist_metals_rare,
	ore_root_dir.."ores_concrete.xml",
	ore_root_dir.."ores_concrete.xml",
	orelist_dangerous,
	orelist_dangerous,
	orelist_cold,
	orelist_magical,
}

biomelist_fungiforest={
	orelist_biological,
	orelist_magical,
}

biomelist_crypt={
	orelist_metals_common,
	orelist_metals_common,
	orelist_metals_rare,
	orelist_magical,
	orelist_magical,
	orelist_dangerous,
}

biomelist_wizardcave={
	orelist_magical,
	orelist_magical,
	orelist_dangerous,
	orelist_metals_common,
	orelist_metals_rare,
}

biomelist_sandcave={
	orelist_metals_common,
	orelist_metals_rare,
}


function addOresToBiome(biome, ore_list, num_ores_to_add)
	local eligable_mats={} --generate a list of all eligable ores.
	for i=1,#ore_list do
		local mat=ore_list[i]
		if type(mat)=="table" then --supports mixed tables/string elements
			for i=1,#mat do
				eligable_mats[#eligable_mats+1]=mat[i]
			end
		else
			eligable_mats[#eligable_mats+1]=mat
		end
	end
	--once we have, start random selection.
	while num_ores_to_add>0 do 
		if #eligable_mats<1 then return end -- if no mats, exit.
		num_ores_to_add=num_ores_to_add-1
		local idx=Random(1,#eligable_mats)
		InjectOre(biome, eligable_mats[idx] )
		table.remove(eligable_mats,idx) --remove the index we just added, to promote more ore variety.
	end
end

addOresToBiome("data/biome/coalmine.xml",biomelist_coalmines,4)
addOresToBiome("data/biome/coalmine_alt.xml",biomelist_coalmines,4)

addOresToBiome("data/biome/excavationsite.xml",biomelist_excavationsite,3)

addOresToBiome("data/biome/snowcave.xml",biomelist_snowcave,3)
addOresToBiome("data/biome/winter.xml",biomelist_snowcave,3)
addOresToBiome("data/biome/winter_caves.xml",biomelist_snowcave,3)

addOresToBiome("data/biome/snowcastle.xml",biomelist_snowcastle,4)

addOresToBiome("data/biome/rainforest.xml",biomelist_rainforest,6)

addOresToBiome("data/biome/fungicave.xml",biomelist_fungiforest,5)

addOresToBiome("data/biome/vault.xml",biomelist_vault,4)
addOresToBiome("data/biome/vault_frozen.xml",biomelist_vault,4)
addOresToBiome("data/biome/the_end.xml",biomelist_vault,3)

addOresToBiome("data/biome/crypt.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid_entrance.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid_hallway.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid_left.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid_right.xml",biomelist_crypt,3)
addOresToBiome("data/biome/pyramid_top.xml",biomelist_crypt,3)

addOresToBiome("data/biome/wizardcave.xml",biomelist_wizardcave,5)
addOresToBiome("data/biome/wandcave.xml",biomelist_wizardcave,3)

addOresToBiome("data/biome/sandcave.xml", biomelist_sandcave,4)

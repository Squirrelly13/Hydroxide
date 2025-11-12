--note: this fucking file is so horrid and i think its my fault, ill fix it at some point -UserK
dofile_once("mods/Hydroxide/lib/squirreltilities.lua")

MaterialGroups = {
    water = {
        name = "water",
        materials = {
            "water",
            "water_static",
            "water_salt",
            "water_ice",
            "ice_static",
            "ice_glass",
            "ice_acid_static",
            "ice_acid_glass",
            "ice_cold_static",
            "ice_cold_glass",
            "ice_radioactive_static",
            "ice_radioactive_glass",
            "ice_poison_static",
            "ice_poison_glass",
            "ice_b2",
            "lava",
        }
    },
    slime = {
        name = "slimes and oils",
        materials = {
            "oil",
            "swamp",
            "peat",
            "slime",
            "cc_grease",
            "cc_ferrine",
        }
    },
    organic = {
        name = "organics",
        materials = {
            "blood",
            "blood_fungi",
            "blood_cold",
            "blood_worm",
            "cc_devouring_moss",
            "cc_ferrine",
            "meat",
            "rotten_meat",
            "cc_frozen_meat",
        }
    },
    potions = {
        name = "potions",
        materials = {
            "cc_persistine",
            "magic_liquid_polymorph",
            "magic_liquid_unstable_polymorph",
            "magic_liquid_berserk",
            "magic_liquid_charm",
            "magic_liquid_invisibility","cc_sparkling_liquid",
            "cc_slicing_liquid",
            "cc_glittering_liquid",
            "cc_veilium",
            "cc_deceleratium",
            "cc_heftium",
            "cc_stillium",
            "cc_explode_player",
        }
    },
    metals = {
        name = "metals",
        materials = {
            "gold",
            "silver",
            "brass",
            "copper",
            "diamond",
            "steel",
            "cc_cobalt",
            "cc_iron",
            "cc_preskite",
            "steel_sand",
            "steel_rust",
            "steelfrost_static",
            "steel_static",
            "steelmoss_static",
            "steel_grey_static",
            "steelfrost_static",
            "steelpipe_static",
        }
    },
    gas = {
        name = "gasses",
        materials = {
            "acid_gas",
            "acid_gas_static",
            "poison_gas",
            "fungal_gas",
            "radioactive_gas",
            "radioactive_gas_static",
            "steam",
            "smoke",
            "cc_methane",
            "cc_hydroxide_gas",
            "cloud",
        }
    },
    rock = {
        name = "rock",
        materials = {
            "rock_static",
            "rock_static_glow",
            "rock_static_purple",
            "rock_static_noedge",
            "rock_static_intro",
            "rock_static_intro_breakable",
            "rock_static_wet",
            "rock_static_grey",
            "snowrock_static",
            "rock_vault",
            "concrete_collapsed",
        }
    },
    poison = {
        name = "poisons and toxins",
        materials = { "acid",
            "cc_hydroxide",
            "radioactive_liquid",
            "poison",
            "material_darkness",
            "alcohol",
            "cc_radioactive_waste",
        }
    },
    cold = {
        name = "ice and snow",
        materials = {
            "ice_static",
            "ice_glass",
            "ice_acid_static",
            "ice_acid_glass",
            "ice_cold_static",
            "ice_cold_glass",
            "ice_radioactive_static",
            "ice_radioactive_glass",
            "ice_poison_static",
            "ice_poison_glass",
            "slush",
            "snow",
            "snow_sticky",
            "ice_ceiling",
            "ice_b2",
            "snow_b2",
            "snow_static",
        }
    },
    plants = {
        name = "plants",
        materials = { "soil_lush",
            "sand_static_rainforest",
            "wood_loose",
            "wood_prop_durable",
            "wood_prop",
            "grass_loose",
            "cactus",
            "wood",
            "wood_player_b2",
            "wood_player",
            "fungus_loose_trippy",
            "fungus_loose_green",
            "fungus_loose",
            "fungi",
            "fungus_powder",
            "grass",
            "wood_static",
            "wood_static_vertical",
            "moss",
        }
    },
    brickwork = {
        name = "brickwork",
        materials = { "templebrick_static",
            "templebrick_noedge_static",
            "templebrick_static_soft",
            "templebrick_thick_static",
            "templebrick_thick_static_noedge",
            "templebrickdark_static",
        }
    },
}

function AppendMaterialGroups(t)
    for id, group in pairs(t) do
        if MaterialGroups[id] then
            local target_list = MaterialGroups[id].materials
            for _, material in ipairs(group.materials) do
                target_list[#target_list+1] = material
            end
        else
            MaterialGroups[id] = group
        end
    end
end

BiomeLists = {
    default = {
        water = 1,
        slime = 1,
        organic = 1,
        potions = 1,
        metals = 1,
        gas = 1,
        rock = 1,
        poison = 1,
        cold = 1,
        plants = 1,
        brickwork = 1,
    },
    biome_coalmine = { --mines
        water = .7,
        organic = .2,
        potions = .3,
        metals = .4,
        rock = 1,
        poison = .2,
        plants = .9,
    },
    biome_excavationsite = { --Coal Pits
        water = .7,
        slime = .5,
        organic = .2,
        potions = .2,
        metals = .2,
        rock = .9,
        plants = 1.2,
    },
    biome_snowcave = { --Snowy Depths
        water = 1,
        slime = .3,
        organic = .3,
        potions = .1,
        gas = .6,
        rock = .4,
    },
    biome_snowcastle = { --Hiisi Base
        water = .7,
        slime = .6,
        organic = .5,
        potions = .2,
        metals = .6,
        gas = .6,
        rock = .4,
        poison = .3,
    },
    biome_rainforest = { --Underground Jungle
        water = .5,
        slime = .4,
        organic = .7,
        gas = .3,
        poison = .7,
        plants = .5,
    },
    biome_vault = { --The Vault
        water = .4,
        slime = .6,
        organic = .3,
        metals = .9,
        gas = .7,
        rock = .4,
        poison = .5,
    },
    biome_crypt = { --Temple of the Art
        water = .8,
        slime = .6,
        organic = .3,
        potions = .1,
        rock = .3,
        brickwork = .5,
    },
    biome_gold = {
        metals = 1,
    }
    --Desert = {},
}
BiomeLists.biome_coalmine_alt = BiomeLists.biome_coalmine

function AppendBiomeLists(t)
    for biome, weights in pairs(t) do
        if BiomeLists[biome] then
            for key, value in pairs(weights) do
                BiomeLists[biome][key] = value
            end
        else
            BiomeLists[biome] = weights
        end
    end
end

MaterialsTo = { --bandaid fix probabilities cuz i need to push this patch out rq and i dont wanna deal with this rn lmao
    { probability = 1, "water" },
    { probability = 1, "oil" },
    { probability = 1, "blood_cold" },
    { probability = 1, "blood_worm" },
    { probability = 1, "rotten_meat" },
    { probability = 1, "cc_glittering_liquid" },
    { probability = .001, "gold" },
    { probability = 1, "silver" },
    { probability = 1, "copper" },
    { probability = 1, "acid_gas" },
    { probability = .5, "acid" },
    { probability = .5, "cc_hydroxide" },
    { probability = 1, "alcohol" },
    { probability = 1, "wood" },
    { probability = 1, "fungi" },
    { probability = 1, "rock_static" },
}

for _, file in ipairs(ModLuaFileGetAppends("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.lua")) do dofile_once(file) end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

EntityAddComponent2(entity_id, "AudioComponent", {
    file="data/audio/Desktop/projectiles.bank",
    event_root="player_projectiles/meteor",
    set_latest_event_position=true
});

local frame = GameGetFrameNum()
SetRandomSeed(89346, 42345-frame)

local biome = BiomeMapGetName(x, y)
local targets = {}
for group, probability in pairs(BiomeLists[biome] or BiomeLists.default) do
    targets[#targets+1] = {group, probability = probability}
end

local from = MaterialGroups[RandomFromTable(targets)[1]].materials
local to = RandomFromTable(MaterialsTo)[1]
if not (to and from) then return end --if not to and fro', off to the nether realm ye shall go

--GamePrint("shifted " .. from.name .. " to " .. toname)
LocalShift(200, from, to, x, y)
return
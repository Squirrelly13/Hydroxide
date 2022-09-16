dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

dofile_once("data/scripts/magic/fungal_shift.lua")

materials_from = {}

water 	=	{ probability = 0.4, name = "water", materials = { "water", "water_static", "water_salt", "water_ice" }}
slime  	=	{ probability = 0.4, name = "oils and slimes", materials = { "oil", "swamp", "peat", "slime", "grease", "iron_ingredient", "rice" }}
organic =	{ probability = 0.5, name = "organics", materials = { "blood", "blood_fungi", "blood_cold", "blood_worm", "AA_MAT_HUNGRY_SLIME", "AA_MAT_HUNGRY_SLIME_GROWING","devouringMoss", "iron_ingredient", "meat", "rotten_meat", "frozen_meat", "rice" }}
potions =	{ probability = 0.3, name = "potions", materials = { "ferrineSkin", "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_berserk", "magic_liquid_charm", "magic_liquid_invisibility","sparkLiquid", "sliceLiquid", "glitteringLiquid", "potionBlindness", "magic_liquid_movement_slower", "AA_ICEFIRE", "magic_liquid_slower_levitation", "magic_liquid_slower_levitation_and_movement", "explodePlayer", "AA_MAT_ARBORIUM", "AA_LOVE", "AA_MAT_REPULTIUM", "AA_MAT_NEUTRAL_POTION", "AA_CLONE", "AA_GRAVLIQUID", "AA_LIQUID_ROCK", "AA_PATH", "rice" }}
metals 	=	{ probability = 0.8, name = "metals", materials = { "gold", "silver", "brass", "copper", "diamond", "steel", "cobalt", "iron", "preskite", "steel_sand", "steel_rust", "steelfrost_static", "steel_static", "steelmoss_static", "steel_grey_static", "steelfrost_static", "steelpipe_static"}}
gas		=	{ probability = 0.8, name = "gasses", materials = { "acid_gas", "acid_gas_static", "poison_gas", "fungal_gas", "radioactive_gas", "radioactive_gas_static", "steam", "smoke", "AA_MAT_POTION_GAS","methane", "hydroxide_gas", "cloud" }}
rock 	=	{ probability = 0.8, name = "rock", materials = { "rock_static", "rock_static_glow", "rock_static_purple", "rock_static_noedge", "rock_static_intro", "rock_static_intro_breakable", "rock_static_wet", "rock_static_grey", "snowrock_static", "rock_vault", "concrete_collapsed", "AA_LIQUID_ROCK" } }
poison 	= 	{ probability = 0.5, name = "poisons and toxins", materials = { "acid", "hydroxide", "radioactive_liquid", "poison", "material_darkness", "alcohol", "radiationWaste" }}
cold	=	{ probability = 0.8, name = "ice and snow", materials = { "ice_static", "ice_glass", "ice_acid_static", "ice_acid_glass", "ice_cold_static", "ice_cold_glass", "ice_radioactive_static", "ice_radioactive_glass", "ice_poison_static", "ice_poison_glass", "slush", "snow", "snow_sticky", "ice_ceiling", "ice_b2", "snow_b2", "snow_static" }}
plants  =	{ probability = 0.8, name = "plants", materials = { "soil_lush", "sand_static_rainforest", "wood_loose", "wood_prop_durable", "wood_prop", "grass_loose", "cactus", "wood", "wood_player_b2", "wood_player", "fungus_loose_trippy", "fungus_loose_green", "fungus_loose", "fungi", "fungus_powder", "grass", "wood_static", "wood_static_vertical", "moss"}}
brickwork = { probability = 1.0, name = "brickwork", materials = { "templebrick_static", "templebrick_noedge_static", "templebrick_static_soft", "templebrick_thick_static", "templebrick_thick_static_noedge", "templebrickdark_static"}}



local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local biome = BiomeMapGetName(pos_x, pos_y)
if biome ~= "_EMPTY_" then
	biome = GameTextGet(biome)
end

if (biome == "mines") or (biome == "collapsed mines") then
	table.insert(materials_from, water);
	table.insert(materials_from, plants);
	table.insert(materials_from, rock);
	table.insert(materials_from, metals);
	table.insert(materials_from, slime);
	table.insert(materials_from, potions);
	
elseif biome == "Coal Pits" then
	table.insert(materials_from, water);
	table.insert(materials_from, rock);
	table.insert(materials_from, potions);
	table.insert(materials_from, gas);
	table.insert(materials_from, metals);
	table.insert(materials_from, slime);
	table.insert(materials_from, plants);
	
elseif biome == "Snowy Depths" then
	table.insert(materials_from, cold);
	table.insert(materials_from, rock);
	table.insert(materials_from, gas);
	
	table.insert(materials_from, potions);
elseif biome == "Hiisi Base" then
	table.insert(materials_from, cold);
	table.insert(materials_from, rock);
	table.insert(materials_from, gas);
	table.insert(materials_from, metals);
	
	table.insert(materials_from, potions);
	
elseif biome == "Underground Jungle" then
	table.insert(materials_from, poison);
	table.insert(materials_from, plants);
	table.insert(materials_from, organic);
	
	table.insert(materials_from, potions);
	
elseif biome == "The Vault"  then
	table.insert(materials_from, gas);
	table.insert(materials_from, organic);
	table.insert(materials_from, rock);
	table.insert(materials_from, gas);
	table.insert(materials_from, metals);
	table.insert(materials_from, slime);
	
	
	table.insert(materials_from, potions);
elseif (biome == "Temple of the Art") or (biome == "Pyramid") then
	table.insert(materials_from, brickwork);
	
	table.insert(materials_from, potions);
elseif biome == "Desert" then
	table.insert(materials_from, { probability = 1.0, name = "sand", materials = {"sand_surface"}});

else
	table.insert(materials_from, water);
	table.insert(materials_from, slime);
	table.insert(materials_from, organic);
	table.insert(materials_from, potions);
	table.insert(materials_from, metals);
	table.insert(materials_from, gas);
	table.insert(materials_from, rock);
	table.insert(materials_from, poison);
	table.insert(materials_from, cold);
	table.insert(materials_from, plants);
	table.insert(materials_from, brickwork);
end

local cc = EntityGetComponent( entity_id, "MagicConvertMaterialComponent" )

local frame = GameGetFrameNum()

SetRandomSeed( 89346, 42345+frame )

EntityAddComponent( entity_id, "AudioComponent", {
	file="data/audio/Desktop/projectiles.bank",
	event_root="player_projectiles/meteor",
	set_latest_event_position="1"
});

local rnd = random_create(9123,58925+frame )
local from = pick_random_from_table_weighted( rnd, materials_from )
local to = pick_random_from_table_weighted( rnd, materials_to )

local toname = ""
toname = CellFactory_GetUIName(CellFactory_GetType(to.material))
if string.sub(toname, 1, 1) == "$" then
	toname = GameTextGet(toname)
end

GamePrint("shifted " .. from.name .. " to " .. toname)
shift_materials_in_range(200, from.materials, to.material, entity_id)


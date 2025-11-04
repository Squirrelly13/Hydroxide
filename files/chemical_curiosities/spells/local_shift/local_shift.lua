dofile_once("mods/Hydroxide/lib/squirreltilities.lua")

dofile_once("data/scripts/magic/fungal_shift.lua")

materials_from = {}

water   =   { probability = 0.4, name = "water", materials = { "water", "water_static", "water_salt", "water_ice" }}
slime   =   { probability = 0.4, name = "oils and slimes", materials = { "oil", "swamp", "peat", "slime", "cc_grease", "cc_ferrine", "aa_rice" }}
organic =   { probability = 0.5, name = "organics", materials = { "blood", "blood_fungi", "blood_cold", "blood_worm", "aa_hungry_slime", "aa_hungry_slime_growing","cc_devouring_moss", "cc_ferrine", "meat", "rotten_meat", "cc_frozen_meat", "aa_rice" }}
potions =   { probability = 0.3, name = "potions", materials = { "cc_persistine", "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_berserk", "magic_liquid_charm", "magic_liquid_invisibility","cc_sparkling_liquid", "cc_slicing_liquid", "cc_glittering_liquid", "cc_veilium", "cc_deceleratium", "aa_icy_inferno", "cc_heftium", "cc_stillium", "cc_explodePlayer", "aa_arborium", "aa_love", "aa_repultium", "aa_base_potion", "aa_cloning_solution", "aa_condensed_gravity", "aa_pop_rocks", "aa_meagre_offering", "aa_rice" }}
metals  =   { probability = 0.8, name = "metals", materials = { "gold", "silver", "brass", "copper", "diamond", "steel", "cc_cobalt", "cc_iron", "cc_preskite", "steel_sand", "steel_rust", "steelfrost_static", "steel_static", "steelmoss_static", "steel_grey_static", "steelfrost_static", "steelpipe_static"}}
gas     =   { probability = 0.8, name = "gasses", materials = { "acid_gas", "acid_gas_static", "poison_gas", "fungal_gas", "radioactive_gas", "radioactive_gas_static", "steam", "smoke", "aa_potion_gas","cc_methane", "cc_hydroxide_gas", "cloud" }}
rock    =   { probability = 0.8, name = "rock", materials = { "rock_static", "rock_static_glow", "rock_static_purple", "rock_static_noedge", "rock_static_intro", "rock_static_intro_breakable", "rock_static_wet", "rock_static_grey", "snowrock_static", "rock_vault", "concrete_collapsed", "aa_pop_rocks" } }
poison  =   { probability = 0.5, name = "poisons and toxins", materials = { "acid", "cc_hydroxide", "radioactive_liquid", "poison", "material_darkness", "alcohol", "cc_radioactive_waste" }}
cold    =   { probability = 0.8, name = "ice and snow", materials = { "ice_static", "ice_glass", "ice_acid_static", "ice_acid_glass", "ice_cold_static", "ice_cold_glass", "ice_radioactive_static", "ice_radioactive_glass", "ice_poison_static", "ice_poison_glass", "slush", "snow", "snow_sticky", "ice_ceiling", "ice_b2", "snow_b2", "snow_static" }}
plants  =   { probability = 0.8, name = "plants", materials = { "soil_lush", "sand_static_rainforest", "wood_loose", "wood_prop_durable", "wood_prop", "grass_loose", "cactus", "wood", "wood_player_b2", "wood_player", "fungus_loose_trippy", "fungus_loose_green", "fungus_loose", "fungi", "fungus_powder", "grass", "wood_static", "wood_static_vertical", "moss"}}
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

EntityAddComponent2( entity_id, "AudioComponent", {
    file="data/audio/Desktop/projectiles.bank",
    event_root="player_projectiles/meteor",
    set_latest_event_position=true
});


local from = RandomFromTable(materials_from)
local to = RandomFromTable(materials_to)
if not to then return end
if not from then return end
local toname = ""
toname = CellFactory_GetUIName(CellFactory_GetType(to.material))
if string.sub(toname, 1, 1) == "$" then
    toname = GameTextGet(toname)
end

local x,y = EntityGetTransform(entity_id)
--GamePrint("shifted " .. from.name .. " to " .. toname)
LocalShift(200, from.materials, to.material, x, y)
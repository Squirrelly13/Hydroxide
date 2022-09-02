dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

dofile_once("data/scripts/magic/fungal_shift.lua")

local entity_id    = GetUpdatedEntityID()

local cc = EntityGetComponent( entity_id, "MagicConvertMaterialComponent" )

local frame = GameGetFrameNum()

SetRandomSeed( 89346, 42345+frame )

local rnd = random_create(9123,58925+frame )
local from = pick_random_from_table_weighted( rnd, materials_from )
local to = pick_random_from_table_weighted( rnd, materials_to )

shift_materials_in_range(200, from.materials, to.material, entity_id)

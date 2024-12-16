dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y)

-- spawn random eye particles
if ( Random(0,1) > 0.5 ) then
	local function spawn( x,y )
	end

	local x,y = pos_x + Random(-100,100), pos_y + Random(-80,80)
	local rad = Random(0,30)

	EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/redacted_eye.xml", x,y )
	EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/redacted_eye.xml", x + 40 + rad, y + 30 + rad  )
	EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/redacted_eye.xml", x - 40 - rad, y + 30 + rad)
end

-- shift materials
NullShift(EntityGetParent(entity_id) or entity_id, pos_x, pos_y)
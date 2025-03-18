dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local x, y = EntityGetTransform( entity_id )

if ( player_id ~= NULL_ENTITY ) and ( entity_id ~= player_id ) then
	local dmgcomp = EntityGetFirstComponent( player_id, "DamageModelComponent" )

	local resists = { "drill", "electricity", "explosion", "fire", "ice", "melee", "projectile", "radioactive", "slice", "physics_hit", "overeating" }
	local result = ""

	if ( dmgcomp ~= nil ) then
		for a,b in ipairs( resists ) do
			ComponentObjectSetValue2( dmgcomp, "damage_multipliers", b, ComponentObjectGetValue2(dmgcomp, "damage_multipliers", b) / .75)
			--print("resistance "..b.." set to: ".. ComponentObjectGetValue2(dmgcomp, "damage_multipliers", b))
		end
	end

	local c = EntityGetAllChildren( player_id )

	if ( c ~= nil ) then
		for i,v in ipairs( c ) do
			if EntityHasTag( v, "effect_resistance" ) then
				--EntitySetComponentsWithTagEnabled( v, "effect_resistance", true )
			end
		end
	end
end
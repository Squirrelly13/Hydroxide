dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local x, y = EntityGetTransform( entity_id )

if ( player_id ~= NULL_ENTITY ) and ( entity_id ~= player_id ) then
	local dmgcomp = EntityGetFirstComponent( player_id, "DamageModelComponent" )
	
	local resists = { "drill", "electricity", "explosion", "fire", "ice", "melee", "projectile", "radioactive", "slice", "physics_hit", "overeating" }
	local result = ""
	
	if ( dmgcomp ~= nil ) then
		for a,resist in ipairs( resists ) do
			local r = tostring(ComponentObjectGetValue2( dmgcomp, "damage_multipliers", resist ))
			
			ComponentObjectSetValue2( dmgcomp, "damage_multipliers", resist, ComponentObjectGetValue2(dmgcomp, "damage_multipliers", resist) * 0.75)
			print("resistance "..resist.." set to: ".. ComponentObjectGetValue2(dmgcomp, "damage_multipliers", resist) * .75)
		end
	end
	
	local c = EntityGetAllChildren( player_id )
	
	if ( c ~= nil ) then
		for i,v in ipairs( c ) do
			if EntityHasTag( v, "effect_resistance" ) then
				--EntitySetComponentsWithTagEnabled( v, "effect_resistance", false )
			end
		end
	end
end
dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)


local damagemodels = EntityGetComponent( root, "DamageModelComponent" )


if( damagemodels ~= nil ) then
	for i,damagemodel in ipairs(damagemodels) do

		local max_hp = tonumber( ComponentGetValue2( damagemodel, "max_hp" ) ) or 0
		max_hp = max_hp + 0.1

		ComponentSetValue2( damagemodel, "max_hp", max_hp)
	end
end

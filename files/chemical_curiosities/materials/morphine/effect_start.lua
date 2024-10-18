dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )
if not vsc then return end
local trueHP = tonumber( ComponentGetValue2( vsc, "value_float") )
print("start.lua: trueHP: " .. trueHP)
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
if not damagemodel then return end


local max_hp		= tonumber( ComponentGetValue2( damagemodel, "max_hp"	 ) ) or 0
print("start.lua: hp: " .. max_hp)




ComponentSetValue2( vsc, "value_float", max_hp)


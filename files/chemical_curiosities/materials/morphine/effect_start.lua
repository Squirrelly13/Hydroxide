dofile_once("data/scripts/lib/utilities.lua")

local max_hp = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )

local trueHP = tonumber( ComponentGetValue2( vsc, "value_float") )
print("start.lua: trueHP: " .. trueHP)
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )



max_hp		= tonumber( ComponentGetValue2( damagemodel, "max_hp"	 ) )
print("start.lua: hp: " .. max_hp)




ComponentSetValue2( vsc, "value_float", max_hp)


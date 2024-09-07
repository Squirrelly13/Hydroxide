dofile_once("data/scripts/lib/utilities.lua")

local hp = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )
if not vsc then return end
local trueHP = tonumber(ComponentGetValue2( vsc, "value_float" ))

local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
if not damagemodel then return end

ComponentSetValue2(damagemodel, "hp", trueHP)
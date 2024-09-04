dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local root = EntityGetRootEntity( entity )

local x, y = EntityGetTransform(root)
local max_hp = 0	
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
if not damagemodel then return end
max_hp = ComponentGetValue2( damagemodel, "max_hp" )

EntityInflictDamage( root, max_hp / 33 , "DAMAGE_SLICE", "Annihilation", "PLAYER_RAGDOLL_CAMERA", 0, 0)

child_id = EntityLoad( "mods/Hydroxide/files/chemical_curiosities/materials/antimatter/antimatter_flash.xml", x, y )
EntityAddChild( root, child_id )

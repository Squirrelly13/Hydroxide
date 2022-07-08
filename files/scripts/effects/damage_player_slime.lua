dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

local root = EntityGetParent( entity)

if(root == entity)then return end


EntityInflictDamage( root, 0.025, "DAMAGE_PROJECTILE", "digested", "NORMAL", 0, 0, root, x, y, 0)

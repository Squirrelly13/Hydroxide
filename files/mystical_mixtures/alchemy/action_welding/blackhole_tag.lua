local projectile = GetUpdatedEntityID()

if(not EntityHasTag(projectile, "black_hole"))then
	EntityAddTag(projectile, "black_hole")
end
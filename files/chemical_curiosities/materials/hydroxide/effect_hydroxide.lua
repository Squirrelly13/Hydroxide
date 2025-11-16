dofile_once("mods/Hydroxide/lib/squirreltilities.lua")

local root = EntityGetRootEntity(GetUpdatedEntityID())

EntityMimicMaterialDamage(root, "cc_hydroxide", "acid")
EntityMimicMaterialDamage(root, "aa_divine_magma", "lava")
EntityMimicMaterialDamage(root, "cc_ice_hydroxide_static", "ice_acid_static")
EntityMimicMaterialDamage(root, "cc_ice_hydroxide_glass", "ice_acid_glass")

--TODO: deprecate this and replace with proper stuff on init
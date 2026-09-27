There are a few places we support compatibility!!
also PLEASE let me know via DMing me on discord @UserK or in *some* way if you add compatibility, as things are subject to change and I would like it if I could warn you in advance before changing any of this in some way (eg if a filepath or material name is changed, or the entire compatibility method is reworked)

# VIALS
Vials are an Arcane Alchemy feature, they are like mini-flasks that have 20% of the capacity (200px). The pool is generally designed around materials that are good to throw at enemies or otherwise valuable enough to be worthwhile in small quantity.
append `mods/Hydroxide/files/arcane_alchemy/items/vials/vial_populate.lua` with a script that add your material to the global table `VialMaterials`
like so:
```lua
table.insert(VialMaterials, {
	material = "supercool_modded_material",
	weight = .8 --we support decimal values for weight!
	func = function(self, entityid, data) --optional function in case you want to do some funky stuff (don't include if you don't need it)
		--self is passed, so we can modify the outcome like so:
		local materials = {"water", "slime", "slime_2"}
		self.material = materials[Random(1,#materials)]
		self.amount = ModSettingGet("mymod.x_vial_amount")

		--if you `return true` at the end of the custom function, it will not populate the vial
		--this is in case you wish to substitute the process with your own
	end
})
```



# PANDORIUMS
## Pandorium
You can add your own spells to Pandorium by appending [Hydroxide/files/arcane_alchemy/materials/pandorium/random_spell.lua]
The table you adds your spells to is "Pandorium_projectiles"
```lua
--your init.lua:
ModLuaFileAppend("Hydroxide/files/arcane_alchemy/materials/pandorium/random_spell.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua
table.insert(Pandorium_spells, "mods/modid/file/path/to/your/spell.xml")
```

## Unstable and Chaotic
If you do not want your spell to be cast by Pandorium at all, add the `pandorium_ignore = true` variable to your spell
Unstable Pandorium can cast any spell in which `related_projectiles` is not nil and (`pandorium_ignore`, `ai_never_uses` and `recursive`) are all false
Chaotic Pandorium can cast any Projectile, Static Projectile or Material spell in tiers 0-2 and modifiers in tiers 0-5 unless they have `pandorium_ignore` or "ai_never_uses"
Chaotic Pandorium also has special detection for Glimmer spells, we check for `"COLOUR"` in the name of a modifier but ideally we'd prefer if mods could add the `is_glimmer` variable to their spell as we intend to phase out the former method.

A whitelist mode for Upand and Cpand is eventually planned.



# Local Shift
To append to local shift, simply
```lua
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.lua", "mods/modid/file/path/to/your/append.lua")
```
We have provided a couple handy functions for easier altering/adding to existing `MaterialGroups` and `BiomeLists`, example of the former can be found in `mods/Hydroxide/files/chemical_curiosities/spells/local_shift/append.lua`
This spell is due for a rework that will directly get materials that are near the player.



# Null Shift
Null Shift is a mechanic similar to Fungal Shifting, except it converts a single material group to air, it is triggered by consuming Dull Fungus
You can append the materials table like so:
```lua
--your init.lua:
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift_table.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua:
NullShift_materials.my_primary_material = {
	weight = 0.05, --default 1.0
	condition = function(self, data) --optional (data provides shifter entity and position (THESE CAN BE NIL!!))
		if shifter and BiomeMapGetName(data.x, data.y) == "waterworld" then
			self.weight = 1.2
			table.remove(self.variants, 1) --remove "my_primary_material_dry" from variants
		end --you can modify weight and such before the table is rolled like so!
		return true --returning false will mean the entry is not valid, here we return true because we only want to modify the probaility, feel free to do things your way!
	end
	variants = { --optional
		"my_primary_material_dry",
		"my_primary_material_damp",
		"my_primary_material_soggy",
	}
}
```
Null Shifts also have a 25% chance to pull from held material, add the tag `CC_NULL_SHIFT_IGNORE` if you would like your material to not be possible to Null Shift in this manner.

You can also directly append into `/null_shift.lua`'s `NullShiftData` global to alter global information directly or add custom functions under `NullShiftData.custom_functions`!
```lua
--your init.lua:
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua:
NullShiftData.custom_functions[#NullShiftData.custom_functions+1] = function(shifter, x, y) --SHIFTER AND ITS COORDINATES CAN BE NIL
	if not (shifter and IsPlayer(shifter)) then return end --nil and player check for shifter
	local tx = GlobalsGetValue("my_secret_pos.x")
	local ty = GlobalsGetValue("my_secret_pos.y")
	if (tx > (x - 100) and tx < (x + 100)) and (ty > (y - 100) and ty < (y + 100)) then --basic 200 pixel bounding box check for of my_secret_pos
		GamePrintImportant("gotcha!", "player nullified :)") EntityKill(shifter) --silly code you want to run
		return true --returning true will cancel the null shift and not change any materials
	end
end

NullShiftData.null_shift_limit = NullShiftData.null_shift_limit + 10 --increases the shift limit by 10
table.insert(NullShiftData.log_messages, "$modid_custom_null_shift_log") --add a custom shift message
```



# Chaotic Transfusion
Chaotic Transfusion is a perk locked behind experimental features. It makes all enemies bleed random materials, the material list can be appended like so:
```lua
--your init.lua:
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/transfusion_pool.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua:
local my_materials = {
	{
		material = "my_useful_magic_liquid", --ideally should be materials that spice up a run but still make the perk worth taking
		weight = 10, --weight is a value typically ranging from 1-15
	},
	{
		material = "my_silly_magic_liquid",
		weight = 6,
	},
}
return function(materials)
	for _,v in ipairs(my_materials) do
		materials[#materials+1] = v
	end

	return materials
end
```
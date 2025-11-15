There are a few places we support compatibility!!
also PLEASE let me know via DMing me on discord @UserK or in *some* way if you add compatibility, as things are subject to change and I would like it if I could warn you in advance before changing any of this in some way (eg if a filepath or material name is changed, or the entire compatibility method is reworked)

# VIALS
append [mods/Hydroxide/files/arcane_alchemy/items/vials/vial_populate.lua] with a script that add your material to the global table `VialMaterials`
like so:
```lua
table.insert(VialMaterials, {
	material = "supercool_modded_material",
	probability = .8 --we support decimal values for weight!
	amount = 200 --optional value, 200 is the default (this is unused in vanilla but is also on potions, we may use this value for something in the future)
	func = function(self, entityid, data)
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
table.insert(Pandorium_spells, "mods/modid/file/path/to/your/spell.xml")
```

## Unstable and Chaotic
If you do not want your spell to be cast by Pandorium at all, add the "pandorium_ignore = true" variable to your spell
Unstable Pandorium can cast any spell in which `related_projectiles` is not nil and (`pandorium_ignore`, `ai_never_uses` and `recursive`) are all false
Chaotic Pandorium can cast any Projectile, Static Projectile or Material spell in tiers 0-2 and modifiers in tiers 0-5 unless they have `pandorium_ignore` or "ai_never_uses"
Chaotic Pandorium also has special detection for Glimmer spells, we check for `"COLOUR"` in the name of a modifier but ideally we'd prefer if mods could add the `is_glimmer` variable to their spell as we intend to phase out the former method.

A whitelist mode for Upand and Cpand is eventually planned.



# LOCAL SHIFT
To append to local shift, simply
```lua
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.lua", "mods/modid/file/path/to/your/append.lua")
```
We have provided a couple handy functions for easier altering/adding to existing `MaterialGroups` and `BiomeLists`, example of the former can be found in `"mods/Hydroxide/files/chemical_curiosities/spells/local_shift/append.lua"`



# Null Shift
Null Shift is a mechanic similar to Fungal Shifting, except it converts a single material group to air, it is triggered by consuming Dull Fungus
You can append the materials table like so:
```lua
--your init.lua:
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift_table.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua:
NullShift_materials.my_primary_material = {
	probability = 0.05, --default 1.0
	condition = function(self, data) --optional (data provides, shifter entity and position (CAN BE NIL!!))
		if shifter and BiomeMapGetName(data.x, data.y) == "waterworld" then
            self.probability = 1.2
            table.remove(self.variants, 1) --remove "my_primary_material_dry" from variants
        end --you can modify probability and such before the table is rolled like so!
		return true --returning false will mean the entry is not valid, here we return true because we only want to modify the probaility, feel free to do things your way!
	end
	variants = { --optional
		"my_primary_material_dry",
		"my_primary_material_damp",
		"my_primary_material_soggy",
	}
}
```

You can also directly append into `/null_shift.lua`'s `NullShiftData` global to alter global information directly or add custom functions under `NullShiftData.custom_functions`!
```lua
--your init.lua:
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift.lua", "mods/modid/file/path/to/your/append.lua")

--your append.lua:
NullShiftData.custom_functions[#NullShiftData.custom_functions+1] = function(shifter, x, y) --SHIFTER AND ITS COORDINATES CAN BE NIL
    if not shifter then return end --nil check for shifter
    local target_x = GlobalsGetValue("my_secret_pos.x")
    local target_y = GlobalsGetValue("my_secret_pos.y")
    if (target_x > (x - 100) and target_x < (x + 100)) and (target_y > (y - 100) and target_y < (y + 100)) then --basic 200 pixel bounding box check for of my_secret_pos
        GamePrintImportant("gotcha!")
        --execute custom code or whatever
        return true --returning true will cancel the null shift and not change any materials
    end
end

NullShiftData.null_shift_limit = NullShiftData.null_shift_limit + 10 --increases the shift limit
table.insert(NullShiftData.log_messages, "$modid_custom_null_shift_log") --add a custom shift message
```
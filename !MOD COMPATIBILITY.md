There are a few places we support compatibility!!

# VIALS
append [mods/Hydroxide/files/arcane_alchemy/items/vials/vial_populate.lua] with a script that add your material to the global table "vial_materials"
like so:
```lua
table.insert(vial_materials, {
    material = "supercool_modded_material",
    weight = .8 --we support decimal values for weight!
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
Unstable Pandorium can cast any spell in which "related_projectiles" is not nil and `pandorium_ignore`, `ai_never_uses` and `recursive` are all false
Chaotic Pandorium can cast any Projectile, Static Projectile or *Material* spell in tiers 0-2 and modifiers in tiers 0-5 unless they have `pandorium_ignore` or "ai_never_uses"
Chaotic Pandorium also has special detection for Glimmer spells, we check for `"COLOUR"` in the name of a modifier but ideally we'd prefer if mods could add the `is_glimmer` variable to their spell

A whitelist mode for Upand and Cpand is eventually planned.


# LOCAL SHIFT
To append to local shift, simply
```lua
ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.lua", "mods/modid/file/path/to/your/append.lua")
```
We have provided a couple handy functions for easier altering/adding to existing `MaterialGroups` and `BiomeLists`, example of the former can be found in `"mods/Hydroxide/files/chemical_curiosities/spells/local_shift/append.lua"`
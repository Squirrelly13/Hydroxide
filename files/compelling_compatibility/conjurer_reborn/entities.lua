table.insert(ALL_ENTITIES, {
  name="Chemical Curiosities",
  desc="Entities added by Chemical Curiosities",
  icon="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/flasky.png",
  icon_off="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/flasky_off.png",  -- The greyed-out unselected variant
  entities={
    {
      name="Vial",
      desc="Has a random material picked from a dedicated table inside it",
      path="mods/Hydroxide/files/arcane_alchemy/items/vials/vial.xml",
      image="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities/vial.png",  -- This should be a 16*16px icon
    },
    {
      name="Empty Vial",
      desc="Has 20% the storage capacity of a normal flask",
      path="mods/Hydroxide/files/arcane_alchemy/items/vials/empty_vial.xml",
      image="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities/vial.png",  -- This should be a 16*16px icon
    },
    {
      name="Vial of Chaotic Pandorium",
      desc="Has 200 pixel of Chaotic Pandorium, because I lost my mind trying to get this all the time via RNG",
      path="mods/Hydroxide/files/arcane_alchemy/items/vials/vial_chaotic_pandorium.xml",
      image="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities/vial_chaotic_pandorium.png",  -- This should be a 16*16px icon
    },
    {
      name="$item_cc_runestone_crystal",
      desc="Turns nearby liquids into Molten Crystal",
      image="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities/runestone_crystal.png",  -- This should be a 16*16px icon
      path="mods/hydroxide/files/chemical_curiosities/items/runestone_crystal/runestone_crystal.xml",
    },
    {
      name="Pandora Shot",
      desc="Entity used by Chaotic Pandorium to shoot random spell formulas.\nMaybe I will make a dedicated icon for it someday...",
      image="mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities/runestone_crystal.png",  -- This should be a 16*16px icon
      path="mods/hydroxide/files/arcane_alchemy/materials/pandorium/chaotic/random_spell_chaotic.xml",
    },
    -- ... and so on
  },
})
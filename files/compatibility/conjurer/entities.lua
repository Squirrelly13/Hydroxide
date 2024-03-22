table.insert(ALL_ENTITIES, {
  name="Chemical Curiosities",
  desc="Entities added by Chemical Curiosities",
  icon="mods/Hydroxide/files/compatibility/conjurer/flasky.png",
  icon_off="mods/Hydroxide/files/compatibility/conjurer/flasky_off.png",  -- The greyed-out unselected variant
  entities={
    {
      name="Empty Vial",
      desc="Has 20% the storage capacity of a normal flask",
      path="mods/Hydroxide/files/compatibility/conjurer/entities/empty_vial.xml",
      image="mods/Hydroxide/files/compatibility/conjurer/entities/vial.png",  -- This should be a 16*16px icon
      --[[ spawn_func=function(x, y)
        local entity 
        local comp = entity.LuaComponent
        comp.disabled = true 
        return e
      end, ]]
    },
    {
      name="Vial",
      desc="Has a random material picked from a dedicated table inside it",
      path="mods/Hydroxide/files/arcane_alchemy/items/vials/vial.xml",
      image="mods/Hydroxide/files/compatibility/conjurer/entities/vial.png",  -- This should be a 16*16px icon
    },
    {
      name="Runestone of Crystals",
      desc="Turns nearby liquids into Molten Crystal",
      image="mods/Hydroxide/files/compatibility/conjurer/entities/runestone_crystal.png",  -- This should be a 16*16px icon
      path="mods/hydroxide/files/chemical_curiosities/items/runestone_crystal/runestone_crystal.xml",
    },
    -- ... and so on
  },
})
append_effect("cc_hydroxide", function(wand)
    wand.capacity = 66
  end)


  register_physics_item({
    physics_image_file = "mods/hydroxide/files/chemical_curiosities/items/runestone_crystal/runestone_crystal.png",
    type = "tablet", -- Will count this item as a tablet
  })

-- Slowdown Potions

append_effect("cc_deceleratium", function(wand)
    wand.castDelay = wand.castDelay + math.max(Random(1, 2), wand.castDelay * Randomf(0.08, 0.1))
  end)

  append_effect("cc_heftium", function(wand)
    wand.rechargeTime = wand.rechargeTime + math.max(Random(1, 2), wand.rechargeTime * Randomf(0.08, 0.1))
  end)

  append_effect("cc_stillium", function(wand)
    wand.castDelay = wand.castDelay + math.max(Random(1, 2), wand.castDelay * Randomf(0.08, 0.1))
    wand.rechargeTime = wand.rechargeTime + math.max(Random(1, 2), wand.rechargeTime * Randomf(0.08, 0.1))
  end)
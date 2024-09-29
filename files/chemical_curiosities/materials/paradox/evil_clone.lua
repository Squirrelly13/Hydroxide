local id = GetUpdatedEntityID()
local controls_comp = EntityGetComponentIncludingDisabled(id, "ControlsComponent")
ComponentSetValue2(controls_comp, "enabled", false)
EntityLoadToEntity("data/entities/base_humanoid.xml", id)
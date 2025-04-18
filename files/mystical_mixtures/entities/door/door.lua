function toggle_background(door)
  local bg = EntityGetFirstComponentIncludingDisabled(door, "SpriteComponent", "door_open_sprite")
  if not bg then return end
  local enabled = ComponentGetIsEnabled(bg)

  EntitySetComponentIsEnabled(door, bg, not enabled)
end

function toggle_body(door)
  local body = EntityGetFirstComponentIncludingDisabled(door, "PhysicsBodyComponent")
  if not body then return end
  local enabled = ComponentGetIsEnabled(body)

  EntitySetComponentIsEnabled(door, body, not enabled)

  -- TODO: Shouldn't these be added only when the body is enabled?
  EntityAddComponent2(door, "PhysicsJointComponent", {
    nail_to_wall = true, breakable = true, grid_joint = true, pos_y = 4
  })
  EntityAddComponent2(door, "PhysicsJointComponent", {
    nail_to_wall = true, breakable = true, grid_joint = true, pos_y = 15
  })
end

function interacting(interacter, door, door_name)
  toggle_background(door)
  toggle_body(door)
end



-- Disable interacting when the door is shot, damaged anything
function physics_body_modified( is_destroyed )
  local door = GetUpdatedEntityID()
  local interaction = EntityGetFirstComponentIncludingDisabled(door, "InteractableComponent")
  if not interaction then return end
  local bg_sprite = EntityGetFirstComponentIncludingDisabled(door, "SpriteComponent", "door_bg_sprite")
  if not bg_sprite then return end

  EntityRemoveComponent(door, interaction)
  EntityRemoveComponent(door, bg_sprite)
end


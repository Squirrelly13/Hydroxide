function material_area_checker_success( pos_x, pos_y )

    EntityLoad("mods/Hydroxide/files/arcane_alchemy/items/nerf_gun/nerf_gun.xml", pos_x, pos_y)
    EntityKill(GetUpdatedEntityID())
end
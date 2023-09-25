dofile_once("data/scripts/lib/utilities.lua")



function material_area_checker_success( pos_x, pos_y )
    
    EntityLoad("mods/Hydroxide/files/entities/nerf_gun/nerf_gun.xml", pos_x, pos_y)
    EntityKill(GetUpdatedEntityID())
end


--[[

]]
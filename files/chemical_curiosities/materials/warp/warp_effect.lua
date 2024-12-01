dofile("mods/Hydroxide/files/lib/status_helper.lua")

--[[
was_executed = was_executed or false
ticks = ticks or 0




target_x = target_x or root_x
target_y = target_y or root_y

if(not was_executed)then
    GamePrint("Warping")

    SetRandomSeed(x + 2346, y + GameGetFrameNum())
    was_executed = true
    local map_w, map_h = BiomeMapGetSize()
    local offset_x = map_w * 512

    if(Random(1, 100) < 50)then
        offset_x = offset_x * -1
    end


    target_x = root_x + offset_x
    target_y = root_y
end

if(ticks < 5)then
    EntityApplyTransform(entity_id, target_x, target_y)
    ticks = ticks + 1
end
]]

local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local root_x, root_y = EntityGetTransform(root)

if(root == entity_id)then
    return
end

local is_player = EntityHasTag(root, "player_unit")

local percentage = GetIngestionSeconds(root, "CC_WARP")
is_warped = is_warped or false
ticks = ticks or 0


target_x = target_x or root_x
target_y = target_y or root_y
warp = warp or 0

if(percentage > 20)then
    if(not is_warped)then

        SetRandomSeed(root_x + 2346, root_y + GameGetFrameNum())
        is_warped = true
        local map_w, map_h = BiomeMapGetSize()
        local offset_x = map_w * 512
    
        if(Random(1, 100) < 50)then
            offset_x = offset_x * -1
        end
    
    
        target_x = root_x + offset_x
        target_y = root_y

        GamePlaySound( "mods/Hydroxide/files/mystical_mixtures/misc/mystical_mixtures.bank", "warp/warp_sound", root_x, root_y )
        GamePlaySound( "mods/Hydroxide/files/mystical_mixtures/misc/mystical_mixtures.bank", "warp/warp_sound", target_x, target_y )

        --GameEntityPlaySound( entity_id, "warp/warp_sound" )
    end
end

if(is_warped)then
    ticks = ticks + 1
    if(ticks < 45)then

        warp = warp + 1
        if(is_player)then
            GameSetPostFxParameter("cc_warp_multiplier", warp, 0 ,0 ,0)
        end
        if(ticks > 43)then
            EntityApplyTransform(root, target_x, target_y)
        end
    else
        local done = false
        warp = warp - 2
        if(warp <= 0)then
            warp = 0
            ticks = 0
            done = true
        end
        if(is_player)then
            GameSetPostFxParameter("cc_warp_multiplier", warp, 0 ,0 ,0)
        end
        if(done)then
            GamePrint("$log_cc_paradox_warp")
            EntityRemoveIngestionStatusEffect( root, "CC_WARP" )
            EntityIngestMaterial( root, CellFactory_GetType("cc_warp_sickness"), 1)
            EntityKill(entity_id)
        end
    end
end
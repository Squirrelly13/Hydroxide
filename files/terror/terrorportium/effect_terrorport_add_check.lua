local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

SetRandomSeed(x + entity_id, y + GameGetFrameNum()) --rng setted grabbed from Graham :clueless:


for i=1, 10 do --positions 1-5
    local xr = x + Random(-1000, 1000)
    local yr = y + Random(-700, 700)
    if RaytracePlatforms(xr-8, yr-8, xr+8, yr+8) and RaytracePlatforms(xr+8, yr-8, xr-8, yr+8) then --try to avoid teleporting them into literal ground
        EntityLoad("mods/Hydroxide/files/terror/terrorportium/effect_terrorport_destination.xml", xr, yr)
    end
end

--if failed 10 times in a row, just teleport them.
local xr = x + Random(-1000, 1000)
local yr = y + Random(-700, 700)
EntityLoad("mods/Hydroxide/files/terror/terrorportium/effect_terrorport_destination.xml", xr, yr)
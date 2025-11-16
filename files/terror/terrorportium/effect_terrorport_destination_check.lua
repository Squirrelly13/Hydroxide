local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local score = 0

for k,v in EntityGetInRadiusWithTag(x,y, 400, "enemy") do
    local x2,y2 = EntityGetTransform(v)
    if RaytracePlatforms(x, y, x2, y2) == true then score = score + 1 end
end

--Raytrace lmao my computer BSOD'd while writing this fucking line, its been weeks since then and VSC opened me right back here after opening it after getting a temp GPU in my computer, ill continue working on Terrorportatium some other time i think.
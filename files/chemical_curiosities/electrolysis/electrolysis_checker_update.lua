local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

local nearby = EntityGetInRadiusWithTag(x, y, 4, "electrolysis_checker")

for _, v in ipairs(nearby)do
    if(v ~= entity)then
        EntityKill(v)
    end
end
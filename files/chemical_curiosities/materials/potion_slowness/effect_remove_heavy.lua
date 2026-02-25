local entity = GetUpdatedEntityID()

local root = EntityGetParent( entity)

local cpc = EntityGetFirstComponent(root, "CharacterPlatformingComponent")
if not cpc then return end

local grav = ComponentGetValue2(cpc, "pixel_gravity")
if grav < 0 then return end
ComponentSetValue2(cpc, "pixel_gravity", grav * .5)
dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity)

SetRandomSeed(x,y)

local root = EntityGetClosestWithTag(x, y, "mortal")

local component = EntityGetFirstComponent(root, "CharacterDataComponent")

local vel_x, vel_y = ComponentGetValueVector2(component, "mVelocity")

if(Random(0,100) > 50)then
    vel_x = Random(200, 400)
else
    vel_x = Random(-200, -400)
end
vel_y = Random( -1500, -3000)

ComponentSetValueVector2(component, "mVelocity", vel_x, vel_y)

EntityLoad("mods/Hydroxide/files/Arcane Alchemy/materials/AA_REPULTIUM/particles_splash.xml",x,y)
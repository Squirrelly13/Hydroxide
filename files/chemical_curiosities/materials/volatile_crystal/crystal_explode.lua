dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
EntityLoad("data/entities/particles/particle_explosion/main_swirly_pink.xml", pos_x, pos_y)

local rockets = EntityGetWithTag("rocket")
local rocketCount = #rockets

if (rocketCount <= 5) then

	SetRandomSeed(entity_id, rocketCount)


	local angle_max = math.pi


	local angle = math.rad(Random(0,360))
	local length = Random(30,50)

	local vel_x = math.cos( angle ) * length
	local vel_y = 0 - math.sin( angle ) * length

	shoot_projectile( entity_id, "data/entities/projectiles/rocket_crystal_pink.xml", pos_x, pos_y, vel_x, vel_y, false )

end

EntityKill(entity_id)
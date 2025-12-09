dofile_once("mods/Hydroxide/files/lib/status_helper.lua")

local distance_full = 400
local float_range = 200
local float_force = 300
local float_sensor_sector = math.pi * 0.3

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


local stainPercent = math.min(10, GetStainPercentage(EntityGetParent(entity_id), "AA_GRAVITY") * 3 + (GetIngestionSeconds(EntityGetParent(entity_id), "AA_GRAVITY") * .05))
-- stainPercent = (Stain% * 5 + IngestionSeconds * .05) < 1.5

function calculate_force_at(body_x, body_y)
	local distance = math.sqrt( ( x - body_x ) ^ 2 + ( y - body_y ) ^ 2 )
	if distance * (stainPercent * .9) < 12 then
		-- stop attracting when near enough to prevent some collisions against moon
		return 0,0
	end
	local direction = 0 - math.atan2( ( y - body_y ), ( x - body_x ) )

	-- local gravity_percent = ( distance_full - distance ) / distance_full
	-- local gravity_percent = 8
	local gravity_coeff = 196

	local fx = math.cos( direction ) * ( gravity_coeff * stainPercent )
	local fy = -math.sin( direction ) * ( gravity_coeff * stainPercent )

    return fx,fy
end

-- attract projectiles
local entities = EntityGetInRadiusWithTag(x, y, distance_full, "projectile")
for _,id in ipairs(entities) do
	local physicscomp = EntityGetFirstComponent(id, "PhysicsBody2Component") or EntityGetFirstComponent( id, "PhysicsBodyComponent")
	if physicscomp == nil then -- velocity for physics bodies is done later
		local px, py = EntityGetTransform( id )

		local velocitycomp = EntityGetFirstComponent( id, "VelocityComponent" )
		if ( velocitycomp ~= nil ) then
			local fx, fy = calculate_force_at(px, py)
			for _, velcomp in ipairs(EntityGetComponent(id, "VelocityComponent") or {}) do
				local vel_x,vel_y = ComponentGetValue2(velcomp, "mVelocity")
				ComponentSetValue2(velcomp, "mVelocity", vel_x + fx, vel_y + fy)
			end
		end
	end
end


-- force field for physics bodies
function calculate_force_for_body( entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular )
	local fx, fy = calculate_force_at(body_x, body_y)

	fx = fx * 0.11 * body_mass
	fy = fy * 0.11 * body_mass

    return body_x,body_y,fx,fy,0 -- forcePosX,forcePosY,forceX,forceY,forceAngular
end
local size = distance_full * 0.5
PhysicsApplyForceOnArea( calculate_force_for_body, entity_id, x-size, y-size, x+size, y+size )


-- float by raycasting down and applying opposite physical force



do
	local dir_x = 0
	local dir_y = float_range

	local angle = ProceduralRandomf(x, y + GameGetFrameNum(), -float_sensor_sector, float_sensor_sector)
	local ca = math.cos(angle)
	local sa = math.sin(angle)
	local px = ca * dir_x - sa * dir_y
	local py = sa * dir_x + ca * dir_y

	local did_hit,hit_x,hit_y = RaytracePlatforms( x, y, x + px, y + py )
	if did_hit then
		local dist = ((hit_x-x)^2 + (hit_y-y)^2)^.5
		dist = math.max(6, dist) -- tame a bit on close encounters
		px = -px / dist * float_force
		py = -py / dist * float_force
		PhysicsApplyForce(entity_id, px, py)
	end
end


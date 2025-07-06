dofile( "data/scripts/lib/utilities.lua" )
local projectile = GetUpdatedEntityID()

local x, y = EntityGetTransform(projectile)

local valid_whoshot = 0
local valid_entityThatShot = 0

local projectile_component_data = {
	properties = {

	},

	valid_properties = {

	},

	count = -1,

	objects = {
		config_explosion = {

		},
		damage_by_type = {

		},
	},

	valid_objects = {
		config_explosion = {

		},
		damage_by_type = {

		},
	}
}


local projectile_component = EntityGetComponent(projectile, "ProjectileComponent") or {}
for k, v in ipairs(projectile_component)do
	local mWhoShot = ComponentGetValue2(v, "mWhoShot")
	local mEntityThatShot = ComponentGetValue2(v, "mEntityThatShot")

		local componentProperties = ComponentGetMembers(v) or {}

		projectile_component_data.count = projectile_component_data.count + 1

		--print("testba")
		--pretty.table(componentProperties)

		for a, b in pairs(componentProperties)do
			if(tonumber(b) ~= nil)then
				local value = tonumber(b)

				if(projectile_component_data.properties[a] == nil)then
					projectile_component_data.properties[a] = 0
				end


				if(projectile_component_data.properties[a] ~= nil)then
					projectile_component_data.properties[a] = projectile_component_data.properties[a] + value
				end
				if(value ~= 1 and value ~= 0)then
					projectile_component_data.valid_properties[a] = true
				end
			end
		end

		for objectName, _ in pairs(projectile_component_data.objects)do
			local objectProperties = ComponentObjectGetMembers(v, objectName) or {}

			for a, b in pairs(objectProperties)do
				if(tonumber(b) ~= nil)then
					local value = tonumber(b)

					if(projectile_component_data.objects[objectName][a] == nil)then
						projectile_component_data.objects[objectName][a] = 0
					end

					if(projectile_component_data.objects[objectName][a] ~= nil)then
						projectile_component_data.objects[objectName][a] = projectile_component_data.objects[objectName][a] + value
					end
					if(value ~= 1 and value ~= 0)then
						projectile_component_data.valid_objects[objectName][a] = true
					end
				end
			end
		end

	if(mWhoShot > 0)then
		valid_whoshot = mWhoShot
		break
	end

	if(mEntityThatShot > 0)then
		valid_entityThatShot = mEntityThatShot
		break
	end
end

local velocity_component_properties = {
	properties = {

	},

	valid_properties = {

	},

	count = -1,
}

local velocity_component = EntityGetComponent(projectile, "VelocityComponent") or {}
for k, v in ipairs(velocity_component)do

		local componentProperties = ComponentGetMembers(v) or {}

		velocity_component_properties.count = velocity_component_properties.count + 1

		--print("testba")
		--pretty.table(componentProperties)

		for a, b in pairs(componentProperties)do
			if(tonumber(b) ~= nil)then
				local value = tonumber(b)

				if(velocity_component_properties.properties[a] == nil)then
					velocity_component_properties.properties[a] = 0
				end


				if(velocity_component_properties.properties[a] ~= nil)then
					velocity_component_properties.properties[a] = velocity_component_properties.properties[a] + value
				end
				if(value ~= 1 and value ~= 0)then
					velocity_component_properties.valid_properties[a] = true
				end
			end
		end

		if(velocity_component_properties.properties["mVelocity"] == nil)then
			velocity_component_properties.properties["mVelocity"] = 0
		end

		velocity_component_properties.properties["mVelocity"] = velocity_component_properties.properties["mVelocity"] + ComponentGetValue2(v, "mVelocity")
		velocity_component_properties.valid_properties["mVelocity"] = true

end


	for k, v in pairs(velocity_component_properties.properties)do
		if(velocity_component_properties.valid_properties[k])then
			velocity_component_properties.properties[k] = v / math.max(velocity_component_properties.count, 1)
		else
			velocity_component_properties.properties[k] = math.floor((v / math.max(velocity_component_properties.count, 1)) + 0.5)
		end
	end

	--pretty.table(velocity_component_properties.properties)

	for k, v in ipairs(projectile_component)do
		for a, b in ipairs(velocity_component_properties.properties)do
			ComponentSetValue2(v, b, velocity_component_properties.properties[b])
		end
	end





	for k, v in pairs(projectile_component_data.properties)do
		if(projectile_component_data.valid_properties[k])then
			projectile_component_data.properties[k] = v / math.max(projectile_component_data.count, 1)
		else
			projectile_component_data.properties[k] = math.floor((v / math.max(projectile_component_data.count, 1)) + 0.5)
		end
	end
	for objectName, _ in pairs(projectile_component_data.objects)do
		for k, v in pairs(projectile_component_data.objects[objectName])do
			if(projectile_component_data.valid_objects[objectName][k])then
				projectile_component_data.objects[objectName][k] = v / math.max(projectile_component_data.count, 1)
			else
				projectile_component_data.objects[objectName][k] = math.floor((v / math.max(projectile_component_data.count, 1)) + 0.5)
			end
		end
	end

	--pretty.table(projectile_component_data.properties)

	--[[
	for k, v in ipairs(projectile_component)do
		if(k < #projectile_component)then
			EntityRemoveComponent(projectile, v)
		end
	end
	]]



	for k, v in ipairs(projectile_component)do
		for a, b in ipairs(projectile_component_data.properties)do
			ComponentSetValue2(v, b, projectile_component_data.properties[b])
		end

		for objectName, _ in pairs(projectile_component_data.objects)do
			for a, b in ipairs(projectile_component_data.objects[objectName])do
				ComponentObjectSetValue2(v, objectName, b, projectile_component_data.objects[objectName][b])

			end
		end
	end

	--[[
	for k, v in ipairs(projectile_component)do
		if k > 1 then
			ComponentSetValue2(v, "speed_min", 0)
			ComponentSetValue2(v, "speed_max", 0)
			ComponentSetValue2(v, "lob_min", 0)
			ComponentSetValue2(v, "lob_max", 0)
			ComponentSetValue2(v, "mInitialSpeed", 0)
		end
	end
	]]



for k, v in pairs(projectile_component)do
	ComponentSetValue2(v, "mWhoShot", valid_whoshot)
	ComponentSetValue2(v, "mEntityThatShot", valid_entityThatShot)
end

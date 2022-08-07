--generally a collection of useful scripts.

-- function to obtain a value from an internal variable contained in a variable storage component
-- entity_id is the id of the entity whose internal variables will be accessed
-- variable_name is the name of the internal variable to be accesses
-- variable_type is type indicator of the internal variable, which can be value_string, value_int or value_float
function getInternalVariableValue(entity_id, variable_name, variable_type)
	local value = nil
	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )
	if ( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue2( comp_id, "name" )
			if(var_name == variable_name) then
				value = ComponentGetValue2(comp_id, variable_type)
			end
		end
	end
	return value
end

-- function to set a value of an internal variable contained in a variable storage component of an entity with entity_id with name variable_name and type variable_type
-- entity_id is the id of the entity whose internal variables will be accessed
-- variable_name is the name of the internal variable to be accesses
-- variable_type is type indicator of the internal variable, which can be value_string, value_int or value_float
function setInternalVariableValue(entity_id, variable_name, variable_type, new_value)

	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )	
	if ( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue2( comp_id, "name" )
			if( var_name == variable_name) then
				ComponentSetValue2( comp_id, variable_type, new_value )
			end
		end
	end
end

-- function to add new internal variables to an entity
-- entity_id is the id of the entity that will receive a new internal variable
-- variable_type is the type of variable being added, can be value_int, value_string or value_float
-- initial_value is the starting value of the variable being added, if none, must be provided as, e.g., 0, "", or 0.0
function addNewInternalVariable(entity_id, variable_name, variable_type, initial_value)
	if(variable_type == "value_int") then
		EntityAddComponent2(entity_id, "VariableStorageComponent", {
			name=variable_name,
			value_int=initial_value
		})
	elseif(variable_type == "value_string") then
		EntityAddComponent2(entity_id, "VariableStorageComponent", {
			name=variable_name,
			value_string=initial_value
		})
	elseif(variable_type == "value_float") then
		EntityAddComponent2(entity_id, "VariableStorageComponent", {
			name=variable_name,
			value_float=initial_value
		})
	elseif(variable_type == "value_bool") then
		EntityAddComponent2(entity_id, "VariableStorageComponent", {
			name=variable_name,
			value_bool=initial_value
		})
	end
end
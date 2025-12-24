dofile_once("data/scripts/status_effects/status_list.lua")

local unique_status_effects = {}
local unique_status_effect_added = {}
for k,v in pairs(status_effects) do
	if v.id ~= nil and not unique_status_effect_added[v.id] then
		unique_status_effect_added[v.id] = true
		table.insert(unique_status_effects, v.id)
	end
end


---Returns the percentage amount of the provided `effect_id` stain status on the target.
---@param entity_id entity_id
---@param effect_id string
---@return number
function GetStainPercentage(entity_id, effect_id)
	local status_effect_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "StatusEffectDataComponent")
	if status_effect_data_component == nil then return 0 end

	local stain_effects = ComponentGetValue2(status_effect_data_component, "stain_effects")
	if stain_effects == nil then return 0 end

	for k,v in pairs(stain_effects) do
		local index = k - 1
		if index > 0 then
			local effect = unique_status_effects[index]
			if effect == effect_id then return v end
		end
	end
	return 0
end

---Returns the remaining seconds of the provided `effect_id` ingestion status on the target.
---@param entity_id entity_id
---@param effect_id string
---@return number
function GetIngestionSeconds(entity_id, effect_id)
	local status_effect_data_component = EntityGetFirstComponentIncludingDisabled(entity_id, "StatusEffectDataComponent")
	if(status_effect_data_component == nil)then
		return 0
	end
	local ingestion_effects = ComponentGetValue2(status_effect_data_component, "ingestion_effects") or {}
	for k,v in pairs(ingestion_effects) do
		local index = k - 1
		if(index > 0)then
			local effect = unique_status_effects[index]
			if(effect == effect_id)then
				return v
			end
		end
	end
	return 0
end


---Returns the combined status of the `effect_id` on `entity_id` calculated as Stain% + (IngestionSeconds * ingestion_multiplier).
---@param entity_id entity_id
---@param effect_id string
---@param ingestion_multiplier number?
---@return number
GetStatusCombined = function( entity_id, effect_id, ingestion_multiplier)
	--if stain_multiplier == nil then stain_multiplier = 1 end
	ingestion_multiplier = ingestion_multiplier or 1
	return GetStainPercentage(entity_id, effect_id) + GetIngestionSeconds(entity_id, effect_id) * ingestion_multiplier
end
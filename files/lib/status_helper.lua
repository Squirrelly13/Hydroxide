dofile("data/scripts/status_effects/status_list.lua")

local unique_status_effects = {}
local unique_status_effect_added = {}
for k,v in pairs(status_effects)do
  if(v.id ~= nil and not unique_status_effect_added[v.id])then
    unique_status_effect_added[v.id] = true
    table.insert(unique_status_effects, v.id)
  end
end

GetStainPercentage = function( entity_id, effect_id )
  local status_effect_data_component = EntityGetFirstComponentIncludingDisabled( entity_id, "StatusEffectDataComponent" )
  local stain_effects = ComponentGetValue2(status_effect_data_component, "stain_effects")
  for k,v in ipairs(stain_effects) do
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

GetIngestionPercentage = function( entity_id, effect_id )
  local status_effect_data_component = EntityGetFirstComponentIncludingDisabled( entity_id, "StatusEffectDataComponent" )
  local ingestion_effects = ComponentGetValue2(status_effect_data_component, "ingestion_effects")
  for k,v in ipairs(ingestion_effects) do
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
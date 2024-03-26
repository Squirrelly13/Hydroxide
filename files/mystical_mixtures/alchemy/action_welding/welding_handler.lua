local handler = {}

local function EntityGetVariable(entity, name, type)
	local value = nil
	local variable_storages = EntityGetComponentIncludingDisabled(entity, "VariableStorageComponent")
	if(variable_storages ~= nil)then
		for k, v in ipairs(variable_storages)do
			local name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				value = ComponentGetValue2(v, "value_"..type)
			end
		end
	end
	return value
end

local function EntitySetVariable(entity, name, type, value)
	local variable_storages = EntityGetComponentIncludingDisabled(entity, "VariableStorageComponent")
	local has_been_set = false
	if(variable_storages ~= nil)then
		for k, v in ipairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				ComponentSetValue2(v, "value_"..type, value)
				has_been_set = true
			end
		end
	end
	if(has_been_set == false)then
		local comp = {}
		comp.name = name
		comp["value_"..type] = value
		EntityAddComponent2(entity, "VariableStorageComponent", comp)
	end
end

local function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
end

local function Split (inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

if(actions == nil)then
    dofile("data/scripts/gun/gun_actions.lua")
end

local function GetActionWithID(id)
    for k, action in ipairs(actions)do
        if(action.id == id)then
            return action
        end
    end
end

local function RomanNumerals(number)
	local roman = {
		{1000, 'M'},
		{900, 'CM'},
		{500, 'D'},
		{400, 'CD'},
		{100, 'C'},
		{90, 'XC'},
		{50, 'L'},
		{40, 'XL'},
		{10, 'X'},
		{9, 'IX'},
		{5, 'V'},
		{4, 'IV'},
		{1, 'I'},
	}
	local result = ""
	for _, elem in ipairs(roman) do
		local value = elem[1]
		local letter = elem[2]
		while(number >= value)do
			result = result .. letter
			number = number - value
		end
	end
	return result
end

handler.getWeldMap = function(entity_id)
	local existing_enchantments = EntityGetVariable(entity_id, "welds", "string") or ""
	
	--print("Existing enchantments: " .. existing_enchantments)
	
	local list = Split(existing_enchantments, literalize(","))

	local enchantment_map = {}
	for k, v in ipairs(list)do
		local enchantment = GetActionWithID(v)
		if(enchantment_map[v] == nil)then
			enchantment_map[v] = {1, enchantment}
		else
			enchantment_map[v][1] = enchantment_map[v][1] + 1
		end
	end

	return enchantment_map
end

handler.appendEnchantmentString = function(entity_id)
	local action_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemActionComponent")
	if(action_comp ~= nil)then
		local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
		if(item_comp ~= nil)then
			
			local action_id = ComponentGetValue2(action_comp, "action_id")
			local enchantment_string = ""

			local enchantment_map = handler.getWeldMap(entity_id)

			for _, e in pairs(enchantment_map)do
				enchantment_string = enchantment_string .. "(" .. GameTextGetTranslatedOrNot(e[2].name) .. " " .. tostring(RomanNumerals(e[1])) .. ") "
			end
			
			reading_name = true
			for k, a in ipairs(actions)do
				if(a.id == action_id)then
					
					ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )
					ComponentSetValue2( item_comp, "item_name", enchantment_string..GameTextGetTranslatedOrNot(a.name) )
					local ability_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")
					if(ability_component ~= nil)then
						ComponentSetValue2( ability_component, "ui_name", enchantment_string..GameTextGetTranslatedOrNot(a.name) )
					end
					break
				end
			end
		end
	end
end

handler.AddWeld = function(entity_id, action_id)
    local existing_enchantments = EntityGetVariable(entity_id, "welds", "string") or ""
    
    EntitySetVariable(entity_id, "welds", "string", existing_enchantments .. action_id .. ",")

    handler.appendEnchantmentString(entity_id)
end

local GetWand = function (shooter)
    local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
    if inv2comp then
        local active_item = ComponentGetValue2(inv2comp, "mActiveItem")
        if(EntityHasTag(active_item, "wand"))then
            return active_item
        end
    end
    return nil
end

local GetActiveCard = function (wand)
    local wand_actions = EntityGetAllChildren(wand) or {}
    for j = 1, #wand_actions do
        local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
        if itemcomp then
            if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                return wand_actions[j]
            end
        end
    end
    return nil
end


function table.dump(tbl, indentLevel)
	if not indentLevel then indentLevel = 0 end
	local toprint = "{\n"
	indentLevel = indentLevel + 2 
	for key, value in pairs(tbl) do
	  toprint = toprint .. string.rep(" ", indentLevel)
	  if (type(key) == "number") then
		-- Do nothing, we don't want to print out the numeric key
	  elseif (type(key) == "string") then
		toprint = toprint  .. key .. " = "   
	  end
	  if (type(value) == "number") then
		toprint = toprint .. value .. ",\n"
	  elseif (type(value) == "string") then
		toprint = toprint .. "\"" .. value .. "\",\n"
	  elseif (type(value) == "table") then
		toprint = toprint .. table.dump(value, indentLevel) .. ",\n" -- Use table.dump instead of tprint
	  else
		toprint = toprint .. "\"" .. tostring(value) .. "\",\n"
	  end
	end
	toprint = toprint .. string.rep(" ", indentLevel-2) .. "}"
	return toprint
end

handler.hook = function(action, recursion_level, iteration)

    local shooter_entity = GetUpdatedEntityID()

    local wand_entity = GetWand(shooter_entity)

    if(wand_entity == nil)then
        return
    end

    local card = GetActiveCard(wand_entity)

	--print("Welding: " .. tostring(card))

	if(card == nil)then
		return
	end

    local weld_map = handler.getWeldMap(card)

	--print(table.dump(weld_map))

	local map_empty = true
	for k, v in pairs(weld_map)do
		map_empty = false
		break
	end

	local enhancement_old_add_projectile = add_projectile
			
	local enhancement_old_add_projectile_trigger_timer = add_projectile_trigger_timer

	local enhancement_old_add_projectile_trigger_hit_world = add_projectile_trigger_hit_world

	local enhancement_old_add_projectile_trigger_death = add_projectile_trigger_death

	local enhancement_old_draw_actions = draw_actions

	local captured_data = {
		timer = {},
		hit_world = {},
		death = {},
		extra_mana = 0,
	}

	local extra_projectile_count = 1

	local enhancement_extra_entities = {}

	add_projectile = function( entity_filename, a, b, c, is_volley )
		extra_projectile_count = extra_projectile_count + 1
		table.insert(enhancement_extra_entities, entity_filename)
	end
	
	add_projectile_trigger_timer = function( entity_filename, delay_frames, action_draw_count, a, b, c, is_volley )
		for i = 1, action_draw_count or 1 do
			table.insert(enhancement_extra_entities, entity_filename)
			extra_projectile_count = extra_projectile_count + 1
		end
		table.insert(captured_data.timer, {
			entity_filename = entity_filename,
			delay_frames = delay_frames,
			action_draw_count = action_draw_count,
		})
		
	end
	
	add_projectile_trigger_hit_world = function( entity_filename, action_draw_count, a, b, c, is_volley )
		for i = 1, action_draw_count or 1 do
			table.insert(enhancement_extra_entities, entity_filename)
			extra_projectile_count = extra_projectile_count + 1
		end
		table.insert(captured_data.hit_world, {
			entity_filename = entity_filename,
			action_draw_count = action_draw_count,
		})
	end
	
	add_projectile_trigger_death = function( entity_filename, action_draw_count, a, b, c, is_volley )
		for i = 1, action_draw_count or 1 do
			table.insert(enhancement_extra_entities, entity_filename)
			extra_projectile_count = extra_projectile_count + 1
		end
		table.insert(captured_data.death, {
			entity_filename = entity_filename,
			action_draw_count = action_draw_count,
		})
	end

	

	draw_actions = function(c, v)
		if(c > 1)then
			enhancement_old_draw_actions(c, v)
		end
	end

	local black_holes = {
		black_hole = true,
		black_hole_death_trigger = true,
		black_hole_big = true,
		black_hole_giga = true,
		copith_vacuum_claw = true
	}

	local is_blackhole = false

	local additional_mana = 0
	local weld_count = 0

	for k, elem in pairs(weld_map or {})do
        local count = elem[1]
        local action = elem[2]

		--GamePrint(k)

		if(black_holes[string.lower(k)])then
			is_blackhole = true
		end

        for i = 1, count do
			--GamePrint(action.id)
			weld_count = weld_count + 1
			additional_mana = additional_mana + (action.mana or 0)
            action.action(recursion_level, iteration, nil, nil, nil, nil, nil, nil, nil, true)
        end
		--func(recursion_level, iteration, nil, nil, nil, true)
	end

	captured_data.extra_mana = additional_mana / weld_count

	add_projectile = enhancement_old_add_projectile

	add_projectile_trigger_timer = enhancement_old_add_projectile_trigger_timer

	add_projectile_trigger_hit_world = enhancement_old_add_projectile_trigger_hit_world

	add_projectile_trigger_death = enhancement_old_add_projectile_trigger_death

	draw_actions = enhancement_old_draw_actions

	for k, v in pairs(enhancement_extra_entities)do
		c.extra_entities = c.extra_entities .. v .. ","
	end

	c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/mystical_mixtures/alchemy/action_welding/spawn.xml,"



	c.speed_multiplier = c.speed_multiplier / extra_projectile_count

	local did_fix = false
	--[[for spell, enhancements in pairs() do
		for i, enhancement in ipairs(enhancements) do
			if(black_holes[string.lower(enhancement)] ~= nil and not did_fix)then
				did_fix = true
				c.extra_entities = c.extra_entities .. "mods/evaisa.enhance/files/blackhole_tag.xml,"
			end
		end
	end]]


	if(is_blackhole)then
		c.extra_entities = c.extra_entities .. "mods/Hydroxide/files/mystical_mixtures/alchemy/action_welding/blackhole_tag.xml,"
	end


	return captured_data
end


return handler
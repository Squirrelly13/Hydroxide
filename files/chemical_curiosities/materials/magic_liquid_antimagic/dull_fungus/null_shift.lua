dofile_once("mods/Hydroxide/lib/squirreltilities.lua")


NullShiftData = {
	materials = dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift_table.lua"),
	custom_functions = {}, --for custom behaviour based on stuff like location, inspired by how Fungal Shifts have some fun stuff
	log_messages = { --in case someone wants to modify the message options
		"$log_cc_nullified_trip_00",
		"$log_cc_nullified_trip_01",
		"$log_cc_nullified_trip_02",
		"$log_cc_nullified_trip_03",
		"$log_cc_nullified_trip_04",
		"$log_cc_nullified_trip_05",
	},
	null_shift_limit = 10 --in case someone wants to increase the limit
}



local function return_false() return false end

function NullShift(shifter, x, y, ignore_cooldown, ignore_limit, DEBUG_NULLSHIFT_ALL)

	for _, func in ipairs(NullShiftData.custom_functions) do
		if func(shifter, x, y) then return end
	end

	for _, entry in ipairs(NullShiftData.materials) do
		if GameHasFlagRun("cc_null_shifted_" .. entry.main_material) then entry.condition = return_false end
	end --prevent the same null shift happening twice

	local frame = GameGetFrameNum()
	local last_shift = tonumber(GlobalsGetValue("fungal_shift_last_frame", "-1000000")) --shares cooldown with fungal shifting
	if frame < last_shift + 18000 and not ignore_cooldown then return end

	local iteration = tonumber(GlobalsGetValue("cc_null_shift_iteration", "0"))
	if iteration >= NullShiftData.null_shift_limit and not ignore_limit then return end


	SetRandomSeed( 89346, 42345 + iteration )
	local held_material

	if shifter and Random(1, 2) == 1 then
		local children = EntityGetAllChildren(shifter)
		if children ~= nil then
			local inventory2_comp = EntityGetFirstComponentIncludingDisabled(shifter, "Inventory2Component" )
			if inventory2_comp ~= nil then
				local active_item = tonumber(ComponentGetValue2(inventory2_comp, "mActiveItem"))
				if active_item ~= nil and (EntityHasTag(active_item, "potion") or EntityHasTag(active_item, "powder_stash")) then
					local mat = GetMaterialInventoryMainMaterial(active_item)
					held_material = CellFactory_GetName(mat)
					if held_material == "air" or CellFactory_HasTag(mat, "CC_NULL_SHIFT_IGNORE") then
						held_material = nil
					end
				end
			end
		end
	end

	if held_material then
		ConvertMaterialEverywhere(CellFactory_GetType(held_material), CellFactory_GetType("cc_air"))
	elseif not DEBUG_NULLSHIFT_ALL then
		local data = {
			shifter = shifter,
			x = x,
			y = y,
		}

		local target = ConditionalRandomFromTable(NullShiftData.materials, data)
		if target == nil then print_error("final target null shift table is nil, null shift cancelled.") return end

		--target_name = GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(target.name_material or target.materials[1])))
		ConvertMaterialEverywhere(CellFactory_GetType(target.main_material), CellFactory_GetType("cc_air"))
		for _, material in ipairs(target.variants or {}) do
			ConvertMaterialEverywhere(CellFactory_GetType(material), CellFactory_GetType("cc_air"))
		end
		GameAddFlagRun("cc_null_shifted_" .. target.main_material)
	end

	if DEBUG_NULLSHIFT_ALL then
		for _, target in ipairs(NullShiftData.materials) do
			ConvertMaterialEverywhere(CellFactory_GetType(target.main_material), CellFactory_GetType("cc_air"))
			for _, material in ipairs(target.variants or {}) do
				ConvertMaterialEverywhere(CellFactory_GetType(material), CellFactory_GetType("cc_air"))
			end
		end
	end


	GlobalsSetValue("fungal_shift_last_frame", tostring(frame))
	GlobalsSetValue("cc_null_shift_iteration", tostring(iteration + 1))
	GamePrintImportant(NullShiftData.log_messages[Random(1, #NullShiftData.log_messages)], "$logdesc_cc_nullified_trip", "mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/3piece_null_shift.png" )

	if shifter then
		-- add ui icon
		local add_icon = true
		local children = EntityGetAllChildren(shifter)
		if children ~= nil then
			for _,it in ipairs(children) do
				if ( EntityGetName(it) == "cc_null_shift_ui_icon") then
					add_icon = false
					break
				end
			end
		end --do this instead of check global cuz of mp i think

		if add_icon then
			local icon_entity = EntityCreateNew("cc_null_shift_ui_icon")
			EntityAddComponent2(icon_entity, "UIIconComponent", {
				name = "$status_cc_nullified_trip",
				description = "$statusdesc_cc_nullified_trip",
				icon_sprite_file = "mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift.png"
			})
			EntityAddChild(shifter, icon_entity)
		end
		EntityRemoveIngestionStatusEffect(shifter, "CC_NULL_TRIP")
	end
end
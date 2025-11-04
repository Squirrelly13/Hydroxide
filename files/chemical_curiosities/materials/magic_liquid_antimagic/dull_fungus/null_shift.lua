dofile_once("mods/Hydroxide/lib/squirreltilities.lua")

local null_materials = dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift_table.lua")

null_log_messages =
{
	"$log_cc_nullified_trip_00",
	"$log_cc_nullified_trip_01",
	"$log_cc_nullified_trip_02",
	"$log_cc_nullified_trip_03",
	"$log_cc_nullified_trip_04",
	"$log_cc_nullified_trip_05",
}

null_shift_limit = 10


function get_held_item_material( entity_id )

	return 0
end




function NullShift(shifter, x, y, ignore_cooldown, ignore_limit, DEBUG_NULLSHIFT_ALL)

	local frame = GameGetFrameNum()
	local last_shift = tonumber(GlobalsGetValue("fungal_shift_last_frame", "-1000000")) --shares cooldown with fungal shifting
	if frame < last_shift + 18000 and not ignore_cooldown then return end

	local iteration = tonumber(GlobalsGetValue("cc_null_shift_iteration", "0"))
    if iteration >= null_shift_limit and not ignore_limit then return end


	local seed2 = 42345 + iteration
	SetRandomSeed( 89346, seed2 )
	local rnd = random_create( 9123, seed2 )
    local held_material

    if shifter and Random(1, 2) == 1 then
        local children = EntityGetAllChildren(shifter)
        if children ~= nil then
            local inventory2_comp = EntityGetFirstComponentIncludingDisabled(shifter, "Inventory2Component" )
            if inventory2_comp ~= nil then
                local active_item = tonumber(ComponentGetValue(inventory2_comp, "mActiveItem"))
                if active_item ~= nil and (EntityHasTag(active_item, "potion") or EntityHasTag(active_item, "powder_stash")) then
                    held_material = CellFactory_GetName(GetMaterialInventoryMainMaterial(active_item))
                    if held_material == "air" then held_material = nil end
                end
            end
        end
    end

    if held_material then
        --target_name = GameTextGetTranslatedOrNot(CellFactory_GetUIName(held_material))
        ConvertMaterialEverywhere(CellFactory_GetType(held_material), CellFactory_GetType("cc_air"))
    elseif not DEBUG_NULLSHIFT_ALL then
        local target
        for i = 1, 10 do
            target = RandomFromTable(null_materials)
            if target == nil then print_error("target null shift table is nil on attempt ["..i.."], retrying...") return end
            if target.condition and not target:condition() then return end --check if there's a condition function and runs it if so
            break
        end

        if target == nil then print_error("final target null shift table is nil, null shift cancelled.") return end

        --target_name = GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(target.name_material or target.materials[1])))
        ConvertMaterialEverywhere(CellFactory_GetType(target.main_material), CellFactory_GetType("cc_air"))
        for index, material in ipairs(target.variants or {}) do
            ConvertMaterialEverywhere(CellFactory_GetType(material), CellFactory_GetType("cc_air"))
        end
    end

    if DEBUG_NULLSHIFT_ALL then
        for index, target in ipairs(null_materials) do
            ConvertMaterialEverywhere(CellFactory_GetType(target.main_material), CellFactory_GetType("cc_air"))
            for index, material in ipairs(target.variants or {}) do
                ConvertMaterialEverywhere(CellFactory_GetType(material), CellFactory_GetType("cc_air"))
            end
        end
    end


    GlobalsSetValue("fungal_shift_last_frame", tostring(frame))
    GlobalsSetValue("cc_null_shift_iteration", tostring(iteration + 1))
    GamePrintImportant( random_from_array( null_log_messages ), GameTextGet("$logdesc_cc_nullified_trip"), "mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/3piece_null_shift.png" )

    if shifter then
        -- add ui icon
        local add_icon = true
        local children = EntityGetAllChildren(shifter)
        if children ~= nil then
            for i,it in ipairs(children) do
                if ( EntityGetName(it) == "cc_null_shift_ui_icon") then
                    add_icon = false
                    break
                end
            end
        end

        if add_icon then
            local icon_entity = EntityCreateNew("cc_null_shift_ui_icon")
            EntityAddComponent(icon_entity, "UIIconComponent", {
                name = "$status_cc_nullified_trip",
                description = "$statusdesc_cc_nullified_trip",
                icon_sprite_file = "mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift.png"
            })
            EntityAddChild(shifter, icon_entity)
        end
    end

end
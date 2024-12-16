dofile_once("data/scripts/lib/utilities.lua")

null_materials = {
	{
        probability = 1.0,
        materials = { "water", "water_static", "water_salt", "water_ice" },
        name_material = "water",
    },
	{
        probability = 1.0,
        materials = { "blood_fungi", "fungi", "fungisoil" },
        name_material = "fungi",
    },
	{
        probability = 1.0,
        materials = { "blood_cold", "blood_worm", "blood" },
        name_material = "blood"
    },
	{
        probability = 1.0,
        materials = { "acid", "cc_hydroxide" },
        name_material = "acid",
    },
	{
        probability = 0.4,
        materials = { "acid_gas", "acid_gas_static", "poison_gas", "fungal_gas", "radioactive_gas", "radioactive_gas_static", "cc_hydroxide_gas", "cc_methane" },
        name_material = "acid_gas",
    },
	{
        probability = 0.4,
        materials = { "magic_liquid_polymorph", "magic_liquid_unstable_polymorph", "magic_liquid_random_polymorph"},
        name_material = "magic_liquid_polymorph",
    },
}

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

function NullShift(shifter, x, y, ignore_cooldown, ignore_limit)


	local frame = GameGetFrameNum()
	local last_shift = tonumber(GlobalsGetValue("fungal_shift_last_frame", "-1000000")) --shares cooldown with fungal shifting
    print("frame = " .. frame)
    print("last_shift = " .. last_shift)
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
                    local held_material = GetMaterialInventoryMainMaterial(active_item)
                end
            end
        end
    end

    local target_name
    if held_material then
        --target_name = GameTextGetTranslatedOrNot(CellFactory_GetUIName(held_material))
        ConvertMaterialEverywhere(CellFactory_GetType(held_material), CellFactory_GetType("cc_air"))
    else
        local target = pick_random_from_table_weighted(rnd, null_materials)
        if target == nil then print_error("target null shift table is nil") return end

        --target_name = GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(target.name_material or target.materials[1])))
        for index, material in ipairs(target.materials) do
            ConvertMaterialEverywhere(CellFactory_GetType(material), CellFactory_GetType("cc_air"))
        end
    end

    GlobalsGetValue("fungal_shift_last_frame", tostring(frame))
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
                icon_sprite_file = "mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/ui_null_shift.png"
            })
            EntityAddChild(shifter, icon_entity)
        end
    end

end
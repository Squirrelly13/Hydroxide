dofile_once("data/scripts/lib/utilities.lua")

null_materials = {
	{
        probability = 1.0,
        materials = { "water", "water_static", "water_salt", "water_ice" },
        name_material = "water"
    }
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


function get_held_item_material( entity_id )

	return 0
end

function NullShift(shifter, x, y, ignore_cooldown, ignore_limit)


	local frame = GameGetFrameNum()
	local last_shift = tonumber(GlobalsGetValue("fungal_shift_last_frame", "-1000000")) --shares cooldown with fungal shifting
	if frame < last_shift + 18000 and not ignore_cooldown then return end

	local iteration = tonumber( GlobalsGetValue( "cc_null_shift_iteration", "0" ) )


	local seed2 = 42345 + iteration
	SetRandomSeed( 89346, seed2 )
	local rnd = random_create( 9123, seed2 )
    local target = pick_random_from_table_weighted(rnd, null_materials)
    local held_material

    if Random(1, 2) == 1 then
        local children = EntityGetAllChildren(shifter)
        if children ~= nil then
            local inventory2_comp = EntityGetFirstComponentIncludingDisabled(shifter, "Inventory2Component" )
            if inventory2_comp ~= nil then
                local active_item = tonumber(ComponentGetValue(inventory2_comp, "mActiveItem"))
                if active_item ~= nil and (EntityHasTag(active_item, "potion") or EntityHasTag(active_item, "powder_stash")) then
                    held_material = GetMaterialInventoryMainMaterial(active_item)
                end
            end
        end
    end

end
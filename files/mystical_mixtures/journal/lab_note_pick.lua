dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/game_helpers.lua" )

dofile("mods/Hydroxide/files/mystical_mixtures/journal/entries.lua")

function item_pickup( entity_item, entity_who_picked, item_name )
	local pos_x, pos_y = EntityGetTransform( entity_item )

	-- load the gold_value from VariableStorageComponent
	local components = EntityGetComponentIncludingDisabled( entity_item, "VariableStorageComponent" )

    local entry = ""

	if ( components ~= nil ) then
		for key,comp_id in pairs(components) do
			local var_name = ComponentGetValue2( comp_id, "name" )
			if( var_name == "entry_id") then
				entry = ComponentGetValue2( comp_id, "value_string" )
			end
		end
	end

    if(entry ~= "")then
        local entry_data = nil
        for _, v in ipairs(journal_entries) do
            if(v.id == entry)then
                entry_data = v
                break
            end
        end

        if(entry_data == nil)then
            return
        end


        GamePrintImportant("$log_mm_lab_note_pickup", entry_data.title)


        if(entry_data.custom_unlock_flag ~= nil)then
            AddFlagPersistent(entry_data.custom_unlock_flag)
        else
            AddFlagPersistent("journal_entry_unlocked_"..entry_data.id)
        end
    end

    EntityKill(entity_item)
end
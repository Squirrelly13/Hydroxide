dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

-- This file can't access other files from this or other mods in all circumstances.
-- Settings will be automatically saved.
-- Settings don't have access unsafe lua APIs.

-- Use ModSettingGet() in the game to query settings.
-- For some settings (for example those that affect world generation) you might want to retain the current value until a certain point, even
-- if the player has changed the setting while playing.
-- To make it easy to define settings like that, each setting has a "scope" (e.g. MOD_SETTING_SCOPE_NEW_GAME) that will define when the changes
-- will actually become visible via ModSettingGet(). In the case of MOD_SETTING_SCOPE_NEW_GAME the value at the start of the run will be visible
-- until the player starts a new game.
-- ModSettingSetNextValue() will set the buffered value, that will later become visible via ModSettingGet(), unless the setting scope is MOD_SETTING_SCOPE_RUNTIME.

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "Hydroxide" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings = 
{
	{
		id = "mod_title",
		ui_name = "Squirrelly's Chemical Curiosities",
		ui_description = "A sequel/remastering of Evaisa's Arcane Alchemy!",
		not_setting = true,
	},
	{
		id = "warning",
		ui_name = "WARNING! SETTINGS MAY BE UNSTABLE",
		ui_description = "a few settings may be somewhat unstable when changed from default. Disabling bloomium should be fine, but I have not finished the others yet -UserK",
		not_setting = true,
	},
	{
		category_id = "CC_SETTINGS",
		ui_name = "Chemical Curiosities",
		ui_description = "Settings and Options for configuring Chemical Curiosities content",
		foldable = true,
		_folded = true,
		settings = {

			{
				id = "CC_MATERIALS",
				ui_name = "Chemical Curiosities Materials",
				ui_description = "Adds Chemical Curiosities' Materials to your game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_FLASKS",
				ui_name = "Spawn Potions",
				ui_description = "Allow for Chemical Curiosities to add new materials in flasks",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_SPELLS",
				ui_name = "Spells",
				ui_description = "Allow for Chemical Curiosities to add spells to your game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_PROPS",
				ui_name = "Spawn Props",
				ui_description = "Allow Chemical Curiosities to spawn various props in the world",
				value_default = true,				
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_ITEMS",
				ui_name = "Chemical Curiosities Items",
				ui_description = "Adds Chemical Curiosities' Items to the game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_STRUCTURES",
				ui_name = "Spawn Structures",
				ui_description = "Allow Chemical Curiosities to spawn rare and hidden unique structures in the world",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "CC_ORES",
				ui_name = "Spawn Ores",
				ui_description = "Spawn Various ores throughout the world! (W.I.P)",
				value_default = false,				
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			}
		}
	},

	{
		category_id = "AA_SETTINGS",
		ui_name = "Arcane Alchemy",
		ui_description = "Settings and Options for configuring Chemical Curiosities content",
		foldable = true,
		_folded = true,
		settings = {
			{
				id = "AA_MATERIALS",
				ui_name = "Arcane Alchemy Materials",
				ui_description = "Adds Arcane Alchemy's Materials to your game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "AA_FLASKS",
				ui_name = "Spawn Potions",
				ui_description = "Allow for Chemical Curiosities to add new materials in flasks",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "AA_SPELLS",
				ui_name = "Spells",
				ui_description = "Allow for Chemical Curiosities to add spells to your game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			-- {
			-- 	id = "AA_PROPS",
			-- 	ui_name = "Spawn Props",
			-- 	ui_description = "Allow Chemical Curiosities to spawn various props in the world",
			-- 	value_default = true,				
			-- 	scope = MOD_SETTING_SCOPE_NEW_GAME,
			-- }, --this is already included in structures, i dont know why i added this
			{
				id = "AA_ITEMS",
				ui_name = "Chemical Curiosities Items",
				ui_description = "Adds Chemical Curiosities' Items to the game",
				value_default = true,
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
			{
				id = "AA_BLOOMIUM_IS_ENABLED",
				ui_name = "Bloomium",
				value_default = true,
				ui_description = "Yes, you can now disable Bloomium",
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			}
		}
	}
}

-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )

	--example usage:
	--[[
	local im_id = 124662 -- NOTE: ids should not be reused like we do below
	GuiLayoutBeginLayer( gui )

	GuiLayoutBeginHorizontal( gui, 10, 50 )
    GuiImage( gui, im_id + 12312535, 0, 0, "data/particles/shine_07.xml", 1, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndPause )
    GuiImage( gui, im_id + 123125351, 0, 0, "data/particles/shine_04.xml", 1, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndPause )
    GuiLayoutEnd( gui )

	GuiBeginAutoBox( gui )

	GuiZSet( gui, 10 )
	GuiZSetForNextWidget( gui, 11 )
	GuiText( gui, 50, 50, "Gui*AutoBox*")
	GuiImage( gui, im_id, 50, 60, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiZSetForNextWidget( gui, 13 )
	GuiImage( gui, im_id, 60, 150, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )

	GuiZSetForNextWidget( gui, 12 )
	GuiEndAutoBoxNinePiece( gui )

	GuiZSetForNextWidget( gui, 11 )
	GuiImageNinePiece( gui, 12368912341, 10, 10, 80, 20 )
	GuiText( gui, 15, 15, "GuiImageNinePiece")

	GuiBeginScrollContainer( gui, 1233451, 500, 100, 100, 100 )
	GuiLayoutBeginVertical( gui, 0, 0 )
	GuiText( gui, 10, 0, "GuiScrollContainer")
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiLayoutEnd( gui )
	GuiEndScrollContainer( gui )

	local c,rc,hov,x,y,w,h = GuiGetPreviousWidgetInfo( gui )
	print( tostring(c) .. " " .. tostring(rc) .." " .. tostring(hov) .." " .. tostring(x) .." " .. tostring(y) .." " .. tostring(w) .." ".. tostring(h) )

	GuiLayoutEndLayer( gui )
	]]--
end

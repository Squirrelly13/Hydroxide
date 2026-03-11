dofile_once("data/scripts/lib/mod_settings.lua")

--- note for anyone viewing this file:
---mod assets are not loaded on the main menu, which means we can't split our work into more than one file or use custom libs or sprites
---just wanted to justify why this file is (as of last updating this comment) 1453 lines

local mod_id = "Hydroxide"
mod_settings_version = 1

local function get_setting_id(name)
	return mod_id .. "." .. name
end

local mods_are_loaded = #ModGetActiveModIDs() > 0

local languages = { --translation keys
	["English"] = "en",
	["русский"] = "ru",
	["Português (Brasil)"] = "ptbr",
	["Español"] = "eses",
	["Deutsch"] = "de",
	["Français"] = "frfr",
	["Italiano"] = "it",
	["Polska"] = "pl",
	["简体中文"] = "zhcn",
	["日本語"] = "jp",
	["한국어"] = "ko",
	["Українська"] = "ukr",
	["Türkçe"] = "trtr",
}
local langs_in_order = { --do this cuz key-indexed tables wont keep this order
	"en",
	"ru",
	"ptbr",
	"eses",
	"de",
	"frfr",
	"it",
	"pl",
	"zhcn",
	"jp",
	"ko",
	"ukr",
	"trtr",
}

local current_language = languages[GameTextGetTranslatedOrNot("$current_language")] or "unknown"
local cached_lang

--global table so mods can add their own settings or modify global magic numbers
ChemicalCuriosities_Settings = {
	custom_setting_types = {}, --custom settings handling, in case someone does something like that
	offset_amount = 15, --indentation caused by nested settings
	desc_line_gap = 12, --distance betwen the start of one line and the start of the next
	tooltip_buffer = 11, --buffer distance required between the end of a tooltip and the edge of the game screen used for linebreaks
	extra_line_sep = 2, --distance between normal descriptions and extra lines
}
local ccs = ChemicalCuriosities_Settings




--To add translations, add them below the same way English (en) languages have been added.
--Translation Keys can be seen in the `languages` table above
ccs.translation_strings = {
	--`mod_ingame_warning` and `mods` are currently unused
	mod_ingame_warning = { --a few TLs are reused from Parallel Parity, they should be fine
		en = "Warning! Options for other mods will not show up here!",
		en_desc = "Due to fundamental limitations with the Modding API, mods cannot interact with one another until the game begins.\nPlease enter a run if you wish to see settings related to other mods",
		ptbr = "Aviso! Opções para outros mods não iram aparecer aqui!",
		ptbr_desc = "Por conta de limitações com a Modding API, mods não poderam interagir um com o outro até que o jogo inicie.\nPor favor, entre em uma run se deseja ver opções relacionadas a outros mods",
		de = "Warnung! Einstellungen für andere Mods werden hier nicht angezeigt!",
		de_desc = "Aufgrund grundlegender Limitationen mit der Modding API können Mods erst bei Spielbeginn miteinander interagieren. \nStarte ein Spiel, um Einstellungen bezüglich anderer Mods zu sehen.",
	},
	mods = { --currently not used, may be used in the future
		en = "Mods",
		en_desc = "Content added by various mods",
		ptbr = "Mods",
		ptbr_desc = "Conteúdo adicionado por vários mods",
		de = "Mods",
		de_desc = "Inhalte hinzugefügt von verschiedenen Mods",
		mod_compat_restart = {
			en = "Restart to apply settings!",
			en_desc = "It is highly recommended you restart your game to apply compatibility settings changes!\nSorry about the inconvenience, mod settings are inherently limited and things like this are necessary for this to work :(",
			ptbr = "Reinicie para aplicar as configurações!",
			ptbr_desc = "É altamente recomendado reiniciar o jogo para aplicar as mudanças das configurações de compatibilidade!\nPeço desculpas pelo inconveniente, configurações de mods são por natureza limitadas e coisas desse tipo são necessárias para fazer isso tudo funcionar :(",
			de = "Starte das Spiel neu um Änderungen anzuwenden!",
			de_desc = "Es ist stark empfohlen, das Spiel neuzustarten um Kompatibilitätseinstellungsänderungen anzuwenden!\n'Tschuldigung, geht leider nicht anders, da Mod-Einstellungen nunmal stark limitiert sind :(",
		},
		no_mods_detected = {
			en = "No mod settings found!",
			en_desc = "Sorgy, nothing here",
			ptbr = "Nenhuma configuração de mod encontrada!",
			ptbr_desc = "Descurpa, nada aqui",
			de = "Keine Modeinstellungen verfügbar!",
			de_desc = "Sowwy, nix hier :(",
		},
	},

	global = {
		en = "Global",
		en_desc = "Settings that apply to all aspects of the mod",
		max_material_projectiles = {
			en = "Maximum Material-Projectiles",
			en_desc = "The maximum number of projectiles that can be spawned by materials from this mod."
		},
	},
	cc = {
		en = "Chemical Curiosities",
		en_desc = "",
		enabled = {
			en = "Enabled",
			en_desc = "Enables content from the Chemical Curiosities module."
		},
		oregen = {
			en = "Spawn Ores",
			en_desc = "Spawn Various ores throughout the world! (this feature is currently being reworked)"
		},
		{
			en = "Methane Effect Multiplier",
			en_desc = "Control the strength of the Methane shader effect"
		}
	},
	aa = {
		en = "Arcane Alchemy",
		enabled = {
			en = "Enabled",
			en_desc = "Enables content from the Chemical Curiosities module."
		},
		bloomium = {
			en = "Bloomium",
			en_desc = "Allow Bloomium to appear in your runs"
		}
	},
	mm = {
		en = "Mystical Mixtures",
		enabled = {
			en = "Enabled",
			en_desc = "Enables content from the Mystical Mixtures module."
		},
	},
	t = {
		en = "Terror",
		enabled = {
			en = "Enabled",
			en_desc = "Enables content from the Terror module."
		},
	},
	reset = {
		en = "[Reset]",
		en_desc = "Resets all settings to default values",
		ptbr = "[Resetar]",
		ptbr_desc = "Redefine todas as configurações para os valores padrão",
		de = "[Zurücksetzen]",
		de_desc = "Setzt alle Einstellungen auf ihre Standartwerte zurück",
	},
	translation_credit = {
		en = "Translation Credits",
		ptbr = "Créditos de Tradução",
		de = "Übersetzungsdanksagung",
	},

	data = { --translations for non-settings
		extra_lines = {
			scope_new_run = {
				en = "Changes will apply on your next run",
			},
			scope_restart = {
				en = "Changes will apply when you next restart or on your next run",
			},
			missing_translation = {
				en = "(Missing %s translation)", --default (you do not need to use %s)
				en_example = "(Missing English translation)" --  <-- example on how it should be written
			}
		},
		mod_title = { --todo: colour the words separately
			en = {"Squirrelly's ", "Chemical ", "Curiosities"}, --split into 3 cuz they are coloured differently, contact me if the order is different so I can go account for that
			en_desc = "A sequel/remastering of Evaisa's Arcane Alchemy, and more!",
		},
	},
}

--TRANSLATOR NOTE! you dont have to worry about `translation_credit_data`, i can handle this myself
-- just please provide the colour value you would like your name to be as well as the translation for "[your translation] by [you]"
-- (if the structure "[text] [translator]" doesnt read well in your language, dw I'll handle it o/)
local translation_credit_data = {
	ptbr = {
		text = "Tradução para português brasileiro por",
		translator = { --does not currently support multiple translators of the same language, will resolve when necessary
			"Absent Friend",
			r = 190/255,
			g = 146/255,
			b = 190/255,
		}
	},
	de = {
		text = "Deutsche Übersetzung von",
		translator = {
			"Xplosy",
			r = 255/255,
			g = 16/255,
			b = 240/255,
		}
	} and nil,
}

--[[ translation line counter (just for when I'm curious how many lines of translateable text there is in this mod), not including `translation_credit_data`
local translatable = 0
local translations = 0
local function func(t)
	if t.en then translatable = translatable + 1 end
	if t.en_desc then translatable = translatable + 1 end
	for _,value in pairs(t) do
		local vtype = type(value)
		if vtype == "table" then
			func(value)
		elseif vtype == "string" then
			translations = translations + 1
		end
	end
end
func(ps.translation_strings)
print("translatable: " .. translatable)
print("translations: " .. translations)
print(("translated: %s%%"):format((translations/(translatable*3))*100))--]]

--[[ injector for ModSettingSet and ModSettingSetValue so i can read the values being changed more easily
local old_modsettingset = ModSettingSet
function ModSettingSet(id, value)
	local prev_value = ModSettingGet(id)
	local str = ("MOD SETTING SET: [%s], %s --> %s"):format(id, prev_value, value)
	if value ~= prev_value then str = str .. "								 ------------------------------" end
	--print(str)
	--old_modsettingset(id, value)
end

local old_modsettingsetnextvalue = ModSettingSetNextValue
function ModSettingSetNextValue(id, value, is_default)
	local prev_value = ModSettingGetNextValue(id)
	local str = ("MOD SETTING SET NEXT VALUE: [%s], %s --> %s"):format(id, prev_value, value)
	if value ~= prev_value then str = str .. "								 ------------------------------" end
	--print(str)
	--old_modsettingsetnextvalue(id, value, is_default)
end --]]



local font_dir
if ModDoesFileExist("mods/Hydroxide/fonts/regular.xml") then
	font_dir = "mods/Hydroxide/fonts/"
else
	font_dir = "../../workshop/content/881100/2866701037/fonts/workshop/"
end --if i cant locate the fonts under the local mods folder, the mod has to be running from the workshop directory

local regular_font = font_dir .. "regular.xml"
local ui_font = font_dir .. "ui.xml"


if mods_are_loaded and DebugGetIsDevBuild() then --custom fonts do not work in-game for noita_dev.exe: https://discord.com/channels/453998283174576133/632303734877192192/1465859077216145541
	regular_font = "data/fonts/font_pixel_noshadow.xml"
	ui_font = "data/fonts/font_pixel_noshadow.xml"
end



local current_scope
local screen_w,screen_h
local description_start_pos
local keyboard_state = 0

local logging = true
local function log(...)
	if logging then
		local str = ""
		for _, value in ipairs({...}) do
			str = str .. tostring(value)
		end
		print(str)
	end
end

local function dump(o, q, r)
	q = q == nil and true
	r = r or 0
	local _t = ('    '):rep(r)
	local t = type(o)
	if t == 'table' then
		local s = '{\n'
		local table_is_empty = true
		for k,v in pairs(o) do
			table_is_empty = false
			if type(k) == 'number' then
				k = '['..k..']'
			elseif q then
				k = '["'..k..'"]'
			end
			s = s .. _t .. '    '..k..' = ' .. dump(v,q,r+1) .. ',\n'
		end
		if table_is_empty then
			return s:sub(1, -2) .. '}'
		else
			return s .. _t .. '}'
		end
	elseif t == "string" then
		return '"' .. tostring(o):gsub("\n", "\\n") .. '"'
	else
		return tostring(o)
	end
end


local function generate_tooltip_data(gui, text, offset_x, extra_lines)
	offset_x = offset_x or 0

	local data = {
		lines = {},
		w = 0,
		h = 0,
	}

	local line_length_max = screen_w - description_start_pos - ccs.tooltip_buffer - offset_x
	local max_line_length = 0

	local function line_break(target_line)
		local split_lines = {}
		local current_line = ""
		for word in target_line:gmatch("%S+") do
			local test_line = (current_line == "") and word or current_line .. " " .. word
			local test_line_w = GuiGetTextDimensions(gui, test_line, 1, 2, regular_font)
			if test_line_w > line_length_max then
				split_lines[#split_lines + 1] = current_line
				current_line = word
			else
				if test_line_w > max_line_length then max_line_length = test_line_w end
				current_line = test_line
			end
		end
		-- Add the last line if it's not empty
		if current_line ~= "" then split_lines[#split_lines + 1] = current_line end


		return split_lines
	end --i actually realised i didnt need to modularise this when i realised I could instead modularise split_lines, may recombine


	local function split_lines(str)
		local lines = {}
		for line in string.gmatch(str, '([^\n]+)') do
			local line_w = GuiGetTextDimensions(gui, str or "", 1, 2, regular_font)
			if line_w > line_length_max then
				local split_lines = line_break(line)

				local a = #lines
				for i, split_line in ipairs(split_lines) do
					lines[a+i] = split_line
				end
			else
				if line_w > max_line_length then max_line_length = line_w end
				lines[#lines+1] = line
			end
		end


		return lines
	end


	local x_pos = 0
	local y_pos = 0

	if text then
		for i, line in ipairs(split_lines(text)) do
			data.lines[#data.lines+1] = {
				text = line,
				x = x_pos,
				y = y_pos,
				c = {
					r = 1,
					g = 1,
					b = 1,
				},
			}

			y_pos = y_pos + ccs.desc_line_gap
		end
	end


	if extra_lines then
		for key, value in pairs(extra_lines) do
			if #data.lines > 0 then
				y_pos = y_pos + ccs.extra_line_sep
			end

			for i, line in ipairs(split_lines(value.text)) do
				data.lines[#data.lines+1] = {
					text = line,
					x = x_pos,
					y = y_pos,
					c = value.c or {
						r = 1,
						g = 1,
						b = 1,
					},
				}

				y_pos = y_pos + ccs.desc_line_gap
			end
		end
	end

	if #data.lines == 0 then return end

	data.w = max_line_length - 1 --save afterwards in case it was entended by extra_lines
	data.h = (#data.lines * (ccs.desc_line_gap + 1)) - 1

	return data
end

--MOD_SETTING_SCOPE_NEW_GAME
--MOD_SETTING_SCOPE_RUNTIME_RESTART
--MOD_SETTING_SCOPE_RUNTIME
local scopes = {
	"scope_new_run",
	"scope_restart",
	--"scope_runtime", --this should be unused
}

local function SettingUpdate(gui, setting, translation)
	setting.extra_lines = setting.extra_lines or {}

	if translation then
		setting.name = translation[current_language] or translation.en or setting.id
		if translation.en_desc and not translation[current_language] then --if there is english translation but no other translation
			setting.description = translation.en_desc-- .. string.format("\n(Missing %s translation)", GameTextGetTranslatedOrNot("$current_language"))
			setting.extra_lines.missing_translation = ccs.data.extra_lines.missing_translation
		else
			setting.description = translation[current_language .. "_desc"]
		end
	else
		setting.name = setting.name or setting.id
	end

	if ModSettingGet(setting.path) ~= ModSettingGetNextValue(setting.path) then
		setting.extra_lines.scope_warning = ccs.data.extra_lines[scopes[setting.scope+1]]
	else
		setting.extra_lines.scope_warning = nil
	end

	setting.w,setting.h = GuiGetTextDimensions(gui, setting.name or "", 1, 2, regular_font)
	if setting.icon then setting.icon_w,setting.icon_h = GuiGetImageDimensions(gui, setting.icon) end

	if setting.options then
		if translation then
			setting.option_names = {}
			setting.option_descriptions = {}
			setting.option_desc_data = {}

			if translation.options then
				for i, option in ipairs(setting.options) do
					local desc

					if translation.options[option] then
						setting.option_names[i] = translation.options[option][current_language] or translation.options[option].en or option

						if translation.options[option][current_language .. "_desc"] then
							desc = translation.options[option][current_language .. "_desc"]
						elseif translation.options[option].en_desc then
							desc = translation.options[option].en_desc .. string.format("\n(Missing %s translation)", GameTextGetTranslatedOrNot("$current_language"))
						end
					else
						setting.option_names[i] = option
					end

					if desc then
						setting.option_descriptions[i] = desc
						setting.option_desc_data[i] = generate_tooltip_data(gui, desc, (setting.recursion * ccs.offset_amount) + setting.w, setting.extra_lines)
					end
				end
			else
				for i, option in ipairs(setting.options) do
					setting.option_names[i] = option
				end
			end
		else
			local descs = setting.option_descriptions or {}
			for i,_ in ipairs(setting.options) do
				setting.option_desc_data[i] = generate_tooltip_data(gui, descs[i], (setting.recursion * ccs.offset_amount) + setting.w, setting.extra_lines)
			end
		end
		setting.current_option = ModSettingGetNextValue(setting.path) or setting.value_default
		setting.current_option_int = 1
		for index, value in ipairs(setting.options) do
			if value == setting.value_default then setting.value_default_int = index end
			if value == setting.value_recommended then setting.value_recommended_int = index end
			if value == setting.value_on then setting.value_on_int = index end
			if value == setting.value_off then setting.value_off_int = index end

			if value == setting.current_option then setting.current_option_int = index end
		end

		setting.value_default = setting.value_default or 1
		setting.value_recommended = setting.value_recommended or setting.value_default
		setting.value_on = setting.value_on or setting.value_default
		setting.value_off = setting.value_off or setting.value_default
	end

	if setting.type == "slider" then
		local default_values = {
			min_value = 0,
			max_value = 100,
			width = 100, -- +1 cuz range is inclusive
			value_to_position = function(slider_data)
				return math.floor(((slider_data.current_value-slider_data.min_value)/slider_data.max_value*slider_data.width) + .5)
			end,
			value_to_display = function(slider_data)
				return slider_data.current_value/slider_data.value_multiplier + slider_data.value_offset
			end
		}
		setting.slider_data = setting.slider_data or {}
		for key, value in pairs(default_values) do
			if setting[key] == nil then
				setting[key] = value
			end
		end

		local slider_data = setting.slider_data

		slider_data.current_value = ModSettingGetNextValue(setting.path)
		slider_data.position = slider_data.value_to_position(slider_data.current_value)
		slider_data.display_value = slider_data.value_to_display(slider_data.current_value)
	end

	if setting.description then setting.desc_data = generate_tooltip_data(gui, setting.description, setting.recursion * ccs.offset_amount, setting.extra_lines) end
end

local function SettingSetValue(setting, value)
	if not current_scope then print("SCOPE IS UNDEFINED") return end

	if setting.scope >= current_scope or not mods_are_loaded then
		ModSettingSet(setting.path, value)
	end
	ModSettingSetNextValue(setting.path, value, false)

	SettingUpdate(GuiCreate(), setting)
end



ccs.mod_compat_settings = {
	{
		id = "mod_compat_restart",
		type = "note",
	},
}

--translations are separated for translators' convenience
ccs.settings = {
	{
		id = "mod_title",
		type = "note",
	},
	{
		id = "mod_ingame_warning",
		type = "note",
		render_condition = false, --disabled as we currently don't support external settings
		c = {
			r = .9,
			g = .65,
			b = .65,
		},
		icon = "data/ui_gfx/inventory/icon_warning.png",
		icon_offset_x = -3,
		icon_offset_y = -3,
		text_offset_x = -3,
	},
	{
		id = "mods",
		type = "group",
		items = ccs.mod_compat_settings,
		render_condition = mods_are_loaded,
		collapsed = false,
	},
	{
		id = "global", --GLOBAL SETTINGS
		type = "group",
		items = {
			{
				id = "max_material_projectiles",
				type = "slider",
				value_default = 100,
			},
		},
	},
	{
		id = "cc", --Chemical Curiosities
		type = "group",
		collapsed = true,
		items = {
			{
				id = "enabled",
				value_default = true,
			},
			{
				id = "oregen",
				value_default = true,
			},
			{
				id = "methane_effect_multiplier",
				type = "slider",
				value_default = 100
			},
		},
	},
	{
		id = "aa", --Arcane Alchemy
		type = "group",
		collapsed = true,
		items = {
			{
				id = "enabled",
				value_default = true,
			},
			{
				id = "bloomium",
				value_default = true,
			},
		},
	},
	{
		id = "mm", --Mystical Mixtures
		type = "group",
		collapsed = true,
		items = {
			{
				id = "enabled",
				value_default = true,
			},
		},
	},
	{
		id = "t", --Terror
		type = "group",
		collapsed = true,
		items = {
			{
				id = "enabled",
				value_default = true,
			},
		},
	},
	{
		id = "reset",
		type = "reset_button",
		highlight_c = {
			r = 1,
			g = .7,
			b = .7,
		},
	},
}


ccs.data = {
	extra_lines = {
		scope_new_run = {
			c = {
				r = 241/255,
				g = 241/255,
				b = 139/255,
			},
		},
		scope_restart = {
			c = {
				r = 241/255,
				g = 241/255,
				b = 139/255,
			},
		},
		missing_translation = {
			c = {
				r = 35/255,
				g = 90/255,
				b = 35/255,
			}
		}
	},
}


local settings_convert = {
	MAX_MATERIAL_PROJECTILES = "Hydroxide.global.max_material_projectiles",
	CC_ENABLED = "Hydroxide.cc.enabled",
	CC_ORES = "Hydroxide.cc.oregen",
	CC_METHANE_EFFECT_MULTIPLIER = "Hydroxide.cc.methane_effect_multiplier",
	AA_ENABLED = "Hydroxide.aa.enabled",
	AA_BLOOMIUM = "Hydroxide.aa.bloomium",
	MM_ENABLED = "Hydroxide.mm.enabled",
	TERROR_ENABLED = "Hydroxide.t.enabled",
}


-- some of this code is p nasty tbh, flee all ye of weak heart 'n' all, may rewrite this entirely in the future

function ModSettingsGuiCount()
	return 1
end

local tlcr_data_ordered = {}
---@param init_scope int 3 menu loaded, 2 settings updated (ingame only), 1 restart, 0 new game
---@param is_init bool is being called manually from `mods/Hydroxide/init.lua` (we dont do this yet but might later on idk we'll see)
function ModSettingsUpdate(init_scope, is_init)
	current_scope = init_scope

	current_language = languages[GameTextGetTranslatedOrNot("$current_language")] or "unknown"
	local cached = current_language == cached_lang
	cached_lang = current_language

	local dummy_gui = not is_init and GuiCreate()
	if dummy_gui then
		GuiStartFrame(dummy_gui)
		screen_w = GuiGetScreenDimensions(dummy_gui)

		--[[ source for magic number -160 below
		local inner_gui_width = 342
		local category_offset = 3
		local mod_setting_offset = 3
		local mod_setting_desc_offset = 5
		local start_pos_offset = (inner_gui_width * -.5) + category_offset + mod_setting_offset + mod_setting_desc_offset
		--]]

		description_start_pos = (screen_w * .5) - 160
	end


	if mods_are_loaded then
		if #ccs.mod_compat_settings == 1 then
			table.insert(ccs.mod_compat_settings, {
				id = "no_mods_detected",
				type = "note",
				c = {
					r = .5,
					g = .65,
					b = .9,
				}
			})
		end

		local function add_modded_translation(setting, translation_path)
			if setting.translations then
				translation_path[setting.id] = setting.translations
			else
				translation_path[setting.id] = translation_path[setting.id] or {}
			end

			if setting.items then
				for _, item in ipairs(setting.items) do
					add_modded_translation(item, translation_path[setting.id])
				end
			end
			if setting.dependents then
				for _, dependent in ipairs(setting.dependents) do
					add_modded_translation(dependent, translation_path[setting.id])
				end
			end
			if setting.data then
				for _, dependent in ipairs(setting.data) do
					add_modded_translation(dependent, translation_path[setting.id])
				end
			end
		end

		for _, mod_group in ipairs(ccs.mod_compat_settings) do
			if mod_group.type == "group" and not mod_group.c then
				mod_group.c = {
					r = .2,
					g = .6,
					b = .2,
				}
			end
			add_modded_translation(mod_group, ccs.translation_strings.mods)
		end
		if init_scope > 1 then
			orbs = math.min(GameGetOrbCountThisRun(), 15)
			if orbs == 15 then orbs = 33 end
		end
	end
	original_orbs = orbs

	if dummy_gui then
		tlcr_data_ordered = {}
		local max_len = 0
		for _, lang in ipairs(langs_in_order) do
			if translation_credit_data[lang] then
				tlcr_data_ordered[#tlcr_data_ordered+1] = translation_credit_data[lang]
				tlcr_data_ordered[#tlcr_data_ordered].highlighted = lang == current_language
				tlcr_data_ordered[#tlcr_data_ordered].translator.offset = GuiGetTextDimensions(dummy_gui, tlcr_data_ordered[#tlcr_data_ordered].text, 1, 2, regular_font) + 4
				local curr_x = GuiGetTextDimensions(dummy_gui, tlcr_data_ordered[#tlcr_data_ordered].text .. tlcr_data_ordered[#tlcr_data_ordered].translator[1], 1, 2, regular_font) + 4
				if curr_x > max_len then max_len = curr_x end
			end
		end
		tlcr_data_ordered.size = {max_len, ccs.desc_line_gap * #tlcr_data_ordered}
	end

	local function cache_settings(input_settings, input_translations, path, recursion)
		recursion = recursion or 0
		path = path or ""
		input_settings = input_settings or ccs.settings
		input_translations = input_translations or ccs.translation_strings
		for _, setting in pairs(input_settings) do
			if not setting.id then goto continue end
			setting.path = mod_id .. "." .. path .. setting.id
			setting.type = setting.type or type(setting.value_default)
			setting.text_offset_x = setting.text_offset_x or 0
			setting.recursion = recursion + 1

			local child_path = path .. (not setting.not_path and (setting.id .. ".") or "")
			for _, v in pairs(setting) do
				if type(v) == "table" then
					local is_table_of_tables = true
					for _, item in pairs(v) do
						if type(item) ~= "table" then is_table_of_tables = false end
					end

					if is_table_of_tables then
						cache_settings(v, input_translations[setting.id], child_path, recursion + 1)
					end
				end
			end

			if dummy_gui then
				SettingUpdate(dummy_gui, setting, input_translations[setting.id])
			end

			::continue::
		end
	end

	local function cache_settings_data(input_data, input_translations, recursion, id)
		recursion = (recursion or 0) + 1

		input_data.text = input_translations[current_language] or input_translations.en or nil
		if id == "missing_translation" then
			input_data.text = string.format(input_data.text, GameTextGetTranslatedOrNot("$current_language"))
		end

		for key, value in pairs(input_data) do
			if type(value) == "table" and input_translations[key] then
				cache_settings_data(value, input_translations[key], recursion + 1, key)
			end
		end
	end

	local function apply_settings(setting)
		if setting.path then
			local current_value = ModSettingGet(setting.path)
			local next_value = ModSettingGetNextValue(setting.path)

			if current_value == nil and setting.value_default ~= nil then
				current_value = setting.value_default
			end

			if next_value == nil and current_value ~= nil then
				next_value = current_value
				ModSettingSetNextValue(setting.path, next_value, false)
			end

			if current_value ~= next_value and (setting.scope >= init_scope or not mods_are_loaded) then
				current_value = next_value
			end

			if current_value ~= nil then ModSettingSet(setting.path, current_value) end
		end

		for _, value in pairs(setting) do
			if type(value) == "table" then
				apply_settings(value)
			end
		end
	end

	if not cached then
		cache_settings_data(ccs.data, ccs.translation_strings.data) --cache first
		cache_settings()
	end

	for _,setting in ipairs(ccs.settings) do
		apply_settings(setting)
	end

	if not cached then --do this twice cuz fuck i need to do paths before `apply_settings` this but add extra lines AFTER, this shit is so ass
		cache_settings_data(ccs.data, ccs.translation_strings.data) --cache first
		cache_settings()
	end --resolve by splitting settings caching and translations caching into their own individual functions


	ModSettingSet(get_setting_id("_version"), mod_settings_version)
	if dummy_gui then GuiDestroy(dummy_gui) end
end


--RENDERING
local mouse_is_valid

local function reset_settings_to_default(group, target, default_value)
	target = target or "value_default"
	for _, setting in ipairs(group) do
		local target_value = setting[target]
		if target_value == nil and type(default_value) == type(setting.value_default) then
			target_value = default_value
		end
		if target_value ~= nil then
			SettingSetValue(setting, target_value) --else print(setting.path .. " DOES NOT HAVE A DEFAULT FOR " .. target)
		end

		if type(setting.options) == "table" then
			setting.current_option_int = setting[target .. "_int"]
			setting.current_option = setting.options[setting.current_option_int]
		end

		if setting.items then
			reset_settings_to_default(setting.items, target, default_value)
		end
		if setting.dependents then
			reset_settings_to_default(setting.dependents, target, default_value)
		end
	end
end

----Rendering:
local max_id = 0
local function create_id()
	max_id = max_id + 1
	return max_id
end

---Draws a tooltip at desired position
---@param gui gui
---@param data table pass table of desc data to allow prebaking values
---@param x number
---@param y number
---@param sprite string? custom 9piece sprite
local function DrawTooltip(gui, data, x, y, sprite)
	local text_size = {data.w, data.h}
	sprite = sprite or "data/ui_gfx/decorations/9piece0_gray.png"
	GuiLayoutBeginLayer(gui)
	GuiZSetForNextWidget(gui, -200)
	GuiImageNinePiece(gui, create_id(), x, y, text_size[1]+10, text_size[2]+2, 1, sprite)
	y = y + 1
	for i,line in ipairs(data.lines) do
		GuiZSetForNextWidget(gui, -210)
		GuiColorSetForNextWidget(gui, line.c.r, line.c.g, line.c.b, 1)
		GuiText(gui, x + 5 + line.x, y + line.y, line.text, 1, regular_font)
		--GuiText(gui, x + 5, y + (i-1)*13, line)
	end --GuiText doesnt work by itself ig, newlines put next on the same line for some reason? idk.
	GuiLayoutEndLayer(gui)
end

---Create boolean setting
---@param gui gui
---@param x_offset number indentation as a result of child settings
---@param setting table setting data
---@param c number[] colour data
local function BoolSetting(gui, x_offset, setting, c)
	c = c or {
		r = 1,
		g = 1,
		b = 1,
	}
	local is_disabled
	if setting.requires and not ModSettingGetNextValue(setting.requires.id) == setting.requires.value then
		is_disabled = true
	end

	local value = ModSettingGetNextValue(setting.path) and true

	GuiText(gui, x_offset, 0, "")
	local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)
	GuiImageNinePiece(gui, create_id(), x, y, 19+setting.w, setting.h, 0)
	local guiPrev = {GuiGetPreviousWidgetInfo(gui)}

	local clicked, rclicked, highlighted
	if guiPrev[3] and mouse_is_valid then
		highlighted = true
		if setting.hover_func then setting.hover_func() end
		if InputIsMouseButtonJustDown(1) then clicked = true end
		if InputIsMouseButtonJustDown(2) then rclicked = true end
		if (clicked or rclicked) and is_disabled then
			GamePlaySound("ui", "ui/button_denied", 0, 0)
			clicked = false
			rclicked = false
		end
		c = {
			r = 1,
			g = 1,
			b = .7,
		}
	end

	if is_disabled then --dim if disabled
		c = {
			r = c.r * .5,
			g = c.g * .5,
			b = c.b * .5,
		}
	end


	GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
	GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
	GuiText(gui, x_offset + 19, 0, setting.name, 1, regular_font)


	if highlighted and setting.desc_data then DrawTooltip(gui, setting.desc_data, x, y+12) end
	GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)

	local toggle_icon = ""
	if is_disabled then toggle_icon = "(X)"
	else toggle_icon = value == true and "(*)" or "(  )" end
	GuiText(gui, x_offset, 0, toggle_icon, 1, regular_font)

	if clicked then
		GamePlaySound("ui", "ui/button_click", 0, 0)
		SettingSetValue(setting, not value)
	end
	if rclicked then
		GamePlaySound("ui", "ui/button_click", 0, 0)
		if keyboard_state == 1 then
			SettingSetValue(setting, setting.value_recommended)
		elseif keyboard_state == 2 then
			SettingSetValue(setting, false)
		elseif keyboard_state == 3 then
			SettingSetValue(setting, true)
		else --if 0
			SettingSetValue(setting, setting.value_default)
		end
	end
end

local function draw_translation_credits(gui, x, y)
	GuiLayoutBeginLayer(gui)
	GuiZSetForNextWidget(gui, -200)
	GuiImageNinePiece(gui, create_id(), x, y, tlcr_data_ordered.size[1]+10, tlcr_data_ordered.size[2]+2, 1, "data/ui_gfx/decorations/9piece0_gray.png")
	for i,tl in ipairs(tlcr_data_ordered) do
		if tl.highlighted then
			GuiColorSetForNextWidget(gui, 236/255, 236/255, 67/255, 1)
		end

		local pos_x,pos_y = x + 5, y + 2 + (i-1)*ccs.desc_line_gap
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
		GuiZSetForNextWidget(gui, -210)
		GuiText(gui, pos_x, pos_y , tl.text, 1, regular_font)
		local c = tl.translator
		GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
		GuiZSetForNextWidget(gui, -210)
		GuiText(gui, pos_x + tl.translator.offset, pos_y, tl.translator[1], 1, regular_font)
	end --GuiText doesnt work by itself ig, newlines put next on the same line for some reason? idk.
	GuiLayoutEndLayer(gui)
end

function ModSettingsGui(gui, in_main_menu)
	keyboard_state = 0
	if InputIsKeyDown(225) or InputIsKeyDown(229) then
		keyboard_state = 1
	end
	if InputIsKeyDown(224) or InputIsKeyDown(228) then
		keyboard_state = keyboard_state + 2
	end

	GuiLayoutBeginLayer(gui)
	local x_orig,y_orig = (screen_w*.5) - 171.5, 49+.5
	GuiZSetForNextWidget(gui, 1000)
	GuiImageNinePiece(gui, create_id(), x_orig, y_orig, 340-1, 251-1, 0, "") --"data/temp/edge_c2_0.png", for debugging
	mouse_is_valid = ({GuiGetPreviousWidgetInfo(gui)})[3]
	--GuiZSetForNextWidget(gui, 1000)
	--GuiImageNinePiece(gui, create_id(), x_orig, y_orig, 1, 1, 1, "data/temp/edge_c2_1.png") --"data/temp/edge_c2_0.png", for debugging
	GuiLayoutEndLayer(gui)


	local function RenderModSettingsGui(gui, in_main_menu, _settings, offset, parent_is_disabled, recursion)
		recursion = recursion or 0
		offset = offset or 0
		_settings = _settings or ccs.settings

		for _, setting in ipairs(_settings) do

			local render_setting
			if type(setting.render_condition) == "function" then
				render_setting = setting.render_condition() --stupid fuckin bullshit, needing me to use functions, lua should just update conditions in real-time :(  (probably shouldnt)
			else
				render_setting = setting.render_condition ~= false
			end
			if render_setting then
				local setting_is_disabled = parent_is_disabled or (setting.requires and not ModSettingGetNextValue(setting.requires.id) == setting.requires.value)
				if setting.type == "group" then
					local c = setting.c and {
						r = setting.c.r,
						g = setting.c.g,
						b = setting.c.b,
					} or {
						r = .4,
						g = .4,
						b = .75,
					}

					local collapse_icon
					if setting.collapsed then
						collapse_icon = "data/ui_gfx/button_fold_open.png"
					else
						collapse_icon = "data/ui_gfx/button_fold_close.png"
					end
					if setting_is_disabled then
						c.r = c.r * .5
						c.g = c.g * .5
						c.b = c.b * .5
					end

					GuiText(gui, offset, 0, "")
					local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)

					--GuiOptionsAddForNextWidget(gui, GUI_OPTION.ForceFocusable)
					GuiImageNinePiece(gui, create_id(), x, y, setting.w+10, setting.h, 0)
					if ({GuiGetPreviousWidgetInfo(gui)})[3] and mouse_is_valid then --check if element was clicked
						c.r = math.min((c.r * 1.2)+.05, 1)
						c.g = math.min((c.g * 1.2)+.05, 1)
						c.b = math.min((c.b * 1.2)+.05, 1)
						if InputIsMouseButtonJustDown(1) then
							GamePlaySound("ui", "ui/button_click", 0, 0)
							setting.collapsed = not setting.collapsed
						end
					end

					GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiImage(gui, create_id(), offset, 0, collapse_icon, 1, 1, 1)


					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiText(gui, offset+10, 0, setting.name, 1, regular_font)
					if setting.description then
						GuiTooltip(gui, setting.description, "")
					end

					--i think recursion just works here
					if setting.collapsed ~= true then RenderModSettingsGui(gui, in_main_menu, setting.items, offset + ccs.offset_amount, setting_is_disabled, recursion) end
				elseif setting.type == "boolean" then
					BoolSetting(gui, offset, setting, {
						r = .7^recursion,
						g = .7^recursion,
						b = .7^recursion,
					})

				elseif setting.type == "note" then
					local c = setting.c and {
						r = setting.c.r,
						g = setting.c.g,
						b = setting.c.b,
					} or {
						r = .7,
						g = .7,
						b = .7,
					}

					GuiText(gui, offset, 0, "")
					local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)

					--GuiOptionsAddForNextWidget(gui, GUI_OPTION.ForceFocusable)
					GuiImageNinePiece(gui, create_id(), x, y, setting.w+(setting.icon_w or 0)+(setting.text_offset_x or 0), setting.h, 0)
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}

					if guiPrev[3] and mouse_is_valid and setting.desc_data then
						c.r = math.min((c.r * 1.2)+.05, 1)
						c.g = math.min((c.g * 1.2)+.05, 1)
						c.b = math.min((c.b * 1.2)+.05, 1)
						DrawTooltip(gui, setting.desc_data, x, y+12)
					end

					if setting.icon then
						GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
						GuiImage(gui, create_id(), (setting.icon_offset_x or 0) + offset, setting.icon_offset_y or 0, setting.icon, 1, 1, 1)
					end
					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiText(gui, (setting.icon_w or 0) + setting.text_offset_x + offset, 0, setting.name, 1, regular_font)
				elseif setting.type == "options" then
					GuiText(gui, offset, 0, "")
					local _,_,_,x, y = GuiGetPreviousWidgetInfo(gui)
					local text = setting.name .. ": "

					local w,h = GuiGetTextDimensions(gui, text, 1, 2, regular_font)
					GuiImageNinePiece(gui, create_id(), x, y, w, h, 0, "")
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}

					local c = setting.c or {
						r = .8,
						g = .8,
						b = .8,
					}

					local setting_hovered
					local clicked
					local rclicked
					if guiPrev[3] and mouse_is_valid then
						setting_hovered = true
						c.r = math.min((c.r * 1.2)+.05, 1)
						c.g = math.min((c.g * 1.2)+.05, 1)
						c.b = math.min((c.b * 1.2)+.05, 1)

						if setting.desc_data then DrawTooltip(gui, setting.desc_data, x, y+12) end
					end

					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiText(gui, offset, 0, text, 1, regular_font)

					local option_w,option_h = GuiGetTextDimensions(gui, ("[%s]"):format(setting.option_names[setting.current_option_int]), 1, 2, regular_font)
					GuiImageNinePiece(gui, create_id(), x + w, y, option_w, option_h, 0, "")
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}

					if mouse_is_valid and (setting_hovered or guiPrev[3]) then
						if setting.option_desc_data[setting.current_option_int] and not setting_hovered then
							DrawTooltip(gui, setting.option_desc_data[setting.current_option_int], x + w, y+12)
						end

						clicked = InputIsMouseButtonJustDown(1)
						rclicked = InputIsMouseButtonJustDown(2)


						if clicked then
							local option_change_amount = 1
							if keyboard_state == 1 then option_change_amount = -1 end

							setting.current_option_int = ((setting.current_option_int + option_change_amount - 1) % #setting.options) + 1 --add post-modulation to avoid 0-indexing
							setting.current_option = setting.options[setting.current_option_int] --add one cuz lua is 1-indexed
							SettingSetValue(setting, setting.current_option)
							GamePlaySound("ui", "ui/button_click", 0, 0)
						end

						if rclicked then
							if keyboard_state == 1 then
								setting.current_option_int = setting.value_recommended_int
							elseif keyboard_state == 2 then
								setting.current_option_int = setting.value_off_int
							elseif keyboard_state == 3 then
								setting.current_option_int = setting.value_on_int
							else
								setting.current_option_int = setting.value_default_int
							end

							setting.current_option = setting.options[setting.current_option_int]
							SettingSetValue(setting, setting.current_option)
							GamePlaySound("ui", "ui/button_click", 0, 0)
						end
					end

					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiText(gui, offset + w, 0, ("[%s]"):format(setting.option_names[setting.current_option_int]), 1, regular_font)

				elseif setting.type == "slider" then
					local default_values = {
						range = 100,
						display_multiplier = 100,
						display_offset = 0,
					}
					GuiText(gui, 0, 0, "")
					local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)
					GuiImageNinePiece(gui, create_id(), x, y, setting.w, setting.h, 0)
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}
					GuiText(gui, 0, 0, setting.name, 1, regular_font)
					GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiColorSetForNextWidget(gui, 0, 0, 0, .8)
					GuiText(gui, 0, 0, ('!'):rep(setting.slider_data.range + 9), 1, ui_font)
					GuiText(gui, 0, 0, '!"' .. ('#'):rep(setting.slider_data.range + 5) .. '"!', 1, ui_font)
					
					
					GuiText(gui, -1, 0, " $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 1, ui_font)
					GuiText(gui, 0, 0, "!\"#################################################\"!", 1, ui_font)
					for index, value in ipairs({
						" ",
						"!", --solid
						'"', --edge
						"#", --middle
						"%", --bar
					}) do
						GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
						GuiText(gui, 10, 0, value:rep(10), 1, ui_font)
						GuiText(gui, 0, 0, value .. ":")
					end
					GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiText(gui, 9, 0, " "..("$"):rep(10), 1, ui_font)
					GuiText(gui, -1, 0, " $:")

				elseif setting.type == "reset_button" then
					GuiText(gui, 0, 0, "")
					local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)
					GuiImageNinePiece(gui, create_id(), x, y, setting.w, setting.h, 0)
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}


					local c = setting.c or {
						r = 1,
						g = 1,
						b = 1,
					}
					if guiPrev[3] and mouse_is_valid then
						c = setting.highlight_c or {
							r = math.min((c.r * 1.2)+.05, 1),
							g = math.min((c.g * 1.2)+.05, 1),
							b = math.min((c.b * 1.2)+.05, 1),
						}
						if setting.desc_data then DrawTooltip(gui, setting.desc_data, x, y+12) end
						if InputIsMouseButtonJustUp(1) then
							if setting.click_func then
								setting.click_func()
							end
							GamePlaySound("ui", "ui/button_click", 0, 0)
							reset_settings_to_default(ccs.settings, setting.reset_target, setting.reset_target_default)
						end
					end

					--GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiText(gui, (setting.icon_w or 0) + setting.text_offset_x, 0, setting.name, 1, regular_font)

				elseif setting.type == "tl_credit" then
					GuiText(gui, 0, 0, "")
					local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)
					GuiImageNinePiece(gui, create_id(), x, y, setting.w, setting.h, 0)
					local guiPrev = {GuiGetPreviousWidgetInfo(gui)}

					local c = {
						r = 0.17,
						g = 0.5,
						b = 0.17,
					}
					if guiPrev[3] and mouse_is_valid then
						c.r = math.min((c.r * 1.2)+.05, 1)
						c.g = math.min((c.g * 1.2)+.05, 1)
						c.b = math.min((c.b * 1.2)+.05, 1)
						draw_translation_credits(gui, x, y+12)
					end

					--GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
					GuiColorSetForNextWidget(gui, c.r, c.g, c.b, 1)
					GuiText(gui, (setting.icon_w or 0) + setting.text_offset_x, 0, setting.name, 1, regular_font)

				elseif ccs.custom_setting_types[setting.type] then
					ccs.custom_setting_types[setting.type](gui, offset, setting)
				end

				if setting.dependents then
					RenderModSettingsGui(gui, in_main_menu, setting.dependents, offset + ccs.offset_amount, setting_is_disabled, recursion + 1)
				end
			end
		end
	end

	RenderModSettingsGui(gui, in_main_menu)
end


--this is just here to stop vsc from pestering me about undefined globals

MOD_SETTING_SCOPE_NEW_GAME = MOD_SETTING_SCOPE_NEW_GAME --`0` - setting change (that is the value that's visible when calling ModSettingGet()) is applied after a new run is started
MOD_SETTING_SCOPE_RUNTIME_RESTART = MOD_SETTING_SCOPE_RUNTIME_RESTART --`1` - setting change is applied on next game exe restart
MOD_SETTING_SCOPE_RUNTIME = MOD_SETTING_SCOPE_RUNTIME --`2` - setting change is applied immediately
MOD_SETTING_SCOPE_ONLY_SET_DEFAULT = MOD_SETTING_SCOPE_ONLY_SET_DEFAULT --`3` - this tells us that no changes should be applied. shouldn't be used in mod setting definition.
GUI_OPTION = GUI_OPTION
print("////////////// Commencing Hydroxide init //////////////")
local start_time = GameGetRealWorldTimeSinceStarted()
local total_time = 0


local settings = {
	--debug
	run_translation_debug = true,


	--branches
	CC = ModSettingGet("Hydroxide.CC_ENABLED"),
	AA = ModSettingGet("Hydroxide.AA_ENABLED"),
	MM = ModSettingGet("Hydroxide.MM_ENABLED"),
	--FF = ModSettingGet("Hydroxide.FF_ENABLED"), --this shit is not ready, i have like 2 reworks to get through before im ready for this.
	--Terror = ModSettingGet("Hydroxide.TERROR_ENABLED"),
	experimental_features = ModSettingGet("Hydroxide.EXPERIMENTAL_FEATURES"),

	--CC
	oregen = ModSettingGet("Hydroxide.CC_ORES"),
	polymorph_gui = ModSettingGet("Hydroxide.POLYMORPH_GUI"),
}

dofile_once("mods/Hydroxide/files/modify_vanilla.lua")
dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


local catastrophicMaterials = {
	creepy_liquid = true,
	monster_powder_test = true,
	totallyBogusMaterial = true,
	construction_paste = true,
} --Create Catastrophic Materials list


if settings.run_translation_debug then
	dofile("mods/Hydroxide/translations/debug_split.lua")
end

dofile("mods/Hydroxide/lib/translations.lua")
local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua")
nxml.error_handler = function() end


local function make_timed(fn, name)
	return function(...)
	  local s = GameGetRealWorldTimeSinceStarted() -- whatever this called
	  local res = {fn(...)}
	  total_time = total_time + GameGetRealWorldTimeSinceStarted() - s
	  print(name, "took", GameGetRealWorldTimeSinceStarted() - s .. ". Total: " .. total_time)
	  return unpack(res)
	end
  end





--   	[Chemical Curiosities]


local hooks = {
	player_spawned = {},
	new_eid = {},
	player_changed = {},
	player_destroyed = {},
	pre_update = {},
	post_update = {},
	edit_material = {},
}


function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	for _,func in ipairs(hooks.magic_numbers_and_seed_initialised) do
		func()
	end

	-- this code adds tags to preexisting materials, its good for compatibility
	local files = ModMaterialFilesGet()
	for _, file in ipairs(files) do --add modded materials
		for xml in nxml.edit_file(file) do
			for elem in xml:each_child() do
				for _,func in ipairs(hooks.edit_material) do
					if catastrophicMaterials[elem.attr.name] then
						elem.attr.tags = elem.attr.tags .. ",[catastrophic]"
						print("CC: Added tag [catastrophic] to " .. elem.attr.name)
					end

					func(elem)
				end
			end
		end
	end
end

local player
local player_poly_identity
local player_does_not_exist = true
function OnPlayerSpawned(p)
	player = p
	player_does_not_exist = false
	for _,func in ipairs(hooks.player_spawned) do
		func(GameHasFlagRun("cc_player_spawned"))
	end

	GameAddFlagRun("cc_player_spawned")
end

function OnPlayerDied(p)
	player_does_not_exist = true
	player = nil
	player_poly_identity = nil
	for _,func in ipairs(hooks.player_destroyed) do
		func()
	end
end

local prev_max_eid = -1
local max_eid = -1
local check_entities = function()
	local old_player = player
	local borked_polymorph_entity
	if not EntityGetIsAlive(player) then
		max_eid = prev_max_eid --rollback in case EntityGetIsAlive was outdated by 1 frame
		player = nil
	end

	local new_max = EntitiesGetMaxID()
	---@type entity_id
	for i = max_eid + 1, new_max do
		if not (player or player_does_not_exist) then
			if EntityHasTag(i, "player_unit") then
				player = i
				player_poly_identity = nil
			else
				if EntityHasTag(i, "polymorphed_player") then
					player = i
					player_poly_identity = {
						path = EntityGetFilename(i),
						name = EntityGetName(i)
					}
				else
					for _,comp in ipairs(EntityGetComponent(i, "GameStatsComponent") or {}) do
						if ComponentGetTypeName(comp) ~= "GameStatsComponent" then
							borked_polymorph_entity = borked_polymorph_entity or i
							goto continue
						elseif ComponentGetValue2(comp, "is_player") then
							player = i
							player_poly_identity = {
								path = EntityGetFilename(i),
								name = EntityGetName(i)
							}
							goto continue
						end
					end
				end
			end
			::continue::
		end
		for _,func in ipairs(hooks.new_eid) do
			local varcomp_tree = {}
			for _,varcomp in ipairs(EntityGetComponent(i, "VariableStorageComponent") or {}) do
				local name = ComponentGetValue2(varcomp, "name")
				varcomp_tree[name] = varcomp_tree[name] or {}
				varcomp_tree[name][#varcomp_tree[name]+1] = varcomp
			end
			func(i, varcomp_tree)
		end
	end
	prev_max_eid = max_eid --we store prev max eid in case a rollback is necessary due to frame delay nonsense
	max_eid = new_max

	if old_player ~= player then
		if player == nil and borked_polymorph_entity then
			player = borked_polymorph_entity
			player_poly_identity = {
				path = EntityGetFilename(player),
				name = EntityGetName(player)
			}
		end
		if player ~= nil then
			for _,func in ipairs(hooks.player_changed) do
				func()
			end
		end
	end
end

local frame = 0
function OnWorldPreUpdate()
	frame = GameGetFrameNum()
	check_entities()

	for _,func in ipairs(hooks.pre_update) do
		func(frame)
	end
end


-----//// TESTING!!!





-----////


--		[GLOBAL]

local target = "mods/Hydroxide/translations/standard.csv"
if GameTextGetTranslatedOrNot("$current_language") == "Türkçe" then
	target = "mods/Hydroxide/translations/turkish.csv"
end
register_localizations(target)


ModLuaFileAppend("data/scripts/items/potion_starting.lua", "mods/Hydroxide/files/lib/potion_start/potion_start.lua")
ModLuaFileAppend("data/scripts/items/potion.lua", "mods/Hydroxide/files/potion_append.lua")
ModLuaFileAppend("data/scripts/items/powder_stash.lua", "mods/Hydroxide/files/chemical_curiosities/append/powders.lua") --powder pouches
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/Hydroxide/files/status_effects.lua")
ModLuaFileAppend("data/scripts/magic/fungal_shift.lua", "mods/Hydroxide/files/fungal_shift.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/Hydroxide/files/perks_append.lua")
ModMagicNumbersFileAdd("mods/Hydroxide/files/magic_numbers.xml")


--More Musical Magic implementation, coded by Y🍵
if ModTextFileGetContent("data/moremusicalmagic/musicmagic.lua") == nil then
	local data = ModTextFileGetContent("data/moremusicalmagic/compatibility/musicmagic.lua")
	ModTextFileSetContent("data/moremusicalmagic/musicmagic.lua", data)
end
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_default.lua")
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_chemical.lua")


--		[Chemical Curiosities]

if settings.CC then

	---- 	[Materials]

	ModMaterialsFileAdd("mods/Hydroxide/files/chemical_curiosities/append/materials.xml") --materials
	ModMaterialsFileAdd("mods/Hydroxide/files/chemical_curiosities/append/reactions.xml") --reactions

	dofile("mods/Hydroxide/files/chemical_curiosities/materials/methane/methane_shader.lua") -- init methane shader
	dofile("mods/Hydroxide/files/chemical_curiosities/materials/warp/warp_shader.lua") -- init warp shader
	dofile("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_init.lua") -- init electrolysis system



	--ModLuaFileAppend("data/scripts/items/potion.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion.lua") -- potions with new materials
	--ModLuaFileAppend("data/scripts/items/potion_aggressive.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion_aggressive.lua") --for alchemist enemy
	--ModLuaFileAppend("data/scripts/items/potion_starting.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion_starting.lua") --starting potions --NOTE: verify these potion appends later


	----	[Spells]
	ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/Hydroxide/files/chemical_curiosities/append/gun_extra_modifiers.lua") --something to do with metastasizium's trail effect



	---- Structures/Pixel Scenes

	ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_coalmine.lua") --new structures in the mines
	ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_coalmine_alt.lua") --new structures in the collapsed mines
	ModLuaFileAppend("data/scripts/biomes/excavationsite.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_excavationsite.lua") --new structures in the coal pits
	ModLuaFileAppend("data/scripts/biomes/liquidcave.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_liquidcave.lua") --new structures in the alchemy lab
	ModLuaFileAppend("data/scripts/biomes/snowcastle.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_snowcastle.lua") --new structures in hiisi base
	ModLuaFileAppend("data/scripts/biomes/snowcave.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_snowcave.lua") --new structures in hiisi base
	ModLuaFileAppend("data/scripts/biomes/vault.lua", "mods/Hydroxide/files/chemical_curiosities/biomes/append_vault.lua") --new structures in the vault

	---- Spells

	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/chemical_curiosities/append/gun_actions.lua")
	ModLuaFileAppend("mods/Hydroxide/files/chemical_curiosities/spells/local_shift/local_shift.lua", "mods/Hydroxide/files/chemical_curiosities/spells/local_shift/append.lua")


	---- Items

	ModLuaFileAppend("data/scripts/item_spawnlists.lua", "mods/Hydroxide/files/items_append.lua") --adds items to pedestals


	---- Enemies

	FileSetBloodMaterial("data/entities/animals/wizard_dark.xml", "cc_veilium")
	FileSetBloodMaterial("data/entities/animals/wizard_twitchy.xml", "cc_ectospasm")
	--todo: add Master of Monochrome

	if settings.experimental_features then
		hooks.new_eid[#hooks.new_eid+1] = function(entity_id, varcomp_tree)
			if not GameHasFlagRun("cc_chaotic_transfusion") then return end
			local x,y = EntityGetTransform(entity_id)
			local material_options = dofile_once("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/transfusion_pool.lua")

			if not EntityHasTag(entity_id, "enemy") then return end
			local dmc = EntityGetFirstComponent(entity_id, "DamageModelComponent")
			if not dmc then return end
			SetRandomSeed(x+434,y-1415)
			local option = RandomFromTable(material_options)
			ComponentSetValue2(dmc, "blood_material", option.material)
			ComponentSetValue2(dmc, "blood_spray_material", option.material)
			ComponentSetValue2(dmc, "blood_spray_create_some_cosmetic", false)
		end
	end

	if settings.polymorph_gui then
		hooks.player_changed[#hooks.player_changed+1] = function()
			if not player_poly_identity then return end

			if not EntityGetFirstComponentIncludingDisabled(player, "InventoryGuiComponent") then
				EntityAddComponent2(player, "InventoryGuiComponent")
				EntityAddComponent2(player, "LuaComponent", {
					script_source_file = "mods/Hydroxide/files/chemical_curiosities/polymorph_gui/polymorphed_player.lua"
				})
			end

			local polymorphs = {
				POLYMORPH = {
					icon = "mods/Hydroxide/files/chemical_curiosities/polymorph_gui/polymorphed.png",
					name = "$status_cc_polymorph",
					desc = "$status_desc_cc_polymorph",
				},
				POLYMORPH_UNSTABLE = {
					icon = "mods/Hydroxide/files/chemical_curiosities/polymorph_gui/chaotic_polymorphed.png",
					name = "$status_cc_unstable_polymorph",
					desc = "$status_desc_cc_unstable_polymorph",
				},
				POLYMORPH_RANDOM = {
					icon = "mods/Hydroxide/files/chemical_curiosities/polymorph_gui/chaotic_polymorphed.png",
					name = "$status_cc_chaotic_polymorph",
					desc = "$status_desc_cc_chaotic_polymorph",
				},
			}

			if MatchDateLocal({month = 3, day = 31}) then
				polymorphs.POLYMORPH.desc = "$status_desc_cc_polymorph_trans_day"
			end

			local rare_polymorph = {
				icon = "mods/Hydroxide/files/chemical_curiosities/polymorph_gui/rare_chaotic_polymorphed.png",
				name = "$status_cc_rare_polymorph",
				desc = "$status_desc_cc_rare_polymorph",
			}

			for _,rare_poly in pairs(PolymorphTableGet(true)) do
				if player_poly_identity.path == rare_poly then
					local is_rare = true
					for _,common_poly in pairs(PolymorphTableGet(false)) do
						if player_poly_identity.path == common_poly then
							is_rare = false
							break
						end
					end
					if is_rare then polymorphs.POLYMORPH_RANDOM = rare_polymorph end
					break
				end
			end

			for game_effect,data in pairs(polymorphs) do
				local ge_comp = GameGetGameEffect(player, game_effect)
				if ge_comp ~= 0 then
					local ge_entity = ComponentGetEntity(ge_comp)
					local is_perk = false
					if ComponentGetValue2(ge_comp, "frames") < 0 then is_perk = true end
					EntityAddComponent2(ge_entity, "UIIconComponent", {
						icon_sprite_file = data.icon,
						name = data.name,
						description = data.desc,
						is_perk = is_perk
					})
				end
			end
		end
	end

	

	if settings.oregen then
		hooks.magic_numbers_and_seed_initialised[#hooks.magic_numbers_and_seed_initialised+1] = function()
			if GameHasFlagRun("Squirrelly_Ore_generated") then return end
			dofile_once("mods/Hydroxide/files/chemical_curiosities/ore_gen/inject_ores.lua")
			GameAddFlagRun("Squirrelly_Ore_generated")
		end
	end

	local rock_materials = {
		--vanilla:
		rock_static_glow = true,
		rock_static_purple = true,
		rock_static_noedge = true,
		rock_static_trip_secret = true,
		rock_static_trip_secret2 = true,
		rock_static_intro = true,
		rock_static_intro_breakable = true,
		rock_static_grey = true,
		rock_static_wet = true,
		snowrock_static = true,
		rock_box2d_nohit_hard = true,
		rock_box2d_nohit = true,
		rock_box2d = true,
		lavarock_static = true,
	}
	hooks.edit_material[#hooks.edit_material+1] = function(elem)
		local rock_tags = "[static],[corrodible],[meltable_to_lava],[alchemy],[solid],[earth]" --default vanilla rock tags

		if elem.attr.name == "rock_static" then
			rock_tags = elem.attr.tags
			elem.attr.tags = elem.attr.tags .. ",[moss_devour]"
		else
			if settings.CC and rock_materials[elem.attr.name] and not (elem.attr.tags or ""):find("[moss_devour]") then
				elem.attr.tags = (elem.attr.tags or "") .. ",[moss_devour]"
			elseif elem.attr.name == "coal_static" then --do this cuz coal_static inherits tags from rock_static, and i dont want coal_static to have moss_devour
				elem.attr.tags = rock_tags
			end
		end
	end

	hooks.player_spawned[#hooks.player_spawned+1] = function(first_time)
		if not first_time then return end
		EntitySetDamageFromMaterial(player, "cc_hydroxide", 0.005)
		EntityLoad("mods/Hydroxide/files/chemical_curiosities/biomes/music_shrine/music_shrine.xml", 6200, 5500)  --load the musical shrine
		EntityLoad("mods/Hydroxide/files/chemical_curiosities/biomes/other/signature.xml", -1950, 250)  --load my cute stupid lil signature :)
		EntityLoad("mods/Hydroxide/files/chemical_curiosities/biomes/other/userk.xml", 11605, 20501) --me too!
	end
end






--		[Arcane Alchemy]

if settings.AA then
	ModMaterialsFileAdd("mods/Hydroxide/files/arcane_alchemy/append/materials.xml") --materials
	ModMaterialsFileAdd("mods/Hydroxide/files/arcane_alchemy/append/reactions.xml") --reactions


	--		[Bloomium]

	if ModSettingGet("Hydroxide.AA_BLOOMIUM") == true then ModMaterialsFileAdd("mods/Hydroxide/files/arcane_alchemy/materials/bloomium/materials.xml")  end


	--		[Spells]

	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/arcane_alchemy/append/gun_actions.lua")


	--		[Items]

	if settings.CC then ModLuaFileAppend("mods/Hydroxide/files/arcane_alchemy/items/vials/populate_vial.lua", "mods/Hydroxide/files/chemical_curiosities/append/vial_append.lua") end
	if settings.MM then ModLuaFileAppend("mods/Hydroxide/files/arcane_alchemy/items/vials/populate_vial.lua", "mods/Hydroxide/files/mystical_mixtures/scripts/vial_append.lua") end


	hooks.player_spawned[#hooks.player_spawned+1] = function(first_time)
		if not ModIsEnabled("arcane_alchemy") then return end
		GamePrint("(CC) Arcane Alchemy (Mod) and Arcane Alchemy (Chemical Curiosities) are both enabled, this is unadvised!")
		GamePrint("(CC) Chemical Curiosities already contains a more updated/maintained version of Arcane Alchemy")
		GamePrint("(CC) If you would like to use the legacy Arcane Alchemy mod, it is reccomended you disable Arcane Alchemy in Chemical Curiosities mod settings")
		print("(CC) Arcane Alchemy (Mod) and Arcane Alchemy (Chemical Curiosities) are both enabled, this is unadvised!")
		print("(CC) Chemical Curiosities already contains a more updated/maintained version of Arcane Alchemy")
		print("(CC) If you would like to use the legacy Arcane Alchemy mod, it is reccomended you disable Arcane Alchemy in Chemical Curiosities mod settings")
	end

end



-- 		[Mystical Mixtures]

if settings.MM then
	dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/generate_content.lua")
	ModRegisterAudioEventMappings("mods/Hydroxide/files/mystical_mixtures/misc/GUIDs.txt")
	ModMaterialsFileAdd("mods/Hydroxide/files/mystical_mixtures/materials.xml")

	ModLuaFileAppend("data/scripts/biomes/mountain/mountain_right.lua", "mods/Hydroxide/files/mystical_mixtures/scripts/mountain_scene.lua") --Spawn Alchemy House
end



--		[Fluent Fluids]

if settings.FF == true then
	--ModMaterialsFileAdd("mods/Hydroxide/files/fluent_fluids/materials.lua")
end




if settings.Terror then
	ModMaterialsFileAdd("mods/Hydroxide/files/terror/materials.xml")
end





--  	[Compelling Compatibility]	   --


--  [Arcane Alchemy] x [Chemical Curiosities]

if settings.CC and settings.AA then
	ModMaterialsFileAdd("mods/Hydroxide/files/compelling_compatibility/internal/CC_AA_reactions.xml")

	if ModSettingGet("Hydroxide.CC_AA_SUPERNOVA") ~= true then
		print("DISABLING SUPERNOVA REACTION, CC_AA STATE == " .. tostring(settings.CC and settings.AA) .. ", CC_AA_SUPERNOVA == " .. tostring(ModSettingGet("Hydroxide.CC_AA_SUPERNOVA")))
	else
		ModMaterialsFileAdd("mods/Hydroxide/files/compelling_compatibility/internal/supernova/reaction_supernova.xml")

		print("ENABLING SUPERNOVA REACTION, CC_AA STATE == " .. tostring(settings.CC and settings.AA) .. ", CC_AA_SUPERNOVA == " .. tostring(ModSettingGet("Hydroxide.CC_AA_SUPERNOVA")))
	end
end



--  Conjurer

if ModIsEnabled("raksa") then --DUE TO THE EXISTENCE OF CONJURER-REBORN, CONJURER SUPPORT WILL NO LONGER BE SUPPORTED NOR EXTENDED, EXISTING SUPPORT WILL REMAIN FOR NOW
	-- Materials Append
	  ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/material_categories.lua",
		"mods/Hydroxide/files/compelling_compatibility/conjurer/materials_aa.lua"
	)

	ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/material_categories.lua",
		"mods/Hydroxide/files/compelling_compatibility/conjurer/materials_cc.lua"
	)

	  ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/material_categories.lua",
		"mods/Hydroxide/files/compelling_compatibility/conjurer/materials_mm.lua"
	)


	-- Entities Append
	ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/entity_categories.lua",
		"mods/Hydroxide/files/compelling_compatibility/conjurer/entities.lua"
	)
end --adds compatibility with Conjurer


if ModIsEnabled("conjurer_reborn") then
	ModLuaFileAppend("mods/conjurer_reborn/files/wandhelper/ent_list_pre.lua", "mods/Hydroxide/files/compelling_compatibility/conjurer_reborn/entities.lua")
end



--	Copi's Things

if ModIsEnabled("copis_things") then
	ModLuaFileAppend("mods/copis_things/files/scripts/projectiles/material_random.lua", "mods/Hydroxide/files/compelling_compatibility/copis_things/random_material_append.lua")
end --copi's chemical curiosity compatibility combo


if ModIsEnabled("anvil_of_destiny") and settings.AA and false then --[[implement this properly when we can add custom materials to anvil]]

	--ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/hydroxide/files/compelling_compatibility/anvil_of_destiny/potionbonus_append.lua")
	ModMaterialsFileAdd("mods/Hydroxide/files/compelling_compatibility/anvil_of_destiny/materials.xml")

	local anvil_converter = "mods/anvil_of_destiny/files/entities/anvil/converter.xml"
	local xml = ModDoesFileExist(anvil_converter) and nxml.parse(ModTextFileGetContent(anvil_converter))
	if xml then
		for elem in xml:each_child() do
			elem.attr.to_material = "aa_divine_magma"
		end
		ModTextFileSetContent(anvil_converter, tostring(xml))
	else
		print("AoD Anvil Converter not found at expected location: \"" .. anvil_converter .. "\". Please contact/inform @UserK")
	end
end

--	Glimmers Expanded

if ModIsEnabled("GlimmersExpanded") then
	ModLuaFileAppend("mods/GlimmersExpanded/files/lib/glimmer_data.lua", "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/glimmers.lua")
end


--  Apotheosis
if ModIsEnabled("Apotheosis") then
	if settings.AA then
		for _, filepath in ipairs({"mods/Apotheosis/files/scripts/status_effects/hex_oil_start.lua", "mods/Apotheosis/files/scripts/status_effects/hex_oil_end.lua"}) do
			ModTextFileSetContent(filepath, ModTextFileGetContent(filepath)
				:gsub("\"oil\"", "\"oil\", \"aa_oil_splitting\", \"aa_light_oil\", \"aa_heavy_oil\""))
		end
	end
end


--	Twitch Comments Live

if ModIsEnabled("twitchcommentslive") then
	ModLuaFileAppend("mods/twitchcommentslive/files/scripts/material_table.lua",
		"mods/Hydroxide/files/compelling_compatibility/twitchcommentslive.lua")
end




OnMagicNumbersAndWorldSeedInitialized = make_timed(OnMagicNumbersAndWorldSeedInitialized, "Chemical Curiosities OnMagicNumbersAndWorldSeedInitialized")
total_time = total_time + GameGetRealWorldTimeSinceStarted() - start_time

print("Chemical Curiosities main init took " .. GameGetRealWorldTimeSinceStarted() - start_time .. " with the following branches: CC_" .. tostring(CC) .. ", AA_"  .. tostring(AA) .. ", MM_"  .. tostring(MM) .. ", FF_"  .. tostring(FF) .. ", Terror_" .. tostring(Terror))

print("////////////// Hydroxide mod init done! //////////////") -- why so many slashes, pleaseeee
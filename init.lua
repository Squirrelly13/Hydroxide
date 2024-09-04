-- all functions below are optional and can be left out

local catastrophicMaterials = {creepy_liquid = true, monster_powder_test = true, totallyBogusMaterial = true} --Create Catastrophic Materials list



--[[

function OnModPreInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--








print("////////////// Commencing Hydroxide init //////////////")
local start_time = GameGetRealWorldTimeSinceStarted()
local total_time = 0



dofile("mods/Hydroxide/lib/translations.lua")
local nxml = dofile_once("mods/Hydroxide/files/lib/luanxml/nxml.lua")


local function make_timed(fn, name)
	return function(...)
	  local s = GameGetRealWorldTimeSinceStarted() -- whatever this called
	  local res = {fn(...)}
	  total_time = total_time + GameGetRealWorldTimeSinceStarted() - s
	  print(name, "took", GameGetRealWorldTimeSinceStarted() - s .. ". Total: " .. total_time)
	  return unpack(res)
	end
  end



dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/generate_content.lua")
ModRegisterAudioEventMappings("mods/Hydroxide/files/mystical_mixtures/misc/GUIDs.txt")


--   	[Chemical Curiosities]


-----//// TESTING!!!

--nothing to test lmao

-----////



--  Materials

ModLuaFileAppend("data/scripts/items/potion.lua", "mods/Hydroxide/files/Overwhelming Overrides/potion_random.lua") --override random potion selection



if ModSettingGet("Hydroxide.CC_MATERIALS") == true then
	ModMaterialsFileAdd( "mods/Hydroxide/files/chemical_curiosities/append/materials.xml" ) --materials
	ModMaterialsFileAdd( "mods/Hydroxide/files/chemical_curiosities/append/reactions.xml" ) --reactions

	if(ModSettingGet("Hydroxide.CC_METHANE_GENERATION"))then
		ModMaterialsFileAdd( "mods/Hydroxide/files/chemical_curiosities/append/methane_reactions.xml" ) --methane generation
	end

	-- init methane shader
	dofile("mods/Hydroxide/files/chemical_curiosities/materials/methane/methane_shader.lua")

	-- init warp shader
	dofile("mods/Hydroxide/files/chemical_curiosities/materials/warp/warp_shader.lua")

	-- init electrolysis system
	dofile("mods/Hydroxide/files/chemical_curiosities/electrolysis/electrolysis_init.lua")
	
	ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Hydroxide/files/chemical_curiosities/append/status_effects.lua" ) --effects
	ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Hydroxide/files/chemical_curiosities/append/gun_extra_modifiers.lua" ) --something to do with metastasizium's trail effect
	
	ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/Hydroxide/files/chemical_curiosities/append/fungal_shift.lua" ) --FUngal shifts

	ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion.lua" ) -- potions with new materials
	ModLuaFileAppend( "data/scripts/items/powder_stash.lua", "mods/Hydroxide/files/chemical_curiosities/append/powders.lua" ) -- powder bags spawn with new materials
	ModLuaFileAppend( "data/scripts/items/potion_aggressive.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion_aggressive.lua" ) --for alchemist enemy
	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/Hydroxide/files/chemical_curiosities/append/potion_starting.lua") --starting potions

end


ModLuaFileAppend("data/scripts/biomes/mountain/mountain_right.lua", "mods/Hydroxide/files/mystical_mixtures/scripts/mountain_scene.lua")

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	if ModSettingGet("Hydroxide.CC_MATERIALS") == true then
		EntitySetDamageFromMaterial( player_entity, "cc_hydroxide", 0.005 )

	end
	if ModSettingGet("Hydroxide.CC_STRUCTURES") == true then

		if GameHasFlagRun("squirrellys_music_altar_is_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
			EntityLoad("mods/Hydroxide/files/chemical_curiosities/pixel_scenes/music_shrine/music_shrine.xml", 6200, 5500)  --load the musical shrine
			GameAddFlagRun("squirrellys_music_altar_is_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	
		end
	end

	EntityLoad("mods/Hydroxide/files/chemical_curiosities/pixel_scenes/other/signature.xml", -1950, 250)  --load my cute stupid lil signature :)

	-- debugging stuffs from eba
	--local player_x, player_y = EntityGetTransform( player_entity )
	--EntityLoad("mods/Hydroxide/files/mystical_mixtures/journal/journal_entity.xml", player_x + 20, player_y - 10)
	-- debugging stuff end
	print("CC init took " .. total_time .. "seconds")

end
--  Items

if ModSettingGet("Hydroxide.CC_ITEMS") == true then
	ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/Hydroxide/files/chemical_curiosities/append/items.lua" ) --adds items to pedestals
end

if ModSettingGet("Hydroxide.AA_ITEMS") then
	print("Adding arcane alchemy items!")
	ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/Hydroxide/files/arcane_alchemy/append/item_spawnlists.lua" ) --adds items to pedestals
	if(ModSettingGet("Hydroxide.MM_MATERIALS"))then
		ModLuaFileAppend("mods/Hydroxide/files/arcane_alchemy/items/vials/populate_vial.lua", "mods/Hydroxide/files/mystical_mixtures/scripts/vial_append.lua")
	end
	if(ModSettingGet("Hydroxide.CC_MATERIALS"))then
		ModLuaFileAppend("mods/Hydroxide/files/arcane_alchemy/items/vials/populate_vial.lua", "mods/Hydroxide/files/chemical_curiosities/append/vial_append.lua")
	end
end

if ModSettingGet("Hydroxide.MM_ITEMS") then
	print("Adding mystical mixtures items!")
	ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/Hydroxide/files/mystical_mixtures/scripts/items.lua" ) --adds items to pedestals

end

--  Structures/Pixel Scenes

if ModSettingGet("Hydroxide.CC_STRUCTURES") == true then
	ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_coalmine.lua" ) --new structures in the mines
	ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_coalmine_alt.lua" ) --new structures in the collapsed mines
	ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_excavationsite.lua" ) --new structures in the coal pits
	ModLuaFileAppend( "data/scripts/biomes/liquidcave.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_liquidcave.lua" ) --new structures in the alchemy lab
	ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_snowcastle.lua" ) --new structures in hiisi base
	ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_snowcave.lua" ) --new structures in hiisi base
	ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Hydroxide/files/chemical_curiosities/pixel_scenes/append_vault.lua" ) --new structures in the vault 

end

--	Spells

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/chemical_curiosities/append/gun_actions.lua" )





--  	[Arcane Alchemy]


--  Materials

if ModSettingGet("Hydroxide.AA_MATERIALS") == true then
	ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/append/materials.xml" ) --materials
	ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/append/reactions.xml" ) --reactions

	ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Hydroxide/files/arcane_alchemy/append/status_effects.lua" ) --effects

	ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/Hydroxide/files/arcane_alchemy/append/fungal_shift.lua" ) --fungal
end

--	Spells

if ModSettingGet("Hydroxide.AA_SPELLS") == true then
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/arcane_alchemy/append/gun_actions.lua" )
end



--- bloomium
--ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/Bloomium/bloom_materials.xml" ) 
--ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/Bloomium/bloom_reactions.xml" ) 

if ModSettingGet("Hydroxide.AA_BLOOMIUM") == true then
	
	ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/bloomium/materials.xml" ) 
	

	-- Bloomium stuff from userk, sorry I made it obsolete ;-;
	-- noooo bloomium ignore-infect tags my beloved :devastated: (might reuse these for a bloomium revamp standalone or smth) -UserK

	--ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/BLOOM_OLD.xml")
	--[[
	ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/BLOOMIUM/bloom_materials.xml" ) 
	ModMaterialsFileAdd( "mods/Hydroxide/files/arcane_alchemy/materials/BLOOMIUM/bloom_reactions.xml" ) 

		-- this code adds tags to preexisting materials, its good for compatibility--


	local bloomableMaterials = {"rock_static","rock_hard","rock_static_fungal","rock_hard_border","rock_vault","coal_static","rock_static_grey","rock_static_wet","lavarock_static","templebrickdark_static","templebrick_moss_static","the_end","steel_static","steelmoss_static","steel_rusted_no_holes","steel_grey_static","steelpipe_static","steel_static_strong","rock_static_glow","snow_static","rock_static_intro_breakable","waterrock","snowrock_static","concrete_static","wood_static","cheese_static","wood_static_wet","root_growth","corruption_static","mud","blood_fading_slow","blood_fungi","blood_worm","porridge","creepy_liquid","cement","concrete_sand","sand_surface","sand_petrify","bone","soil","soil_lush","soil_lush_dark","soil_dead","soil_dark","sandstone","sandstone_surface","fungisoil","vomit","endslime","endslime_blood","explosion_dirt","vine","root","snow","snow_sticky","rotten_meat","meat_slime_sand","meat_slime_green","meat_slime_orange","rotten_meat_radioactive","meat_worm","meat_helples","meat_trippy","meat_cursed","meat_cursed_dry","meat_slime_cursed","meat_teleport","meat_fast","meat_polymorph","meat_polymorph_protection","meat_confusion","sand_herb","silver","grass","grass_dry","fungi","grass_dark","fungi_creeping","spore","moss","moss_rust","plant_materialplant_material_red","ceiling_plant_material","mushroom_seed","mushroom","plant_seed","mushroom_giant_red","mushroom_giant_blue","glowshroom","bush_seed","wood_player","wood_player_b2","wood_prop_durable","nest_box2d","nest_firebug_box2d","cocoon_box2d","rock_loose","brick","concrete_collapsed","meteorite","steel","steel_rust","metal_rust_rust","metal_rust_barrel_rust","aluminium","aluminium_robot","metal_prop","metal_prop_low_restitution","metal_prop_loose","metal","metal_hard","templebrick_box2d_edgetiles","rock_box2d_hard","rock_box2d","metal_wire_nohit","metal_rust","metal_rust_barrel","meat","meat_fruit","meat_pumpkin","meat_warm","meat_hot","meat_done","meat_burned","meat_slime"}

	--local ignoreBloomableMaterials = {"water_static","endslime_static","slime_static","templerock_static","templebrick_static","templebrick_static_broken","templebrick_static_soft","templebrick_noedge_static","templerock_soft","templebrick_thick_static","templebrick_thick_static_noedge","templeslab_static","templeslab_crumbling_static","templebrick_golden_static","glowstone","glowstone_altar","glowstone_altar_hdr","glowstone_potion","snow_static","ice_static","ice_blood_static","ice_slime_static","ice_acid_static","gold_static","gold_static_dark","smoke","smoke_magic","smoke_explosion","steam","acid_gas","acid_gas_static","smoke_static","cloud","cloud_lighter","fungal_gas","poo_gas","magic_gas_hp_regeneration","rainbow_gas","water","water_fading","water_salt","water_temp","water_ice","water_swamp","oil","liquid_fire","liquid_fire_weak","alcohol","sima","alcohol_gas","midas_precursor","midas","magic_liquid","material_confusion","material_rainbow","magic_liquid_movement_faster","magic_liquid_faster_levitation","magic_liquid_faster_levitation_and_movement","magic_liquid_worm_attractor","magic_liquid_teleportation","magic_liquid_hp_regeneration","magic_liquid_hp_regeneration_unstable","magic_liquid_random_polymorph","magic_liquid_unstable_polymorph","magic_liquid_berserk","magic_liquid_charm","magic_liquid_invisibility","swamp","mud","blood","blood_fading","blood_fading_slow","blood_fungi","blood_worm","porridge","gold_molten","steel_static_molten","steelmoss_slanted_molten","steelmoss_static_molten","steelsmoke_static_molten","metal_sand_molten","metal_molten","metal_rust_molten","metal_nohit_molten","aluminium_molten","aluminium_robot_molten","metal_prop_molten","steel_rust_molten","aluminium_oxide_molten","wax_molten","silver_molten","copper_molten","brass_molten","glass_molten","glass_broken_molten","steel_molten","creepy_liquid","sand_blue","sand_surface","bone","soil_lush","honey","glue","slime","slush","slime_green","slime_yellow","pea_soup","vomit","endslime","endslime_blood","rotten_meat","meat_slime_sand","meat_slime_green","meat_slime_orange","rotten_meat_radioactive","meat_worm","meat_helpless","meat_trippy","meat_cursed","meat_cursed_dry","meat_slime_cursed","meat_teleport","meat_fast","meat_polymorph","meat_polymorph_protection","meat_confusion","ice","sand_herb","wax","gold","silver","steel_sand","metal_sand","copper","brass","coal","salt","sodium","gunpowder","gunpowder_explosive","plastic_red","plastic_red_molten","plastic_molten","plastic_prop_molten","grass","grass_dry","fungi","fungi_green","grass_dark","fungi_creeping","spore","moss","gunpowder_tnt","gunpowder_unstable","gunpowder_unstable_big","moss_rust","plant_material","plant_material_red","ceiling_plant_material","mushroom_seed","mushroom","plant_seed","mushroom_giant_red","mushroom_giant_blue","glowshroom","bush_seed","wood_player","wood_player_b2","wood_prop_durable","nest_box2d","nest_firebug_box2d","cocoon_box2d","rock_loose","ice_ceiling","brick","concrete_collapsed","meteorite","plastic","plastic_prop","aluminium","aluminium_robot","metal_prop","metal_prop_low_restitution","metal_prop_loose","metal","metal_hard","templebrick_box2d_edgetiles","rock_box2d_hard","rock_box2d","item_box2d_glass","metal_rust","metal_rust_barrel","meat","meat_fruit","meat_pumpkin","meat_warm","meat_hot","meat_done","meat_burned","meat_slime","glass","glass_broken","blood_thick"}

	local poisonBloomMaterials = {"wizardstone","templebrick_diamond_static","poison_gas","juhannussima","material_darkness","poison","cursed_liquid","diamond","urine"}

	for elem in xml:each_child() do

		print(elem)
		if elem.attr.name == "rock_static_glow" or elem.attr.name == "rock_static_purple" or elem.attr.name == "rock_static_noedge" or elem.attr.name == "rock_static_trip_secret" or elem.attr.name == "rock_static_trip_secret2" or elem.attr.name == "rock_static_intro" or elem.attr.name == "rock_static_intro_breakable" then
		

			elem.attr.tags = elem.attr.tags .. ",[bloomable]"	
				


					elseif elem.attr.name == "rotten_meat" or elem.attr.name == "meat" or elem.attr.name == "meat_slime_sand" or elem.attr.name == "meat_slime" or elem.attr.name == "rotten_meat_radioactive" or elem.attr.name == "meat_worm" or elem.attr.name == "meat_helpless" or elem.attr.name == "meat_trippy" or elem.attr.name == "meat_frog" or elem.attr.name == "meat_cursed" or elem.attr.name == "meat_cursed_dry" or elem.attr.name == "meat_slime_cursed" or elem.attr.name == "meat_teleport" or elem.attr.name == "meat_polymorph" or elem.attr.name == "meat_polymorph_protection" or elem.attr.name == "meat_confusion" or elem.attr.name == "wood_player" or elem.attr.name == "wood_player_b2" or elem.attr.name == "wood" or elem.attr.name == "cactus" or elem.attr.name == "grass_loose" or elem.attr.name == "wood_prop" or elem.attr.name == "wood_prop_durable" or elem.attr.name == "nest_box2d" or elem.attr.name == "nest_firebug_box2d" or elem.attr.name == "cocoon_box2d" or elem.attr.name == "wood_loose" or elem.attr.name == "sand_static_rainforest" or elem.attr.name == "soil_lush" then
						elem.attr.tags = elem.attr.tags .. ",[organic]"
		
					elseif (elem.attr.tags ~= nil) then
			
						if array_has(elem.attr.tags, "[plant]") or array_has(elem.attr.tags, "[fungus]") or array_has(elem.attr.tags, "[plant]") then
							elem.attr.tags = elem.attr.tags .. ",[organic]"

							--fuck this. Too annoying

		end
	end
]]            --experimental bloomium stuff

end


-- 		[Mystical Mixtures]

if ModSettingGet("Hydroxide.MM_MATERIALS") == true then
	ModMaterialsFileAdd( "mods/Hydroxide/files/mystical_mixtures/materials.xml" )
end


--		[Fluent Fluids]

if ModSettingGet("Hydroxide.FF") == true then
	ModMaterialsFileAdd( "mods/Hydroxide/files/fluent_fluids/materials.lua" )
end



--  	[Compelling Compatibility]       --


--  Arcane Alchemy x Chemical Curiosities, Materials
local CC_AA_reactions = false
if ModSettingGet("Hydroxide.CC_materials") == true and ModSettingGet("Hydroxide.AA_materials") == true then
	ModMaterialsFileAdd( "mods/Hydroxide/files/compelling_compatibility/internal/CC_AA_reactions.xml" )
	CC_AA_reactions = true
end

if ModSettingGet("Hydroxide.CC_AA_SUPERNOVA") ~= true and CC_AA_reactions == true then
	print("DISABLING SUPERNOVA REACTION, CC_AA STATE == " .. tostring(CC_AA_reactions) .. ", CC_AA_SUPERNOVA == " .. tostring(ModSettingGet("Hydroxide.CC_AA_SUPERNOVA")))
else
	ModMaterialsFileAdd( "mods/Hydroxide/files/compelling_compatibility/internal/supernova/reaction_supernova.xml" )

	print("ENABLING SUPERNOVA REACTION, CC_AA STATE == " .. tostring(CC_AA_reactions) .. ", CC_AA_SUPERNOVA == " .. tostring(ModSettingGet("Hydroxide.CC_AA_SUPERNOVA")))
end

--  Conjurer

if ModIsEnabled("raksa") then

		print("ATTEMPTING TO ADD CONSTR PASTE TO CATASTROPHIC MATERIALS")
	-- Adds Construction Paste to the Catastrophic materials list
	catastrophicMaterials.construction_paste = true

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


--	Copi's Things

if (ModIsEnabled("copis_things")) then
	--ModLuaFileAppend("mods/copis_things/files/scripts/projectiles/material_random.lua", "mods/Hydroxide/files/scripts/append/copis_compatibility/material_random_options.lua") 
	
	ModTextFileSetContent("mods/copis_things/files/scripts/projectiles/material_random.lua", ModTextFileGetContent("mods/Hydroxide/files/compelling_compatibility/copis_compatibility/material_random_options.lua") ) 

	
end --copi's chemical curiosity compatibility combo


if ModIsEnabled("anvil_of_destiny") then --implement this properly when we can add custom materials to anvil

	ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/hydroxide/files/compelling_compatibility/anvil_of_destiny/potionbonus_append.lua")
	ModMaterialsFileAdd( "mods/Hydroxide/files/compelling_compatibility/anvil_of_destiny/materials.xml" )

	local anvil_converter = "mods/anvil_of_destiny/files/entities/anvil/converter.xml"
	local xml = ModDoesFileExist(anvil_converter) and nxml.parse(ModTextFileGetContent(anvil_converter))
	if xml then
	
		for elem in xml:each_child() do
			elem.attr.to_material = "aa_divine_magma"
		end
		ModTextFileSetContent(anvil_converter, tostring(xml))
		
	else	print("AoD Anvil Converter not found at expected location: \"" .. anvil_converter .. "\". Please contact/inform @UserK")	end

end

--	Glimmers Expanded

if (ModIsEnabled("GlimmersExpanded")) then
	ModLuaFileAppend("mods/GlimmersExpanded/files/addGlimmers.lua", "mods/Hydroxide/files/compelling_compatibility/GlimmersExpanded/glimmers.lua")
end





--this function is used to add random recipes
function add_random_recipe(file_to_insert, input1, input2, output1, output2, probability, blob_radius)
	local a1, a2, a3, a4, a5, a6 = GameGetDateAndTimeUTC()

	SetRandomSeed( a1*a2*a3*a4*a5*a6, a1*a2*a3*a4*a5*a6 )

	local xml2lua = dofile("mods/Hydroxide/lib/xml2lua/xml2lua.lua")
	local handler = dofile("mods/Hydroxide/lib/xml2lua/xmlhandler/tree.lua")

	local parser = xml2lua.parser(handler)

	local materials = ModTextFileGetContent(file_to_insert)

	parser:parse(materials)

	local bla = {}

	

	local mat1num = Random(0, #input1)
	
	--[[local has_key = table_get_key(input2, input1[mat1num])
	if(has_key ~= nil)then
		input2[has_key] = nil
	end]]
	
	for k,v in pairs(input2) do
		if v == input1[mat1num] then
			table.remove(input2, k)
		end
	end

	local mat2num = Random(0, #input2)

	table.insert(handler.root.Materials.Reaction, { _attr = {
		probability=tostring(probability),
		input_cell1=input1[mat1num],
		input_cell2=input2[mat2num],
		output_cell1=output1,
		output_cell2=output2,
		blob_radius1=tostring(blob_radius),
		blob_radius2=tostring(blob_radius)
	}})

	ModTextFileSetContent(file_to_insert, xml2lua.toXml(handler.root, "Materials", 0))

	return input1[mat1num], input2[mat1num], output1, output2
end 

-- this do work now :)
--[[
register_translation("item_can_with_material", "Can of $0")
register_translation("item_can_with_material_description", "A Can containing $0")

register_translation("item_vial_with_material", "Vial of $0")
register_translation("item_vial_with_material_description", "A glass vial containing $0")
]]

register_localizations("mods/Hydroxide/translations.csv", 2)




-- Magic numbers, using this to increase the max materials the game can handle.
ModMagicNumbersFileAdd( "mods/Hydroxide/files/magic_numbers.xml" )



--ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/scripts/append/append_actions.lua") -- new spells ( deprecated )
  --new status effects








--appends












--[[
local baseAcidHurt = {"base_enemy_robot", "base_enemy_robot_boss_limbs", "base_helpless_animal", "base_humanoid", "base_prop_crystal" }

local acidHurt = {"alchemist", "bigfirebug", "boss_dragon", "chest_leggy", "darkghost", "eel", "firebug", "firemage", "fireskull", "fish", "gazer", "ghost", "giant", "icemage", "icer", "iceskull", "scavenger_poison", "skygazer", "spitmonster", "thunderskull", "wizard_dark", "wizard_hearty", "wizard_homing", "wizard_neutral", "wizard_poly", "wizard_returner", "wizard_swapper", "wizard_tele", "wizard_twitchy", "wizard_weaken", "worm", "worm_big", "worm_end", "worm_skull", "worm_tiny" }

OnModPostInit(
	for i, entity in ipairs(baseAcidHurt) do
		local path = "data/entities/" .. entity .. ".xml"
		content = ModTextFileGetContent(path)
		xml = nxml.parse(content)
		
		for elem in xml:each_child() do
			--TODO FINISH THIS UP, ITS THE HYDROXIDE DEALING DAMAGE STUFF
		end
	end
	
	for i, entity in ipairs(acidHurt) do
		local path = "data/entities/animals/" .. entity .. ".xml"	
			--TODO FINISH THIS UP, ITS THE HYDROXIDE DEALING DAMAGE STUFF
	end
)
]]--finish this up

--More Musical Magic implementation, coded by Y🍵
if ModTextFileGetContent("data/moremusicalmagic/musicmagic.lua") == nil then
	local data = ModTextFileGetContent("data/moremusicalmagic/compelling_compatibility/musicmagic.lua")
	ModTextFileSetContent("data/moremusicalmagic/musicmagic.lua", data)
end
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_default.lua")
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_chemical.lua")





function OnModPostInit()
	print("Chemical Curiosities - OnModPostInit()") -- First this is called for all mods


	


end


function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.



	print(tostring(catastrophicMaterials.construction_paste))

	-- this code adds tags to preexisting materials, its good for compatibility--
	local xml = nxml.parse(ModTextFileGetContent("data/materials.xml"))

	local files = ModMaterialFilesGet()
	for _, file in ipairs(files) do --add modded materials
		if file ~= "data/materials.xml" then
			for _, comp in ipairs(nxml.parse(ModTextFileGetContent(file)).children) do
				xml.children[#xml.children+1] = comp
			end
		end
	end

	for elem in xml:each_child() do
		--print(("CC: Checking " .. elem.attr.name) or "")
		if catastrophicMaterials[elem.attr.name] then
			elem.attr.tags = elem.attr.tags .. ",[catastrophic]"	
			print("CC: Added tag [catastrophic] to " .. elem.attr.name)
		end
	end

	for elem in xml:each_child() do
	
	    if elem.attr.name == "rock_static_glow" or elem.attr.name == "rock_static_purple" or elem.attr.name == "rock_static_noedge" or elem.attr.name == "rock_static_trip_secret" or elem.attr.name == "rock_static_trip_secret2" or elem.attr.name == "rock_static_intro" or elem.attr.name == "rock_static_intro_breakable" then
		
	        elem.attr.tags = elem.attr.tags .. ",[moss_devour]"	
	--[[	
		elseif elem.attr.name == "rotten_meat" or elem.attr.name == "meat" or elem.attr.name == "meat_slime_sand" or elem.attr.name == "meat_slime" or elem.attr.name == "rotten_meat_radioactive" or elem.attr.name == "meat_worm" or elem.attr.name == "meat_helpless" or elem.attr.name == "meat_trippy" or elem.attr.name == "meat_frog" or elem.attr.name == "meat_cursed" or elem.attr.name == "meat_cursed_dry" or elem.attr.name == "meat_slime_cursed" or elem.attr.name == "meat_teleport" or elem.attr.name == "meat_polymorph" or elem.attr.name == "meat_polymorph_protection" or elem.attr.name == "meat_confusion" or elem.attr.name == "wood_player" or elem.attr.name == "wood_player_b2" or elem.attr.name == "wood" or elem.attr.name == "cactus" or elem.attr.name == "grass_loose" or elem.attr.name == "wood_prop" or elem.attr.name == "wood_prop_durable" or elem.attr.name == "nest_box2d" or elem.attr.name == "nest_firebug_box2d" or elem.attr.name == "cocoon_box2d" or elem.attr.name == "wood_loose" or elem.attr.name == "sand_static_rainforest" or elem.attr.name == "soil_lush" then
			elem.attr.tags = elem.attr.tags .. ",[organic]"

		elseif (elem.attr.tags ~= nil) then
			if array_has(elem.attr.tags, "[plant]") or array_has(elem.attr.tags, "[fungus]") or array_has(elem.attr.tags, "[plant]") then
				elem.attr.tags = elem.attr.tags .. ",[organic]"

				]]--fuck this. Too annoying
	    end
	end

	ModTextFileSetContent("data/materials.xml", tostring(xml))





	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )

	if ModSettingGet("Hydroxide.CC_ORES") then 
	
		if GameHasFlagRun("Squirrelly_Ore_generated") == false then
			dofile_once("mods/Hydroxide/files/chemical_curiosities/ore_gen/inject_ores.lua")
			print("Chemical Curiosities oreGen complete")
			GameAddFlagRun("Squirrelly_Ore_generated")
		end
		
	end


end

OnMagicNumbersAndWorldSeedInitialized = make_timed(OnMagicNumbersAndWorldSeedInitialized, "Chemical Curiosities OnMagicNumbersAndWorldSeedInitialized")

total_time = total_time + GameGetRealWorldTimeSinceStarted() - start_time

print( "Chemical Curiosities main init took " .. GameGetRealWorldTimeSinceStarted() - start_time)

print("////////////// Hydroxide mod init done! //////////////") -- why so many slashes, pleaseeee

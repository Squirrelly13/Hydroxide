-- all functions below are optional and can be left out

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
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

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )
	
	
	if ModSettingGet("Hydroxide.cc_ores") == "on" then 
	
		if GameHasFlagRun("Squirrelly_Ore_generated") == false then
			dofile_once("mods/Hydroxide/files/scripts/oreGen/inject_ores.lua")
			print("Chemical Curiosities oreGen complete")
			GameAddFlagRun("Squirrelly_Ore_generated")
		end
		
	end
end


ModMaterialsFileAdd( "mods/Hydroxide/files/materials.xml" ) 
ModMaterialsFileAdd( "mods/Hydroxide/files/reactions.xml" ) 
-- Adds all new materials and reactions. 
-- This line is arguably the single most important line of code in the mod



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


-- i think this is just so that the name for vials can show materials? seems to break something.
--[[
register_translation("item_vial_with_material", "Vial of $0")
register_translation("item_vial_with_material_description", "A glass vial containing $0")
]]

-- This code runs when all mods' filesystems are registered
if ModSettingGet("Hydroxide.cc_spells") == "on" then 
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/actions.lua" ) -- adds spells, really just sea of methane
end


ModMagicNumbersFileAdd( "mods/Hydroxide/files/magic_numbers.xml" ) -- Will override some magic numbers using the specified file
--no idea what magic numbers are, but this does somethin to em


--ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Hydroxide/files/scripts/append/append_actions.lua") -- new spells ( deprecated )
 
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Hydroxide/files/scripts/append/append_status_list.lua" ) --new status effects

if ModSettingGet("Hydroxide.cc_flasks") == "on" then
	ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/Hydroxide/files/scripts/append/append_potion.lua" ) -- potions with new materials
	ModLuaFileAppend( "data/scripts/items/powder_stash.lua", "mods/Hydroxide/files/scripts/append/append_powders.lua" ) -- powder bags spawn with new materials
	ModLuaFileAppend( "data/scripts/items/potion_aggressive.lua", "mods/Hydroxide/files/scripts/append/append_potion_aggressive.lua" ) --for alchemist enemy
	ModLuaFileAppend("data/scripts/items/potion_starting.lua", "mods/Hydroxide/files/scripts/append/append_potion_starting.lua")
end



ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/Hydroxide/files/scripts/append/append_gun_extra_modifiers.lua" ) --extra modifiers?

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_coalmine.lua" ) --new structures in the mines
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_coalmine_alt.lua" ) --new structures in the collapsed mines
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_excavationsite.lua" ) --new structures in the coal pits
ModLuaFileAppend( "data/scripts/biomes/liquidcave.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_liquidcave.lua" ) --new structures in the alchemy lab
ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_snowcastle.lua" ) --new structures in hiisi base
ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_snowcave.lua" ) --new structures in hiisi base
ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Hydroxide/files/scripts/append/pixel_scenes/append_vault.lua" ) --new structures in the vault

if ModSettingGet("Hydroxide.cc_items") == "on" then
	ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/Hydroxide/files/scripts/append/append_items.lua" ) --adds items to pedestals
end

ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/Hydroxide/files/scripts/append/append_fungal.lua" ) --FUngal shifts
--appends

if (ModIsEnabled("copis_things")) then
	--ModLuaFileAppend("mods/copis_things/files/scripts/projectiles/material_random.lua", "mods/Hydroxide/files/scripts/append/copis_compatibility/material_random_options.lua") 
	
	ModTextFileSetContent("mods/copis_things/files/scripts/projectiles/material_random.lua", ModTextFileGetContent("mods/Hydroxide/files/scripts/append/copis_compatibility/material_random_options.lua") ) 

	
end --copis chemical curiosity compatibility combo


-- this code adds tags to preexisting materials, its good for compatibility--
local nxml = dofile_once("mods/Hydroxide/files/lib/nxml.lua")
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for elem in xml:each_child() do
    
    if elem.attr.name == "rock_static_glow" or elem.attr.name == "rock_static_purple" or elem.attr.name == "rock_static_noedge" or elem.attr.name == "rock_static_trip_secret" or elem.attr.name == "rock_static_trip_secret2" or elem.attr.name == "rock_static_intro" or elem.attr.name == "rock_static_intro_breakable" then
       
        elem.attr.tags = elem.attr.tags .. ",[mossDevour]"	
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







function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
    EntitySetDamageFromMaterial( player_entity, "hydroxide", 0.005 )
	
	  if GameHasFlagRun("squirrellys_music_altar_is_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
		if ModSettingGet("Hydroxide.cc_pixelscenes") == "on" then
			EntityLoad("mods/Hydroxide/files/pixel_scenes/music_shrine.xml", 6200, 5500)  --load the musical shrine
		end
		
		EntityLoad("mods/Hydroxide/files/pixel_scenes/signature.xml", -1950, 250)  --load my cute stupid lil signature :) 
		
        GameAddFlagRun("squirrellys_music_altar_is_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now

    end
end
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

print("Hydroxide mod init done")
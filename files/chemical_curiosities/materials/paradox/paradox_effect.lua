dofile("mods/Hydroxide/files/lib/status_helper.lua")

dofile_once("mods/Hydroxide/lib/polytools/polytools_init.lua").init("mods/Hydroxide/lib/polytools")
local polytools = dofile_once("mods/Hydroxide/lib/polytools/polytools.lua")


local filter_materials = function( mats )
	for i=#mats,1,-1 do
		local mat = mats[i]
		local tags = CellFactory_GetTags( CellFactory_GetType(mat) ) or {}
		for _,tag in ipairs(tags) do
			if tag == "[box2d]" or tag == "[catastrophic]" then
				table.remove( mats, i )
				break
			end
		end
	end

	return mats
end

local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local root_x, root_y = EntityGetTransform(root)

local function DuplicateEntity(entity_id)
	EntityAddTag(entity_id, "paradox_clone")
	local comp = EntityAddComponent2(entity_id, "LuaComponent",
	{
		script_source_file = "mods/Hydroxide/files/chemical_curiosities/materials/paradox/evil_clone.lua",
		execute_every_n_frame = 2,
		execute_times = 1,
	})
	ComponentAddTag(comp, "paradox_clone")
	local x, y = EntityGetTransform(entity_id)
	local serialized = polytools.save(entity_id)

	return polytools.spawn(x, y, serialized):id()
end


local function EvilClone()
	DuplicateEntity(root)
end

local clone_comps = EntityGetComponent(root, "LuaComponent", "paradox_clone")
if(clone_comps)then
	for _,comp in ipairs(clone_comps)do
		EntityRemoveComponent(root, comp)
	end
end

EntityRemoveTag(root, "paradox_clone")



if(root == entity_id)then
    return
end

local percentage = GetIngestionPercentage(root, "CC_PARADOX")
ticks = tonumber(GlobalsGetValue("paradox_ticks", "0"))


warp = warp or 0

if(percentage > 20)then
    if(not GameHasFlagRun("is_warped"))then

        local world_seed = StatsGetValue("world_seed")
		SetWorldSeed(world_seed + 1)
		SetRandomSeed( root_x + world_seed, root_y )
        GameAddFlagRun("is_warped")

		local liquids = filter_materials(CellFactory_GetAllLiquids()) or {}
		local sands = filter_materials(CellFactory_GetAllSands()) or {}
		local solids = filter_materials(CellFactory_GetAllSolids()) or {}



		-- do like 20 fungal shifts on every reasonable material type because we love chaos here
		for i=1,20 do
			local liquid1 = CellFactory_GetType(liquids[Random(1, #liquids)])
			local liquid2 = CellFactory_GetType(liquids[Random(1, #liquids)])
			local solid1 = CellFactory_GetType(solids[Random(1, #solids)])
			local solid2 = CellFactory_GetType(solids[Random(1, #solids)])
			local sand1 = CellFactory_GetType(sands[Random(1, #sands)])
			local sand2 = CellFactory_GetType(sands[Random(1, #sands)])

			--print(tostring(liquid1), tostring(liquid2), tostring(solid1), tostring(solid2), tostring(sand1), tostring(sand2))

			ConvertMaterialEverywhere( liquid1, liquid2 )
			ConvertMaterialEverywhere( solid1, solid2 )
			ConvertMaterialEverywhere( sand1, sand2 )
		end

        GamePlaySound( "mods/Hydroxide/files/mystical_mixtures/misc/mystical_mixtures.bank", "warp/warp_sound", root_x, root_y )
        GamePlaySound( "mods/Hydroxide/files/mystical_mixtures/misc/mystical_mixtures.bank", "warp/warp_sound", target_x, target_y )

        --GameEntityPlaySound( entity_id, "warp/warp_sound" )
    end
end

local regen = false
if(GameHasFlagRun("is_warped"))then
    ticks = ticks + 1
    if(ticks < 45)then

        warp = warp + 1

		GameSetPostFxParameter("cc_warp_multiplier", warp, 0 ,0 ,0)

        if(ticks == 43)then
			GamePrint("$log_cc_paradox_warp")
            regen = true
            EntityIngestMaterial( root, CellFactory_GetType("cc_warp_sickness"), 1)
        end
    else
        local done = false
        warp = warp - 2
        if(warp <= 0)then
            warp = 0
            ticks = 0
            done = true
        end

        GameSetPostFxParameter("cc_warp_multiplier", warp, 0 ,0 ,0)

        if(done)then
			EntityRemoveIngestionStatusEffect( root, "CC_PARADOX" )
			EntityKill(entity_id)
			GameSetPostFxParameter("cc_warp_multiplier", 0, 0 ,0 ,0)
			GameRemoveFlagRun("is_warped")
			--EvilClone()
        end
    end

	GlobalsSetValue("paradox_ticks", tostring(ticks))
end

if(regen)then
	BiomeMapLoad_KeepPlayer( "data/scripts/biome_map.lua", "data/biome/_pixel_scenes.xml" )
end
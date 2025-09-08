dofile_once("data/scripts/lib/utilities.lua")


local function table_dump(o) --handy func i stole that prints an entire table
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. table_dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

ItemPedestalLib = {
    error_prints = true,
    default_reroll = false
}
local ip = ItemPedestalLib
ip.lists = {
    default = {
        {
            --(optional) origin should be the mod that adds this entry 
            origin = "vanilla",
            --(optional) an ideally somewhat-unique identifier that can be used by mods looping over spawnlists to find and modify specific entries (this exists since its not easy to differentiate entries that use functions for spawns)
            id = "potion",
            --probability should be the asigned weight
            probability = 65,
            --(optional) the spawn function will first check for a load_entity value and EntityLoad(load_entity, x + offset_x, y + offset_y) if it exists
            load_entity = "data/entities/items/pickup/potion.xml",
            --(default: 0) x offset used for the load_entity method
            offset_x = nil,
            --(default: 0) y offset used for the load_entity method
            offset_y = -2,
            --(optional) this function is run if load_entity is left blank. miscellaneous values are passed through the data field followed by the x and y positions
            load_entity_func = nil,
            --(optional) required GameHasFlagRun(spawn_requires_flag) check for the entity to spawn
            spawn_requires_flag = nil,
            --(default: false) if condition fails, should pedestal item be rerolled? if nil, can be overridden by ip.default_reroll
            reroll_if_no_spawn = nil
        },
        {
            id = "greed_orb",
            origin = "vanilla",
            probability = 2,
            load_entity_func = function (self, x, y)
                local ox = self.offset_x or 0
                local oy = self.offset_y or 0

                if GameHasFlagRun("greed_curse") and ( GameHasFlagRun("greed_curse_gone") == false ) then
                    EntityLoad("data/entities/items/pickup/physics_gold_orb_greed.xml", x + ox, y + oy)
                else
                    EntityLoad("data/entities/items/pickup/physics_gold_orb.xml", x + ox, y + oy)
                end
            end,
            offset_y = -2,
        },
        {
            id = "broken_wand",
            origin = "vanilla",
            probability = 4,
            load_entity = "data/entities/items/pickup/broken_wand.xml",
            offset_y = -2,
        },
        {
            id = "thunderstone",
            origin = "vanilla",
            probability = 2,
            load_entity = "data/entities/items/pickup/thunderstone.xml",
            offset_y = -2,
        },
        {
            id = "brimstone",
            origin = "vanilla",
            probability = 4,
            load_entity = "data/entities/items/pickup/brimstone.xml",
            offset_y = -2,
        },
        {
            id = "egg_monster",
            origin = "vanilla",
            probability = 2,
            load_entity = "data/entities/items/pickup/egg_monster.xml",
            offset_y = -2,
        },
        {
            id = "egg_slime",
            origin = "vanilla",
            probability = 4,
            load_entity = "data/entities/items/pickup/egg_slime.xml",
            offset_y = -2,
        },
        {
            id = "egg_purple",
            origin = "vanilla",
            probability = 1,
            load_entity = "data/entities/items/pickup/egg_purple.xml",
            offset_y = -2,
        },
        {
            id = "runestone",
            origin = "vanilla",
            probability = 1,
            load_entity_func = function (self, x, y )
					-- NOTE( Petri ): 6.3.2023 - Changed the SetRandomSeed to be different, so that we might get other runestones than edges
					SetRandomSeed( x+2617.941, y-1229.3581 )
					local opts = { "laser", "fireball", "lava", "slow", "null", "disc", "metal" }
					local rnd = Random( 1, #opts )
					local opt = opts[rnd]
					local ox = self.offset_x or 0
					local oy = self.offset_y or 0
					local entity_id = EntityLoad( "data/entities/items/pickup/runestones/runestone_" .. opt .. ".xml", x + ox, y + oy )
					rnd = Random( 1, 10 )
					if ( rnd == 2 ) then
						runestone_activate( entity_id )
					end
				end,
            offset_y = -10,
        },
        {
            id = "chaos_die",
            origin = "vanilla",
            probability = 1,
            load_entity_func = function (self, x, y)
					local ox = self.offset_x or 0
					local oy = self.offset_y or 0

					if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
						EntityLoad( "data/entities/items/pickup/physics_greed_die.xml", x + ox, y + oy )
					else
						EntityLoad( "data/entities/items/pickup/physics_die.xml", x + ox, y + oy )
					end
				end,
            offset_y = -12,
            spawn_requires_flag = "card_unlocked_duplicate"
        },
        {
            id = "powder_stash",
            origin = "vanilla",
            probability = 5,
            load_entity = "data/entities/items/pickup/powder_stash.xml",
            offset_y = -2,
        },
    },
    liquidcave ={
        {
            id = "broken_wand",
            origin = "vanilla",
            probability = 4,
            load_entity = "data/entities/items/pickup/broken_wand.xml",
            offset_y = -2,
        },
        {
            id = "moon",
            origin = "vanilla",
            probability = 6,
            load_entity = "data/entities/items/pickup/moon.xml",
            offset_y = -2,
        },
        {
            id = "thunderstone",
            origin = "vanilla",
            probability = 6,
            load_entity = "data/entities/items/pickup/thunderstone.xml",
            offset_y = -2,
        },
        {
            id = "brimstone",
            origin = "vanilla",
            probability = 6,
            load_entity = "data/entities/items/pickup/brimstone.xml",
            offset_y = -2,
        },
        {
            id = "egg_monster",
            origin = "vanilla",
            probability = 6,
            load_entity = "data/entities/items/pickup/egg_monster.xml",
            offset_y = -2,
        },
        {
            id = "egg_slime",
            origin = "vanilla",
            probability = 3,
            load_entity = "data/entities/items/pickup/egg_slime.xml",
            offset_y = -2,
        },
        {
            id = "egg_fire",
            origin = "vanilla",
            probability = 3,
            load_entity = "data/entities/items/pickup/egg_fire.xml",
            offset_y = -2,
        },
        {
            id = "egg_purple",
            origin = "vanilla",
            probability = 3,
            load_entity = "data/entities/items/pickup/egg_purple.xml",
            offset_y = -2,
        },
        {
            id = "potion",
            origin = "vanilla",
            probability = 49,
            load_entity = "data/entities/items/pickup/potion.xml",
            offset_y = -2,
        },
    }
}
ip.lists.potion_spawnlist = ip.lists.default --pointers for vanilla names cuz i replaced the vanilla table names (i didnt like them)
ip.lists.potion_spawnlist_liquidcave = ip.lists.liquidcave

spawnlists  =
{
    potion_spawnlist = {
        rnd_min = 0,
        rnd_max = 0,
        spawns = {}
    },
    potion_spawnlist_liquidcave = {
        rnd_min = 0,
        rnd_max = 0,
        spawns = {}
    }
}

for spawnlist_key, spawnlist in pairs(spawnlists ) do
    --convert potion_spawnlist -> default and potion_spawnlist_liquidcave -> liquidcave
    spawnlist_key = spawnlist_key == "potion_spawnlist" and "default" --default is a more sane name under new system
        or spawnlist_key == "potion_spawnlist_liquidcave" and "liquidcave" --i honestly just felt like it.
        or spawnlist_key
    local target = ip.lists[spawnlist_key]

    target = target or {}
    for index, entry in ipairs(spawnlist.spawns) do
        target[#target+1] = {
            origin = entry.origin or "unknown",
            probability = (entry.rnd_max - entry.rnd_min + 1), --i dont see how anyone could have either of these values be invalid and have it be my fault for not accounting for it
            entity_path = entry.load_entity,
            entity_function = entry.load_entity_func,
            offset_x = entry.offset_x or 0,
            offset_y = entry.offset_y or 0,
            spawn_requires_flag = entry.spawn_requires_flag,
            lib_converted = true,
        }
    end
end


function spawn_from_list (list_id, x, y)
    SetRandomSeed(x+425, y-243)
    list_id = list_id or "default"
    local spawn_list = ip.lists[list_id]
    if #spawn_list == 0 then
        if ip.error_prints then
            print(("Warning! Provided spawnlist [%s] is empty or invalid."):format(list_id))
        end
        return
    end

    local total_weight = 0
    for _, entry in ipairs(spawn_list) do
        total_weight =  total_weight + entry.probability
    end
    local target = {}
    for i = 1, 100, 1 do --run 100 times for reroll attempts
        local rnd = Random(0, total_weight)
        --if rnd == 0 then rndprints = true else rndprints = false end
        for _, entry in ipairs(spawn_list) do
            if rnd <= entry.probability then
                target = entry
                break
            else rnd = rnd - entry.probability end
        end

        if (not target.spawn_requires_flag or GameHasFlagRun(target.spawn_requires_flag)) and (not target.spawn_requires_func or target:spawn_requires_func(x, y)) then
            break
        else
            if target.reroll_if_no_spawn == nil then target.reroll_if_no_spawn = ip.default_reroll end --set to default value if reroll_if_no_spawn is nil
            if not target.reroll_if_no_spawn then
                return
            end
        end
    end

    if target.load_entity then
        ---EntityLoad(target.load_entity, x+(target.offset_x or 0), y+(target.offset_y or 0))
    elseif target.load_entity_func then
        ---target:load_entity_func(x, y)
    elseif ip.error_prints then
        print(("null item spawn: [%s, %s]"):format(x, y))
        print(table_dump(target))
    end
end












spawnlists_OLD =
{
    potion_spawnlist =
    {
        rnd_min = 1,
        rnd_max = 91,
        spawns =
        {
            {
                value_min = 90,
                value_max = 91,
                load_entity_func =
                    function( data, x, y )
                        local ox = data.offset_x or 0
                        local oy = data.offset_y or 0

                        if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
                            EntityLoad( "data/entities/items/pickup/physics_gold_orb_greed.xml", x + ox, y + oy )
                        else
                            EntityLoad( "data/entities/items/pickup/physics_gold_orb.xml", x + ox, y + oy )
                        end
                    end,
                offset_y = -2,
            },
            {
                value_min = 86,
                value_max = 89,
                load_entity = "data/entities/items/pickup/broken_wand.xml",
                offset_y = -2,
            },
            {
                value_min = 84,
                value_max = 85,
                load_entity = "data/entities/items/pickup/thunderstone.xml",
                offset_y = -2,
            },
            {
                value_min = 80,
                value_max = 83,
                load_entity = "data/entities/items/pickup/brimstone.xml",
                offset_y = -2,
            },
            {
                value_min = 78,
                value_max = 79,
                load_entity = "data/entities/items/pickup/egg_monster.xml",
                offset_y = -2,
            },
            {
                value_min = 74,
                value_max = 77,
                load_entity = "data/entities/items/pickup/egg_slime.xml",
                offset_y = -2,
            },
            {
                value_min = 73,
                value_max = 73,
                load_entity = "data/entities/items/pickup/egg_purple.xml",
                offset_y = -2,
            },
            {
                value_min = 72,
                value_max = 72,
                load_entity_func =
                    function( data, x, y )
                        -- NOTE( Petri ): 6.3.2023 - Changed the SetRandomSeed to be different, so that we might get other runestones than edges
                        SetRandomSeed( x+2617.941, y-1229.3581 )
                        local opts = { "laser", "fireball", "lava", "slow", "null", "disc", "metal" }
                        local rnd = Random( 1, #opts )
                        local opt = opts[rnd]
                        local ox = data.offset_x or 0
                        local oy = data.offset_y or 0
                        local entity_id = EntityLoad( "data/entities/items/pickup/runestones/runestone_" .. opt .. ".xml", x + ox, y + oy )
                        rnd = Random( 1, 10 )
                        if ( rnd == 2 ) then
                            runestone_activate( entity_id )
                        end
                    end,
                offset_y = -10,
            },
            {
                value_min = 71,
                value_max = 71,
                load_entity_func =
                    function( data, x, y )
                        local ox = data.offset_x or 0
                        local oy = data.offset_y or 0

                        if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
                            EntityLoad( "data/entities/items/pickup/physics_greed_die.xml", x + ox, y + oy )
                        else
                            EntityLoad( "data/entities/items/pickup/physics_die.xml", x + ox, y + oy )
                        end
                    end,
                offset_y = -12,
                spawn_requires_flag = "card_unlocked_duplicate",
            },
            {
                value_min = 66,
                value_max = 70,
                load_entity = "data/entities/items/pickup/powder_stash.xml",
                offset_y = -2,
            },
            {
                value_min = 1,
                value_max = 65,
                load_entity = "data/entities/items/pickup/potion.xml",
                offset_y = -2,
            },
        },
    },
    potion_spawnlist_liquidcave =
    {
        rnd_min = 1,
        rnd_max = 86,
        spawns =
        {
            {
                value_min = 83,
                value_max = 86,
                load_entity = "data/entities/items/pickup/broken_wand.xml",
                offset_y = -2,
            },
            {
                value_min = 77,
                value_max = 82,
                load_entity = "data/entities/items/pickup/moon.xml",
                offset_y = -2,
            },
            {
                value_min = 71,
                value_max = 76,
                load_entity = "data/entities/items/pickup/thunderstone.xml",
                offset_y = -2,
            },
            {
                value_min = 65,
                value_max = 70,
                load_entity = "data/entities/items/pickup/brimstone.xml",
                offset_y = -2,
            },
            {
                value_min = 59,
                value_max = 64,
                load_entity = "data/entities/items/pickup/egg_monster.xml",
                offset_y = -2,
            },
            {
                value_min = 56,
                value_max = 58,
                load_entity = "data/entities/items/pickup/egg_slime.xml",
                offset_y = -2,
            },
            {
                value_min = 53,
                value_max = 55,
                load_entity = "data/entities/items/pickup/egg_fire.xml",
                offset_y = -2,
            },
            {
                value_min = 50,
                value_max = 52,
                load_entity = "data/entities/items/pickup/egg_purple.xml",
                offset_y = -2,
            },
            {
                value_min = 1,
                value_max = 49,
                load_entity = "data/entities/items/pickup/potion.xml",
                offset_y = -2,
            },
        },
    },
}

function spawn_from_list_OLD( listname, x, y )
    SetRandomSeed( x+425, y-243 )
    local spawnlist

    if ( type( listname ) == "string" ) then
        spawnlist = spawnlists_OLD[listname]
    elseif ( type( listname ) == "table" ) then
        spawnlist = listname
    end

    if ( spawnlist == nil ) then
        print( "Couldn't find a spawn list with name: " .. tostring( listname ) )
        return
    end

    local rndmin = spawnlist.rnd_min or 0
    local rndmax = spawnlist.rnd_max or 100

    local rnd = Random( rndmin, rndmax )

    if ( spawnlist.spawns ~= nil ) then
        for i,data in ipairs( spawnlist.spawns ) do
            local vmin = data.value_min or rndmin
            local vmax = data.value_max or rndmax

            if ( rnd >= vmin ) and ( rnd <= vmax ) then
                if ( data.spawn_requires_flag ~= nil ) and ( HasFlagPersistent( data.spawn_requires_flag ) == false ) then
                    return
                end

                local ox = data.offset_x or 0
                local oy = data.offset_y or 0

                if ( data.load_entity_func ~= nil ) then
                    --data.load_entity_func( data, x, y )
                    return
                elseif ( data.load_entity_from_list ~= nil ) then
                    spawn_from_list_OLD( data.load_entity_from_list, x, y )
                    return
                elseif ( data.load_entity ~= nil ) then
                    --EntityLoad( data.load_entity, x + ox, y + oy )
                    return
                end
            end
        end
    end
end
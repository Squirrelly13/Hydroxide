dofile_once("data/scripts/lib/utilities.lua") --for items that rely on this in item spawn funcs

ItemPedestalLib = {
	error_prints = true,
	default_reroll = false,
	prefuncs = {},
	convert = true,
	error = function(self, log, x, y, target)
		if ItemPedestalLib.error_prints then
			print((log):format(x or 0, y or 0))
		end
	end,

	runestones = {
		"data/entities/items/pickup/runestones/runestone_laser.xml",
		"data/entities/items/pickup/runestones/runestone_fireball.xml",
		"data/entities/items/pickup/runestones/runestone_lava.xml",
		"data/entities/items/pickup/runestones/runestone_slow.xml",
		"data/entities/items/pickup/runestones/runestone_null.xml",
		"data/entities/items/pickup/runestones/runestone_disc.xml",
		"data/entities/items/pickup/runestones/runestone_metal.xml",
	}
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
			--(default: false) whether or not load_entity_func should pass self (not default or else)
			use_self = true,
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
			use_self = true,
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
			use_self = true,
			load_entity_func = function (self, x, y )
					-- NOTE( Petri ): 6.3.2023 - Changed the SetRandomSeed to be different, so that we might get other runestones than edges
					SetRandomSeed(x+2617.941, y-1229.3581)
					local opt = ip.runestones[Random(1, #ip.runestones)]
					local ox = self.offset_x or 0
					local oy = self.offset_y or 0
					local entity_id = EntityLoad(opt, x + ox, y + oy)
					if (Random(1, 10) == 2) then
						runestone_activate(entity_id)
					end
				end,
			offset_y = -10,
		},
		{
			id = "chaos_die",
			origin = "vanilla",
			probability = 1,
			use_self = true,
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

ip.convert_to_lib = function(old_list, name, targetpath)
	--convert potion_spawnlist -> default and potion_spawnlist_liquidcave -> liquidcave
	name = name == "potion_spawnlist" and "default" --default is a more sane name under new system
		or name == "potion_spawnlist_liquidcave" and "liquidcave" --this is better in the long run imo
		or name
	local target = targetpath[name] or {}

	for index, entry in ipairs(old_list.spawns) do
		target[#target+1] = {
			origin = entry.origin or entry.mod or "unknown",
			probability = (entry.value_max - entry.value_min + 1), --i dont see how anyone could have either of these values be invalid and have it be my fault for not accounting for it
			load_entity = entry.load_entity,
			load_entity_func = entry.load_entity_func,
			load_entity_from_list = entry.load_entity_from_list,
			offset_x = entry.offset_x,
			offset_y = entry.offset_y,
			spawn_requires_flag = entry.spawn_requires_flag,
			lib_converted = true,
		}
		if entry.load_entity_from_list then --nolla apparently added recursion to their spawnlists, so thats fun.
			ip.convert_to_lib(entry.load_entity_from_list, "load_entity_from_list", target[#target])
		end
	end
end

ITEMLIBOUTPUT = {} --used to test item spawn weights (will not be included in final lib)
RND_PRINTOUT = {}
local is_seeded
function spawn_from_list(target_list, x, y)
	if ip.convert then
		for name, old_list in pairs(spawnlists) do
			ip.convert_to_lib(old_list, name, ip.lists)
		end
		ip.convert = false --so we dont run this on every item spawn
	end

	if is_seeded == nil then SetRandomSeed(x+425, y-2413) end
	target_list = target_list or "default"
	local spawn_list = ip.lists[tostring(target_list)] or {}
	if type(target_list) == "table" then
		spawn_list = target_list
	end

	for _, func in ipairs(ip.prefuncs) do
		spawn_list = func(spawn_list) or spawn_list
	end

	if #spawn_list == 0 then
		ip:error(("Warning! Provided spawnlist [%s] is empty or invalid."):format(target_list), target_list)
		return
	end

	local total_weight = 0
	for _, entry in ipairs(spawn_list) do
		total_weight = total_weight + entry.probability
	end
	local target = {}
	local rnd
	for i = 1, 100, 1 do --run 100 times for reroll attempts
		rnd = Randomf(0, total_weight) --use Randomf() to support decimal weight probabilities

		for _, entry in ipairs(spawn_list) do
			if rnd <= entry.probability then
				target = entry
				break
			else
				rnd = rnd - entry.probability
			end
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

	if target == nil then ip:error(("null item spawn: [%s, %s]"):format(x, y)) return end

	if target.load_entity_func then
		target:load_entity_func(x, y)
	end

	if target.load_entity then
		EntityLoad(target.load_entity, x+(target.offset_x or 0), y+(target.offset_y or 0))
	elseif not (target.load_entity_func or target.load_entity_from_list) then
		ip:error("empty item spawn: [%s, %s]", x, y, target)
	end

	if target.load_entity_from_list then
		is_seeded = true
		spawn_from_list(target.load_entity_from_list, x+(target.offset_x or 0), y+(target.offset_y or 0))
		is_seeded = false
	end

	local id = target.id or target.load_entity or target.load_entity or tostring(target.load_entity_from_list) or "null"
	ITEMLIBOUTPUT[id] = (ITEMLIBOUTPUT[id] or 0) + 1
end
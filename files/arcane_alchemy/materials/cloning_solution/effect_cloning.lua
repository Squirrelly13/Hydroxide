dofile_once("mods/Hydroxide/lib/squirreltilities.lua")

local root = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(root)

SetRandomSeed(GameGetFrameNum(), x + y + root)

local function check_clone_cap(str)
	local valid_eids = {}
	local new_str = ""
	for eid_str in string.gmatch(str, '([^,]+)') do
		local eid = tonumber(eid_str) or 0
		if EntityGetIsAlive(eid) then
			valid_eids[#valid_eids+1] = eid
			new_str = new_str .. "," .. eid
		end
	end
	return #valid_eids,new_str --return number of still alive entities from the list and list with invalid entities purged
end

--check for cooldown and cap on root entity
local clone_cooldown = 0
local clones_spawned = ""
local clone_origin_data
for _, comp in ipairs(EntityGetComponent(root, "VariableStorageComponent") or {}) do
	local varcomp_name = ComponentGetValue2(comp, "name")
	if varcomp_name == "aa_clone_origin_data" then
		clone_origin_data = comp
		clone_cooldown = ComponentGetValue2(comp, "value_int") or 0
		clones_spawned = ComponentGetValue2(comp, "value_string") or ""
	end
end

local frame = GameGetFrameNum()
if frame < clone_cooldown then return end
clone_origin_data = clone_origin_data or EntityAddComponent2(root, "VariableStorageComponent", {name = "aa_clone_origin_data"})
ComponentSetValue2(clone_origin_data, "value_int", frame + 540) --9 second cooldown on cloning

local clones_spawned_num
clones_spawned_num,clones_spawned = check_clone_cap(clones_spawned)

if EntityHasTag(root, "player_unit") then
	if clones_spawned_num >= 7 then return end --cap of 7 clones for players

	local clone = CreateClone("data/entities/animals/failed_alchemist.xml", root, x + Random(15, -15), y + Random(5, 10), "player")
	ComponentSetValue2(clone_origin_data, "value_string", clones_spawned .. "," .. clone)

	for _, comp in ipairs(EntityGetComponent(clone, "LuaComponent") or {}) do
		if ComponentGetValue2(comp, "script_source_file") == "data/scripts/animals/failed_alchemist_aura.lua" then
			EntityRemoveComponent(clone, comp) --remove invulnerability stuff
		end
	end

	EntityRemoveComponent(clone, EntityGetFirstComponent(clone, "ParticleEmitterComponent") or 0)

	EntityAddComponent2(clone, "LifetimeComponent", {
		lifetime = 10800 --3 minute lifespan on player clones
	})

	return
end



if not (EntityHasTag(root, "enemy") or #EntityGetWithTag("enemy") < 130) then return end --dont clone if theres already an absurd number of enemies nearby

if clones_spawned_num >= 14 then return end --cap of 14 clones for enemies

for _, comp in ipairs(EntityGetComponent(root, "VariableStorageComponent") or {}) do
	if ComponentGetValue2(comp, "name") == "aa_clone_data" then return	end --if enemy is a clone, dont clone
end

local path = EntityGetFilename(root)
if not ModDoesFileExist(path) then return end

local clone = CreateClone(path, root, x + Random(15, -15), y + Random(5, 10))
ComponentSetValue2(clone_origin_data, "value_string", clones_spawned .. "," .. clone)
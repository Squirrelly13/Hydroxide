dofile_once("data/scripts/lib/utilities.lua")

local max_dist = 900
local tag = "enemy"

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

-- set initial position
local children = EntityGetAllChildren(entity_id)
for _,anchor in ipairs(children) do
	if EntityHasTag(anchor, "glue_anchor") then
		EntitySetTransform(anchor, pos_x, pos_y)
	end
end

-- optimization: remove when it gets crowded
if #EntityGetInRadiusWithTag( pos_x, pos_y, 80, "glue") > 10 then
	EntityKill(entity_id)
	return
end

-- identify target & check that it's valid
local target = EntityGetClosestWithTag( pos_x, pos_y, tag)
if target == nil or target == 0 then return end

target = EntityGetRootEntity(target)
local tx, ty = EntityGetTransform(target)
if get_distance(pos_x, pos_y, tx, ty) > max_dist or EntityHasTag( target, "player" ) then return end

-- assign a target to glue anchor
component_write( EntityGetFirstComponent( children[1], "VariableStorageComponent" ), { value_int = target } )

-- optional secondary target
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, max_dist, tag)
if #targets < 2 then return end

SetRandomSeed(pos_x, pos_y + GameGetFrameNum())
local target2 = EntityGetRootEntity(random_from_array(targets))
if target2 ~= target then
    component_write( EntityGetFirstComponent( children[2], "VariableStorageComponent" ), { value_int = target2 } )
end

local target3 = EntityGetRootEntity(random_from_array(targets))
if target3 ~= target then
    component_write( EntityGetFirstComponent( children[3], "VariableStorageComponent" ), { value_int = target3 } )
end

local target4 = EntityGetRootEntity(random_from_array(targets))
if target4 ~= target then
    component_write( EntityGetFirstComponent( children[4], "VariableStorageComponent" ), { value_int = target4 } )
end

local target5 = EntityGetRootEntity(random_from_array(targets))
if target5 ~= target then
    component_write( EntityGetFirstComponent( children[5], "VariableStorageComponent" ), { value_int = target5 } )
end
local target6 = EntityGetRootEntity(random_from_array(targets))
if target6 ~= target then
    component_write( EntityGetFirstComponent( children[6], "VariableStorageComponent" ), { value_int = target6 } )
end

local target7 = EntityGetRootEntity(random_from_array(targets))
if target7 ~= target then
    component_write( EntityGetFirstComponent( children[7], "VariableStorageComponent" ), { value_int = target7 } )
end

local target8 = EntityGetRootEntity(random_from_array(targets))
if target8 ~= target then
    component_write( EntityGetFirstComponent( children[8], "VariableStorageComponent" ), { value_int = target8 } )
end

local target9 = EntityGetRootEntity(random_from_array(targets))
if target9 ~= target then
    component_write( EntityGetFirstComponent( children[9], "VariableStorageComponent" ), { value_int = target9 } )
end
local target10 = EntityGetRootEntity(random_from_array(targets))
if target10 ~= target then
    component_write( EntityGetFirstComponent( children[10], "VariableStorageComponent" ), { value_int = target10 } )
end

local target11 = EntityGetRootEntity(random_from_array(targets))
if target11 ~= target then
    component_write( EntityGetFirstComponent( children[11], "VariableStorageComponent" ), { value_int = target11 } )
end

local target12 = EntityGetRootEntity(random_from_array(targets))
if target12 ~= target then
    component_write( EntityGetFirstComponent( children[12], "VariableStorageComponent" ), { value_int = target12 } )
end

local target13 = EntityGetRootEntity(random_from_array(targets))
if target13 ~= target then
    component_write( EntityGetFirstComponent( children[13], "VariableStorageComponent" ), { value_int = target13 } )
end

local target14 = EntityGetRootEntity(random_from_array(targets))
if target14 ~= target then
    component_write( EntityGetFirstComponent( children[14], "VariableStorageComponent" ), { value_int = target14 } )
end

local target15 = EntityGetRootEntity(random_from_array(targets))
if target15 ~= target then
    component_write( EntityGetFirstComponent( children[15], "VariableStorageComponent" ), { value_int = target15 } )
end
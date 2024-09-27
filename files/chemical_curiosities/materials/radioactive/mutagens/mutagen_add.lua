if GameGetFrameNum() % 2 == 0 then return end --makes the script run every 2 frames

local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

local children = EntityGetAllChildren(owner) or {}



local radiation_controller

for i, child in ipairs(children) do
	if EntityGetName(child) == "radiation_controller" then
		radiation_controller = child
		break
	end
end

if radiation_controller == nil then
	radiation_controller = EntityAddChild(owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/radiation_controller.xml"))
end

local var_comps = EntityGetComponent(owner, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end

for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then
		ComponentSetValue2(varcomp, "value_int", ComponentGetValue2(varcomp, "name") + 5)
	end
end



--[[ 
local count = 0
local leggy = false
local vomit = false
local aiming = false
local shaking = false
local icon = false


print("Radiation effect count: " .. count )

if not icon then
	EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/mutagens/mutagen_icon.xml", x,y ))
end

if count >= 3 then
	if not vomit then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/mutagens/mutagen_vomit.xml", x,y ))
	end
end

if count >= 4 then
	if not leggy then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/mutagens/mutagen_leggy.xml", x, y ))
	end
end

if count >= 6 then
	if not shaking then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/mutagens/mutagen_shaking.xml", x, y ))
	end
end

if count >= 7 then
	if not aiming then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/radioactive/mutagens/mutagen_aiming.xml", x, y ))
	end
end


 ]]
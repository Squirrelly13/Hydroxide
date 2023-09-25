local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

local children = EntityGetAllChildren(owner)

local count = 0
local leggy = false
local vomit = false
local aiming = false
local shaking = false
local icon = false

for i, child in ipairs(children) do

	local name = EntityGetName(child)
	
	if name == "radiationEffect" then
		count = count + 1
		
	elseif name == "radiationIcon" then
		icon = true
	
	elseif name == "mutagenLeggy" then
		leggy = true
		
	elseif name == "mutagenVomit" then
		vomit = true
		
	elseif name == "mutagenAiming" then
		aiming = true
		
	elseif name == "mutagenShaking" then
		shaking = true
	end
	
	
	
end

print("Radiation effect count: " .. count )

if not icon then
	EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/Chemical Curiosities/materials/radioactive/mutagens/mutagen_icon.xml", x,y ))
end

if count >= 3 then
	if not vomit then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/Chemical Curiosities/materials/radioactive/mutagens/mutagen_vomit.xml", x,y ))
	end
end

if count >= 4 then
	if not leggy then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/Chemical Curiosities/materials/radioactive/mutagens/mutagen_leggy.xml", x, y ))
	end
end

if count >= 6 then
	if not shaking then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/Chemical Curiosities/materials/radioactive/mutagens/mutagen_shaking.xml", x, y ))
	end
end

if count >= 7 then
	if not aiming then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/Chemical Curiosities/materials/radioactive/mutagens/mutagen_aiming.xml", x, y ))
	end
end



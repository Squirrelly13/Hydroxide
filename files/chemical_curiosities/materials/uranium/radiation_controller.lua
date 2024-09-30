local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)
local x,y = EntityGetTransform(owner)

local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end

--vars and trackers
local radcountcomp
local radstagecomp
local owner_children = EntityGetAllChildren(owner)

local vomit = false

local leggyamount = 0
local leggytracker
local leggyentity




local stage1 = 0
local stage2 = 100
local stage3 = 200
local stage4 = 300
local stage5 = 400
local stage6 = 500
local stage7 = 600
local stage8 = 700
local stage9 = 800
local stage10 = 900
local stage11 = 1000
local stage12 = 1100
local stage13 = 1200




for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then radcountcomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "radstage" then radstagecomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "leggytracker" then leggytracker = varcomp
	end
end

local radcount = ComponentGetValue2(radcountcomp, "value_int")
local stage = ComponentGetValue2(radstagecomp, "value_int")




--#region stage checks

if radcount >= stage1 then
	stage = 1
	vomit = true
end

local immunities = {}
if radcount >= stage2 then
	stage = 2
	
	if owner_children ~= nil then
		for k,v in ipairs(owner_children) do
			if EntityHasTag(v, "effect_protection") then 
				local key = ComponentGetValue2(EntityGetComponent(v, "GameEffectComponent")[1], "effect")
				--print("adding " .. key .. " to immunities table")
				immunities[key] = (immunities[key] or 0) + 1
			end
		end
	end
end


if radcount >= stage3 then
	stage = 3
	
end

if radcount >= stage4 then
	stage = 4
	
end

if radcount >= stage5 then
	stage = 5
	leggyamount = math.ceil((radcount - stage5) * .01)
end

if radcount >= stage6 then
	stage = 6
	
end

if radcount >= stage7 then
	stage = 7
	
end

if radcount >= stage8 then
	stage = 8
	
end

if radcount >= stage9 then
	stage = 9
	
end

if radcount >= stage10 then
	stage = 10
	
end

if radcount >= stage11 then
	stage = 11
	
end

if radcount >= stage12 then
	stage = 12
	
end

if radcount >= stage13 then
	stage = 13
	
end

--#endregion


local _vomit
if owner_children ~= nil then
	for k,v in ipairs(owner_children) do
		if EntityGetName(v) == "mutagenVomit" then _vomit = v end
	end
end

if vomit == true and _vomit == nil then
	EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_vomit.xml", x, y ))
end




if immunities ~= nil then
	for k,v in pairs(immunities) do
		print(k .. " = " .. v)
	end
end




leggyentity = ComponentGetValue2(leggytracker, "value_int")

if leggyentity ~= nil and EntityGetName(leggyentity) ~= "mutagenLeggy" then leggyentity = nil end --make sure the leggyentity is not only un-nil'd, but also the correct thing we're looking for

if leggyamount ~= 0 and leggyentity == nil then --if needs leggy but no leggy, create leggy
	print("creating new leggy mutagen")
	leggyentity = EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_leggy.xml", x, y )
	EntityAddChild( owner, leggyentity)
	if leggyentity ~= nil then ComponentSetValue2(leggytracker, "value_int", tonumber(leggyentity)) else print("failed to save leggyentity") end
end

local leggypermanent
if leggyentity then --if there is a leggy

	local leggyvarcomps = EntityGetComponent(leggyentity,"VariableStorageComponent") --check if leggy is permanent
	if leggyvarcomps ~= nil then leggypermanent = ComponentGetValue2(leggyvarcomps[1], "value_bool") end 
	leggypermanent = leggypermanent or false

	leggyentity = ComponentGetValue2(leggytracker, "value_int")
	if radcount < stage5 and leggypermanent == false then --if radcount is below stage5 and leggy is not permanent, no more leggy :(
		EntityKill(leggyentity)
	else  --else, do the logic managing leggy
		local leggylimbcomp = EntityGetComponent(leggyentity, "IKLimbComponent")
		if leggylimbcomp ~= nil then ComponentSetValue2(leggylimbcomp[1], "length", leggyamount*10) end
	end
end

if GameGetFrameNum() % 5 == 0 then print(radcount) end
dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)
local x,y = EntityGetTransform(owner)
local currentframe = GameGetFrameNum()

local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end







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



--vars and trackers
local radcountcomp
local radstagecomp
local perktracker
local leggytracker
local owner_children = EntityGetAllChildren(owner)

for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then radcountcomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "radstage" then radstagecomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "leggytracker" then leggytracker = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "leggytracker" then leggytracker = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "perktracker" then perktracker = varcomp
	end
end

local radcount = ComponentGetValue2(radcountcomp, "value_int")
local stage = ComponentGetValue2(radstagecomp, "value_int")




--#region stage checks

local vomit = false
if radcount >= stage1 then --vomit
	stage = 1
	vomit = true
end

local immunities = {}
if radcount >= stage2 then --immunities
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


if radcount >= stage3 then --radiation positioning + shader + maybe mana fluctuations?
	stage = 3
	
end

local deal_static = 0
if radcount >= stage4 then --damage that scales with radcount
	stage = 4
	deal_static = (radcount - stage4) * .002 -- divide by 20 so +5 damage every 100 rad, divide by a further 25 cuz of damage conversion
end

local leggyamount = 0
local leggyentity
if radcount >= stage5 then --leggy temp
	stage = 5
	leggyamount = math.ceil((radcount - stage5) * .01)
end

if radcount >= stage6 then --gain random perk
	stage = 6 --check if the countdown thingamabob
	if perktracker ~= nil and ComponentGetValue2(perktracker, "int_value") < currentframe then
		AddPerk()
		ComponentSetValue2(perktracker, "int_value", currentframe + 36000)
	end
end

function AddPerk(isMutant, count)
	isMutant = isMutant or false
	count = count or 1

	local perklist
	if isMutant then perklist = {} else perklist = {} end
	
	for i = 1, count, 1 do
		
	end
end


if radcount >= stage7 then --layers extra damage that scales with HP and radcount, + sounds
	stage = 7
	
end

if radcount >= stage8 then --leggy becomes permanent
	stage = 8
	
end

if radcount >= stage9 then --Static Damage starts being dealt faster
	stage = 9
	
end

if radcount >= stage10 then --start gaining goofy bootleg perks
	stage = 10
	
end

if radcount >= stage11 then --warning from the gods, shaders and sounds are intense
	stage = 11
	
end

if radcount >= stage12 then --both damages gets ridiculously high
	stage = 12
	
end

if radcount >= stage13 then --custom ascend script
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
dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/perk_compiler.lua")
dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/RAD_ENUMS.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)
local x,y = EntityGetTransform(owner)
local currentframe = GameGetFrameNum()

local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end



--vars and trackers
local radcountcomp
local radstagecomp
local perktracker
local leggytracker
local owner_children = EntityGetAllChildren(owner)
local owner_comps = EntityGetAllComponents(owner) or {}

local damage_model

for k, comp in ipairs(owner_comps) do
	if ComponentGetTypeName(comp) == "DamageModelComponent" then damage_model = comp end
end

for index, varcomp in ipairs(var_comps) do
	if ComponentGetValue2(varcomp, "name") == "radcount" then radcountcomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "radstage" then radstagecomp = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "leggytracker" then leggytracker = varcomp
    elseif ComponentGetValue2(varcomp, "name") == "perktracker" then perktracker = varcomp
	end
end

local radcount = ComponentGetValue2(radcountcomp, "value_int")
local stage = ComponentGetValue2(radstagecomp, "value_int")
local blessed = ComponentGetValue2(radcountcomp, "value_bool")



function AddPerk(isMutant, count)
	isMutant = isMutant or false
	count = count or 1

	local perklist
	if isMutant then perklist = MutantPerks else perklist = BonusPerks end
	
	for i = 1, count do
		
	end
end



--#region stage checks


local vomit = false
if radcount >= STAGE1 then --vomit
	stage = 1
	vomit = true
end


local immunities = {}
if radcount >= STAGE2 then --immunities
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

local radiation_positioning
if radcount >= STAGE3 then --radiation positioning + shader + maybe mana fluctuations?
	stage = 3
	radiation_positioning = true
end


local deal_static = 0
local deal_rate = 0
if radcount >= STAGE4 then --damage that scales with radcount
	stage = 4
	deal_static = (radcount - STAGE4) * .002 -- divide by 20 so +5 damage every 100 rad, divide by a further 25 cuz of damage conversion
	deal_rate = 90
end


local leggyamount = 0
local leggyentity
if radcount >= STAGE5 then --leggy temp
	stage = 5
	leggyamount = math.ceil((radcount - STAGE5) * .01)
end


if radcount >= STAGE6 then --gain random perk
	stage = 6 --check if the countdown thingamabob
	if perktracker ~= nil and ComponentGetValue2(perktracker, "int_value") < currentframe then
		AddPerk()
		ComponentSetValue2(perktracker, "int_value", currentframe + 36000)
	end
end


local deal_scaling = 0
if radcount >= STAGE7 then --layers extra damage that scales with HP and radcount, + sounds
	stage = 7
	deal_scaling = (radcount - STAGE7) * .01
end


if radcount >= STAGE8 then --leggy becomes permanent
	stage = 8
	
end


if radcount >= STAGE9 then --Static Damage starts being dealt faster, puke turns to radioactive waste
	stage = 9
	deal_static = ((radcount - STAGE9) * .05) + deal_static
	deal_rate = 40
end


if radcount >= STAGE10 then --start gaining goofy bootleg perks
	stage = 10
	
end


if radcount >= STAGE11 then --warning from the gods, shaders and sounds are intense
	stage = 11
	
end


if radcount >= STAGE12 then --both damages gets ridiculously high
	stage = 12
	
end


if radcount >= STAGE13 then --custom ascend script
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
		--print(k .. " = " .. v)
	end
end


if deal_rate > 0 and damage_model ~= nil then
	if GameGetFrameNum() % deal_rate then
		local max_hp = ComponentGetValue2(damage_model, "max_hp") or 0
		local total_damage = deal_static + ComponentGetValue2(damage_model, "max_hp") * (deal_scaling^1.3 + 1 - deal_scaling^1.2)
		EntityInflictDamage(owner, total_damage * .35, "DAMAGE_CURSE", "", "", x, y)
		EntityInflictDamage(owner, total_damage * .35, "DAMAGE_RADIOACTIVE", "", "", x, y)
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
	local leggylimbcomp = EntityGetComponent(leggyentity, "IKLimbComponent")
	if leggylimbcomp ~= nil then ComponentSetValue2(leggylimbcomp[1], "length", leggyamount * 15 + 15) end --start with a base of 30 reach and add 15 every 100 rad (leggyamount is divided by 100 and rounded up)
	
end

if GameGetFrameNum() % 5 == 0 then print(radcount) end
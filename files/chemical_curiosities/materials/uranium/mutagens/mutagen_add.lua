dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/perk_compiler.lua")
dofile_once("mods/Hydroxide/files/chemical_curiosities/materials/uranium/RAD_ENUMS.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetRootEntity(entity_id)
local x,y = EntityGetTransform(owner)
local currentframe = GameGetFrameNum()

local owner_children = EntityGetAllChildren(owner) or {}


----Get Radiation Controller stuff

local radiation_controller
local radcount

--vars and trackers
local radcountcomp
local radstagecomp
local radpostracker
local perktracker
local leggytracker
local owner_comps = EntityGetAllComponents(owner) or {}


for i, child in ipairs(owner_children) do --get radiation controller
	if EntityGetName(child) == "radiation_controller" then
		radiation_controller = child
		break --if it finds it, set it and break loop
	end
end

if radiation_controller == nil then --if it could not find it, create a new one
	radiation_controller = EntityAddChild(owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/radiation_controller.xml"))
	if radiation_controller == nil then return end --if it fucks up creating a new one, fuck man just give up at that point
end
 
local var_comps = EntityGetComponent(radiation_controller, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end --get varcomps. if none, give up

for index, varcomp in ipairs(var_comps) do --index varcomps to their designated variables
	local varcomp_name = ComponentGetValue2(varcomp, "name") --get varcomp name once before attemping to index

	if varcomp_name == "radcount" then
		radcount = ComponentGetValue2(varcomp, "value_int") + 10 --set radcount here too
		ComponentSetValue2(varcomp, "value_int", radcount)
    elseif varcomp_name == "radstage" then radstagecomp = varcomp
	elseif varcomp_name == "radpostracker" then radpostracker = varcomp
    elseif varcomp_name == "leggytracker" then leggytracker = varcomp
    elseif varcomp_name == "perktracker" then perktracker = varcomp
	end
end




local damage_model

for k, comp in ipairs(owner_comps) do
	if ComponentGetTypeName(comp) == "DamageModelComponent" then damage_model = comp end
end









--[[
local stage = ComponentGetValue2(radstagecomp, "value_int")
local blessed = ComponentGetValue2(radcountcomp, "value_bool")--]]


local function get_weighted_random(table)
    local total_weight = 0
    for i, v in ipairs(table) do
        total_weight = total_weight + v.probability
    end
    local rnd = Random(0, total_weight)
    for i, v in ipairs(table) do
        rnd = rnd - v.probability
        if rnd <= 0 then
            return v.perk
        end
    end
end






--#region stage checks
local stage

local vomit = false
if radcount >= STAGE1 then --vomit
	stage = 1
	vomit = true
end


local immunities = {}
local immunities_list = {}
if radcount >= STAGE2 then --immunities
	stage = 2
	
	if owner_children ~= nil then
		for k,v in ipairs(owner_children) do
			if EntityHasTag(v, "effect_protection") and EntityGetComponent(v, "GameEffectComponent") ~= nil then 
				local key = ComponentGetValue2(EntityGetComponent(v, "GameEffectComponent")[1], "effect")
				--print("adding " .. key .. " to immunities table")
				table.insert(immunities[key], v)
				immunities_list[key] = (immunities_list[key] or 0) + 1
			end
		end
	end
end

 
if radcount >= STAGE3 then --radiation positioning + shader + maybe mana fluctuations?
	stage = 3
	
	local positioning
	if owner_children ~= nil then
		for k,v in ipairs(owner_children) do
			if EntityGetName(v) == "mutagenPositioning" then positioning = v end
		end
	end

	if positioning == nil then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_shaking.xml", x, y ))
	end
end


local deal_static = 0
local deal_damage
if radcount >= STAGE4 then --damage that scales with radcount
	stage = 4
	deal_static = (radcount - STAGE4) * .001 -- divide by 20 so +2.5 damage every 100 rad, divide by a further 25 cuz of damage conversion
	deal_damage = true --90
end


local leggyamount = 0
local leggyentity
if radcount >= STAGE5 then --leggy temp
	stage = 5
	leggyamount = math.ceil((radcount - STAGE5) * .01)
end



function AddPerk(isMutant, count)
	isMutant = isMutant or false
	count = count or 1

	local perklist = isMutant and MutantPerks or BonusPerks
	
--[[
	local _test_perks = {}
	for i = 1, 100000 do
		local _perk = get_weighted_random(perklist)
		_test_perks[_perk] = (_test_perks[_perk] or 0) + 1
	end
	_test_perks["TOTAL"] = 100000
	_test_perks = sort_table(_test_perks)
	for k,v in ipairs(_test_perks) do
		print(v.key .. ": " .. v.value)
	end --]]
	

	for i = 1, count do
		local _perk = get_weighted_random(perklist)
		print("granting perk " .. _perk)
		perk_pickup( nil, owner, _perk, true, false, true )
	end
end

if radcount >= STAGE6 then --gain random perk
	stage = 6 --check if the countdown thingamabob
	if perktracker ~= nil then
		if ComponentGetValue2(perktracker, "value_int") < currentframe then
			AddPerk()
			ComponentSetValue2(perktracker, "value_int", currentframe + 36000)
			GamePrintImportant("Mutagen Upgrade", "Radiation gives you superpowers!")
		end
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
	deal_damage = true --40
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


--damage dealer
if deal_damage and damage_model ~= nil then
	local max_hp = ComponentGetValue2(damage_model, "max_hp") or 0
	local total_damage = deal_static + (ComponentGetValue2(damage_model, "max_hp") * ((deal_scaling^1.3 + 1 - deal_scaling^1.2) - 1))
	print("DEALRATE = " .. tostring(deal_damage))
	print("MAXHP = " .. max_hp)
	print("HP = " .. (ComponentGetValue2(damage_model, "hp") or 0))
	print("DEALSTATIC = " .. deal_static)
	print("DEALSCALED = " .. deal_scaling)
	print("TOTALDEAL = " .. total_damage)
	EntityInflictDamage(owner, total_damage * .3, "DAMAGE_CURSE", "Radiation", "NONE", x, y)
	EntityInflictDamage(owner, total_damage * .3, "DAMAGE_RADIOACTIVE", "Radiation", "NONE", x, y)
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

print(radcount)

if stage then
	local ui_comps = EntityGetComponent(radiation_controller, "UIIconComponent")
	if ui_comps ~= nil then
		local radstatus = ui_comps[1]
		ComponentSetValue2(radstatus, "name", GameTextGet("$statis_cc_radstage_" .. tostring(stage), radcount))
		ComponentSetValue2(radstatus, "description", GameTextGet("$statis_cc_desc_radstage_" .. tostring(stage), radcount))
		ComponentSetValue2(radstatus, "icon_sprite_file", "mods/Hydroxide/files/chemical_curiosities/materials/uranium/icons/icon_" .. stage .. ".png")
	end

	--[[
	if stage == 1 then

	elseif stage == 2 then

	elseif stage == 3 then

	elseif stage == 4 then

	elseif stage == 5 then

	elseif stage == 6 then

	elseif stage == 7 then

	elseif stage == 8 then

	elseif stage == 9 then

	elseif stage == 10 then

	elseif stage == 11 then

	elseif stage == 12 then

	else

	end
	--]]
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
	EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_icon.xml", x,y ))
end

if count >= 3 then
	if not vomit then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_vomit.xml", x,y ))
	end
end

if count >= 4 then
	if not leggy then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_leggy.xml", x, y ))
	end
end

if count >= 6 then
	if not shaking then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_shaking.xml", x, y ))
	end
end

if count >= 7 then
	if not aiming then
		EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_aiming.xml", x, y ))
	end
end


 ]]
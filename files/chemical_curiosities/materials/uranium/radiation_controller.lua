local entity_id = GetUpdatedEntityID()
local owner = EntityGetParent(entity_id)
local x,y = EntityGetTransform(owner)

local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent")
if var_comps == nil then print("no var_comps? :megamind:") return end

--vars and trackers
local radcountcomp
local radstagecomp


local vomit = false
local vomit_ = false

local leggy = 0
local leggytracker
local leggyentity




local stage1 = 15
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

if radcount >= stage1 then
	stage = 1
	vomit = true
end

if radcount >= stage2 then
	stage = 2
	
end

if radcount >= stage3 then
	stage = 3
	
end

if radcount >= stage4 then
	stage = 4
	
end

if radcount >= stage5 then
	stage = 5
	leggy = math.ceil((radcount - stage5) * .01)
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


if vomit == true and vomit_ == nil then
end

if leggy ~= 0 and not ComponentGetValue2(leggytracker, "value_int") > 0 then
	leggyentity = EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/chemical_curiosities/materials/uranium/mutagens/mutagen_leggy.xml", x, y ))
	ComponentSetValue2(leggytracker, "value_int", leggyentity)
end

if ComponentGetValue2(leggytracker, "value_int") > 0 then
	leggyentity = ComponentGetValue2(leggytracker, "value_int")
	if radcount < stage5 then
		EntityKill(leggyentity)
	else 
		local leggylimbcomps = EntityGetComponent(leggyentity, "IKLimbComponent")
		local leggylimbwalkercomps = EntityGetComponent(leggyentity, "IKLimbWalkerComponent")
	end
end

print(radcount)
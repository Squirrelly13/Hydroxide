local entity_id = GetUpdatedEntityID()
local total_shield

local varcomps = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for _, value in ipairs(varcomps) do
	local vcomp_name = ComponentGetValue2(value, "name")
	if vcomp_name == "shield_hp" then
		total_shield = ComponentGetValue2(value, "value_float")
	end
end
if GameGetFrameNum() % 60 == 0 then print("total shield is " .. tostring(total_shield)) end

local owner = EntityGetParent(entity_id)
local owner_is_player = EntityHasTag(owner, "player_unit")


SetRandomSeed(entity_id, total_shield)

local function shield_depleted()
	print("shield depleted")
	if owner_is_player then
		GamePrint("$cc_shield_depleted")
		--should have a slight shield-coloured vignette flash when the shield is broken
	end
	--gameplaysound some cool shield deactivation effect
	EntityKill(entity_id)
end

if total_shield == 0 then shield_depleted() return end



local dmc = EntityGetFirstComponent(owner, "DamageModelComponent")
if dmc == nil then return end

local owner_max_hp = ComponentGetValue2(dmc, "max_hp")



function damage_about_to_be_received(damage, x, y, source, crit)
	local new_damage = damage
	if damage > 0 then
		new_damage = math.max(damage - total_shield, 0)
		total_shield = math.max(total_shield - damage, 0)
	end

	if total_shield == 0 then shield_depleted() end
	return new_damage,crit
end



if not owner_is_player then return end


local gui = GuiCreate()

local curr_max_id = 0
local function create_id()
	curr_max_id = curr_max_id + 1
	return curr_max_id
end


GuiStartFrame(gui)

local magic_x = 599
local magic_y = 21

local hp_bar_width = math.max(math.min(40 * math.log((2.5 * owner_max_hp), 10), 80), 16) --thank you lamia
GuiZSetForNextWidget(gui, -100)
GuiImageNinePiece(gui, create_id(), magic_x - hp_bar_width, magic_y, hp_bar_width, 4, 1, "mods/Hydroxide/files/chemical_curiosities/shield/hp_bar_overlay.png")
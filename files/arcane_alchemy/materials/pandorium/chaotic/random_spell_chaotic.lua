dofile_once("data/scripts/lib/utilities.lua") --holy shit i dont need utilities lesgoooo
dofile_once("data/scripts/gun/gun_actions.lua") --i dont need this either oh my god (uncommented these tho since apparently they are only ever really run once and never again, even for duplicate entities)


-- this is mostly a mish-mash of code i built and copied using Anvil of Destiny, as well as looking at Copi's Things Turret Spell to get an initial idea on how this stuff works
-- once this works, it will be thanks to the work of Copi and Horscht, and the multiple people who are helping me on the noitacord while i stumble my way through LUA for the first time






local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity_id)

SetRandomSeed(GameGetFrameNum() + x, GameGetFrameNum() + y)
local seed_x = Randomf()*1000
local seed_y = Randomf()*1000 
--[[ print(Randomf()) --testing if this works
print(Randomf()) --testing if this works
print(Randomf()) --testing if this works
print(Randomf()) --testing if this works
print(Randomf()) --testing if this works
]]
--SetRandomSeed(seed_x, seed_y)


---- get wand entity ----

--[[ local gun = EZWand({
    shuffle = false,
    spellsPerCast = 1,
    castDelay = 100,
    rechargeTime = 100,
    manaMax = 1,
    mana = 1,
    manaChargeSpeed = 0,
    capacity = 20,
    spread = 360,
    speedMultiplier = 1
})

EntityAddChild(entity_id, gun) ]]



local inventory_comp = EntityGetAllChildren(entity_id)[1]

local gun = EntityGetAllChildren(inventory_comp)[1]


--[[ local gun1 = {
    deck_capacity = 20,
    actions_per_round = 1,
    reload_time = 10,
    shuffle_deck_when_empty = 0,
    fire_rate_wait = 10,
    spread_degrees = 360,
    speed_multiplier = 1,
    mana_charge_speed = 0,
    mana_max = 0,
    is_rare = 0
} ]]


---- add spells ----

spell_levels = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    10
} -- tier 7 is just touch-of spells, 8 and 9 do not exist.

local spell_formula = ""

function add_spell(spellType, position, tier)

    local spell_id = GetRandomActionWithType(seed_x + position, seed_y, tier, spellType)
    local spell = EntityCreateNew(spell_id)
    EntityAddChild(gun, spell)


    --EntityAddTag(spell, "card_action")

    EntityAddComponent(spell, "ItemActionComponent", {
        action_id = spell_id
    })

    local item_comp = EntityAddComponent(spell, "ItemComponent")
    ComponentSetValue2(item_comp, "inventory_slot", position, 1)

    --print(entity_id .. " HAS ADDED [" .. spell_id .. "] TO WAND AS TYPE " .. spellType .. " AT POSITION " .. position)
    spell_formula = spell_formula .. "," .. spell_id
    
end




for i=1, Random(5, 10) do
    add_spell(2, i, spell_levels[Random(1,#spell_levels)])
end

add_spell(0, 15, 1)


--[[comments
--gun:AddSpells(GetRandomActionWithType(seed_x, seed_y, spell_levels[Random(1,#spell_levels)], ACTION_TYPE_PROJECTILE))




--[[ 

-- Check if capacity is sufficient
local count = 0
for i, v in ipairs(spells) do
  count = count + v[2]
end
local spells_on_wand = self:GetSpells()
local positions = {}
for i, v in ipairs(spells_on_wand) do
  positions[v.inventory_x] = true
end

if not attach and #spells_on_wand + count > self.capacity then
  error(string.format("Wand capacity (%d/%d) cannot fit %d more spells. ", #spells_on_wand, self.capacity, count), 3)
end
local current_position = 0
for i,spell in ipairs(spells) do
  for i2=1, spell[2] do
    if not attach then
      local action_entity_id = CreateItemActionEntity(spell[1])
      EntityAddChild(self.entity_id, action_entity_id)
      EntitySetComponentsWithTagEnabled(action_entity_id, "enabled_in_world", false)
      local item_component = EntityGetFirstComponentIncludingDisabled(action_entity_id, "ItemComponent")
      while positions[current_position] do
        current_position = current_position + 1
      end
      positions[current_position] = true
      ComponentSetValue2(item_component, "inventory_slot", current_position, 0)
    else
      AddGunActionPermanent(self.entity_id, spell[1])
    end
  end
end
refresh_wand_if_in_inventory(self.entity_id)


function wand:GetSpells()
	local spells = {}
	local always_cast_spells = {}
	local children = EntityGetAllChildren(self.entity_id)
  if children == nil then
    return spells, always_cast_spells
  end
	for _, spell in ipairs(children) do
		local action_id = nil
		local permanent = false
    local item_action_component = EntityGetFirstComponentIncludingDisabled(spell, "ItemActionComponent")
    if item_action_component then
      action_id = ComponentGetValue2(item_action_component, "action_id")
    end
    local inventory_x, inventory_y = -1, -1
    local item_component = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
    if item_component then
      permanent = ComponentGetValue2(item_component, "permanently_attached")
      inventory_x, inventory_y = ComponentGetValue2(item_component, "inventory_slot")
    end
    if action_id then
			if permanent == true then
				table.insert(always_cast_spells, { action_id = action_id, entity_id = spell, inventory_x = inventory_x, inventory_y = inventory_y })
			else
				table.insert(spells, { action_id = action_id, entity_id = spell, inventory_x = inventory_x, inventory_y = inventory_y })
			end
		end
  end 


  --EntityAddComponent( entity_id:int, component_type_name:string, table_of_component_values:{string} = nil )

  --EntityAddComponent2( entity_id:int, component_type_name, table_of_component_values:{string-multiple_types} = nil )





--ACTION_TYPE_MODIFIER * 4-8
--ACTION_TYPE_PROJECTILE * 1

]]
---- set mana to combined spells mana cost * 1.5 ----

-- function action_get_by_id(action_id)
-- 	for i, action in ipairs(actions) do
-- 		if (action.id == action_id) then
-- 			return action
-- 		end
-- 	end
-- end

---- cast ----


print("\n PANDORIUM: [" .. entity_id .. "] IS CASTING FORMULA [" .. spell_formula .. "]")

local inventory2 = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
ComponentSetValue2(inventory2, "mForceRefresh", true)
ComponentSetValue2(inventory2, "mActualActiveItem", 0)


local platformShooterPlayer = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
ComponentSetValue2(platformShooterPlayer, "mForceFireOnNextUpdate", true)



--EntityKill(GetUpdatedEntityID())
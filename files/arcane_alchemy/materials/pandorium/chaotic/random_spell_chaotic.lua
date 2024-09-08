dofile_once("data/scripts/lib/utilities.lua") --holy shit i dont need utilities lesgoooo
--dofile_once("data/scripts/gun/gun_actions.lua") --i dont need this either oh my god (uncommented these tho since apparently they are only ever really run once and never again, even for duplicate entities)

-- this is mostly a mish-mash of code i built and copied using Anvil of Destiny, as well as looking at Copi's Things Turret Spell to get an initial idea on how this stuff works
-- once this works, it will be thanks to the work of Copi and Horscht, and the multiple people who are helping me on the noitacord while i stumble my way through LUA for the first time


local spell_table = dofile_once("mods/Hydroxide/files/arcane_alchemy/materials/pandorium/chaotic/spells_table_compiler.lua")

--print(spell_table.PROJECTILES[Random(1,#spell_table.PROJECTILES)])


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

    local spell_id = spell_table[spellType][Random(1,#spell_table[spellType])] --Nathan Seal of Unapproval
    --print(spell_id)
    local spell = EntityCreateNew(spell_id)
    EntityAddChild(gun, spell)


    --EntityAddTag(spell, "card_action")

    EntityAddComponent2(spell, "ItemActionComponent", {
        action_id = spell_id
    })

    local item_comp = EntityAddComponent2(spell, "ItemComponent")
    ComponentSetValue2(item_comp, "inventory_slot", position, 1)

    --print(entity_id .. " HAS ADDED [" .. spell_id .. "] TO WAND AS TYPE " .. spellType .. " AT POSITION " .. position)
    --spell_formula = spell_formula .. spell_id .. ","
    
end


for i=1, Random(5, 10) do
    add_spell("MODIFIERS", i, spell_levels[Random(1,#spell_levels)])
end

if Random() > .7 then add_spell("UTILITY", 14) end
add_spell("PROJECTILES", 15, 1)


--gun:AddSpells(GetRandomActionWithType(seed_x, seed_y, spell_levels[Random(1,#spell_levels)], ACTION_TYPE_PROJECTILE))



---- set mana to combined spells mana cost * 1.5 ----

-- function action_get_by_id(action_id)
-- 	for i, action in ipairs(actions) do
-- 		if (action.id == action_id) then
-- 			return action
-- 		end
-- 	end
-- end --gave up on this fn

---- cast ----


--print("\n PANDORIUM: [" .. entity_id .. "] IS CASTING FORMULA [" .. spell_formula .. "]")

local inventory2 = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
if not inventory2 then return end
ComponentSetValue2(inventory2, "mForceRefresh", true)
ComponentSetValue2(inventory2, "mActualActiveItem", 0)


local platformShooterPlayer = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
if not platformShooterPlayer then return end
ComponentSetValue2(platformShooterPlayer, "mForceFireOnNextUpdate", true)



--EntityKill(GetUpdatedEntityID())
dofile_once("data/scripts/lib/utilities.lua") --holy shit i dont need utilities lesgoooo
--dofile_once("data/scripts/gun/gun_actions.lua") --i dont need this either oh my god (uncommented these tho since apparently they are only ever really run once and never again, even for duplicate entities)

-- this is mostly a mish-mash of code i built and copied using Anvil of Destiny, as well as looking at Copi's Things Turret Spell to get an initial idea on how this stuff works
-- once this works, it will be thanks to the work of Copi and Horscht, and the multiple people who are helping me on the noitacord while i stumble my way through LUA for the first time


local spell_table = dofile_once("mods/Hydroxide/files/arcane_alchemy/materials/pandorium/chaotic/spells_table_compiler.lua")
--local data_table = spell_table.data

--print(spell_table.PROJECTILES[Random(1,#spell_table.PROJECTILES)])


local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform(entity_id)

SetRandomSeed(GameGetFrameNum() + x, GameGetFrameNum() + y)
local seed_x = Randomf()*1000
local seed_y = Randomf()*1000 



---- get wand entity ----

local inventory_comp = EntityGetAllChildren(entity_id)[1]

local gun = EntityGetAllChildren(inventory_comp)[1]



---- Build Wand ----

local spell_formula = ""

function add_spell(spellType, position)

    local spell_id = spell_table[spellType][Random(1,#spell_table[spellType])] --Nathan Seal of Unapproval
    local spell = EntityCreateNew()
    EntityAddChild(gun, spell)

    EntityAddComponent2(spell, "ItemActionComponent", {action_id = spell_id})

    local item_comp = EntityAddComponent2(spell, "ItemComponent")
    ComponentSetValue2(item_comp, "inventory_slot", position, 1)

    --print(entity_id .. " HAS ADDED [" .. spell_id .. "] TO WAND AS TYPE " .. spellType .. " AT POSITION " .. position)
    --spell_formula = spell_formula .. spell_id .. ","
end


for i=1, Random(3, 10) do --positions 1-10
    add_spell("MODIFIERS", i)
end

if Random() <= spell_table.data.gimmer_chance then add_spell("GLIMMERS", 13) add_spell("GLIMMERS", 29) end --positions 13 and 29
add_spell("PROJECTILES", 15) --position 15

for i=1, Random(4, 12) do --positions 16-27
    add_spell("MODIFIERS", i + 15)
end
add_spell("STATIC_PROJECTILES", 30) --position 30


---- Prepare and Cast Wand ----


--print("\n======= PANDORIUM: [" .. entity_id .. "] IS CASTING FORMULA [" .. spell_formula .. "]")


local inventory2 = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
if not inventory2 then return end
ComponentSetValue2(inventory2, "mForceRefresh", true)
ComponentSetValue2(inventory2, "mActualActiveItem", 0)


local platformShooterPlayer = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
if not platformShooterPlayer then return end
ComponentSetValue2(platformShooterPlayer, "mForceFireOnNextUpdate", true)
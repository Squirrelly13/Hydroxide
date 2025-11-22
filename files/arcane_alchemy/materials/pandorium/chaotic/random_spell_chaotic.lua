-- this is mostly a mish-mash of code i built and copied using Anvil of Destiny, as well as looking at Copi's Things Turret Spell to get an initial idea on how this stuff works
-- assuming this works, it is thanks to the work of Copi and Horscht, and the multiple other people who helped me on the noitacord while i stumble my way through LUA for the first time -K

if tonumber(GlobalsGetValue("AA_last_cpand_cast", "0")) == GameGetFrameNum() then return end
GlobalsSetValue("AA_last_cpand_cast", tostring(GameGetFrameNum())) --this should limit casts to one per frame

local spell_table = dofile_once("mods/Hydroxide/files/arcane_alchemy/materials/pandorium/chaotic/spells_table_compiler.lua")


local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
SetRandomSeed(GameGetFrameNum() + x, entity_id + y)


---- get wand entity ----

local inventory_comp = EntityGetAllChildren(entity_id)[1]
local gun = EntityGetAllChildren(inventory_comp)[1]


---- Build Wand ----

--local spell_formula = ""

local spell_position = 0
local function add_spell(spellType)
    spell_position = spell_position + 1

    local spell_id = spell_table[spellType][Random(1,#spell_table[spellType])] --Nathan Seal of Unapproval
    local spell = EntityCreateNew()
    EntityAddChild(gun, spell)

    EntityAddComponent2(spell, "ItemActionComponent", {action_id = spell_id})

    local item_comp = EntityAddComponent2(spell, "ItemComponent")
    ComponentSetValue2(item_comp, "inventory_slot", spell_position, 1)

    --print(entity_id .. " HAS ADDED [" .. spell_id .. "] TO WAND AS TYPE " .. spellType .. " AT POSITION " .. position)
    --spell_formula = spell_formula .. spell_id .. ","
end

local function add_cpand_modifier()
    spell_position = spell_position + 1

    local spell = EntityCreateNew()
    EntityAddChild(gun, spell)

    EntityAddComponent2(spell, "ItemActionComponent", {action_id = "AA_PANDORIUM_MODIFIER"})

    local item_comp = EntityAddComponent2(spell, "ItemComponent")
    ComponentSetValue2(item_comp, "inventory_slot", spell_position, 1)
end

local glimmer
if Random() <= spell_table.data.gimmer_chance then glimmer = true end

for _=1, Random(3, 9) do
    add_spell("MODIFIERS")
end

if glimmer then add_spell("GLIMMERS") end
add_cpand_modifier()
add_spell("PROJECTILES")

for _=1, Random(1, 10) do
    add_spell("MODIFIERS")
end
if glimmer then add_spell("GLIMMERS") end
add_cpand_modifier()
add_spell("STATIC_PROJECTILES")


---- Prepare and Cast Wand ----

--print("\n======= PANDORIUM: [" .. entity_id .. "] IS CASTING FORMULA [" .. spell_formula .. "]")

local inventory2 = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
if not inventory2 then return end
ComponentSetValue2(inventory2, "mForceRefresh", true) --refresh inventory stuff to apply changes properly i think
ComponentSetValue2(inventory2, "mActualActiveItem", 0) --make sure entity is holding the wand maybe?


local platformShooterPlayer = EntityGetFirstComponentIncludingDisabled(entity_id, "PlatformShooterPlayerComponent")
if not platformShooterPlayer then return end
ComponentSetValue2(platformShooterPlayer, "mForceFireOnNextUpdate", true) --force wand to fire next frame
-- ^ "mForceFireOnNextUpdate" used by Twitchy is the whole reason i can manually fire a wand without the player, everyone say "thank you Twitchy Mage"
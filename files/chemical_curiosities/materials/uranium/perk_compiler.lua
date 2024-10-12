dofile_once("data/scripts/perks/perk.lua")


local function AddTable(tableto, tablefrom)
	for i=1,#tablefrom do
		tableto[#tableto+1] = tablefrom[i]
	end
end

local function AddTable2(tableto, tablefrom)
	for k,v in pairs(tablefrom) do
		tableto[#tableto+1] = { probability = v, perk = k}
	end
end

BonusPerks = {
    --{ probability = 0, perk = "lmao"}
}

MutantPerks = {

}



local vanilla_bonuses = {
    ORBIT =                         15,
    ATTACK_FOOT =                   14,
    DUPLICATE_PROJECTILE =          14,
    INVISIBILITY =                  13,
    VAMPIRISM =                     13,
    RADAR_ENEMY =                   13,
    REVENGE_TENTACLE =              13,
    CONTACT_DAMAGE =                13,
    PERSONAL_LASER =                13,
    TELEKINESIS =                   12,
    SAVING_GRACE =                  12,
    TELEPORTITIS_DODGE =            12,
    REVENGE_RATS =                  12,
    REVENGE_BULLET =                12,
    ELECTRICITY =                   12,
    BREATH_UNDERWATER =             11,
    WAND_RADAR =                    11,
    REVENGE_EXPLOSION =             11,
    REMOVE_FOG_OF_WAR =             10,
    WORM_ATTRACTOR =                10,
    PROJECTILE_HOMING =             10,
    BLEED_SLIME =                   10,
    GLOBAL_GORE =                    9,
    RESPAWN =                        9,
    PROTECTION_ELECTRICITY =         9,
    FREEZE_FIELD =                   9,
    SHIELD =                         9,
    VOMIT_RATS =                     9,
    ALWAYS_CAST =                    9,
    STRONG_KICK =                    8,
    IRON_STOMACH =                   8,
    PROTECTION_EXPLOSION =           8,
    TELEPORTITIS =                   8,
    WAND_EXPERIMENTER =              8,
    FIRE_GAS =                       8,
    BLEED_GAS =                      8,
    PROJECTILE_REPULSION =           8,
    FUNGAL_DISEASE =                 8,
    BOUNCE =                         8,
    EXTRA_MANA =                     8,
    GAMBLE =                         8,
    MANA_FROM_KILLS =                8,
    FASTER_LEVITATION =              7,
    MOVEMENT_FASTER =                7,
    LEVITATION_TRAIL =               7,
    PROTECTION_RADIOACTIVITY =       7,
    PROJECTILE_HOMING_SHOOTER =      7,
    PLAGUE_RATS =                    7,
    MOLD =                           7,
    LOW_RECOIL =                     7,
    FAST_PROJECTILES =               7,
    NO_MORE_KNOCKBACK =              7,
    PERKS_LOTTERY =                  7,
    LOW_HP_DAMAGE_BOOST =            6,
    ITEM_RADAR =                     6,
    PROTECTION_MELEE =               6,
    ADVENTURER =                     6,
    BLEED_OIL =                      6,
    CORDYCEPS =                      6,
    PROJECTILE_REPULSION_SECTOR =    6,
    LUKKI_MINION =                   6,
    EXTRA_SLOTS =                    6,
    ANGRY_LEVITATION =               6,
    HOVER_BOOST =                    5,
    EXPLODING_CORPSES =              5,
    FOOD_CLOCK =                     5,
    PROJECTILE_SLOW_FIELD =          5,
    PROJECTILE_EATER_SECTOR =        5,
    ATTRACT_ITEMS =                  5,
    FASTER_WANDS =                   5,
    GENOME_MORE_HATRED =             5,
    GENOME_MORE_LOVE =               5,
    REPELLING_CAPE =                 4,
    EXTRA_HP =                       4,
    HEARTS_MORE_EXTRA_HP =           4,
    PROTECTION_FIRE =                4,
    STAINLESS_ARMOUR =               4,
    DISSOLVE_POWDERS =               4,
    LOWER_SPREAD =                   4,
    GLASS_CANNON =                   3,
    LEGGY_FEET =                     3,
    EDIT_WANDS_EVERYWHERE =          2,
    NO_WAND_EDITING =                1,
}

AddTable2(BonusPerks, vanilla_bonuses)

for index, value in pairs(BonusPerks) do
    --print("perk " .. value.perk .. " = " .. value.probability)
end
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")
local FF = ModSettingGet("Hydroxide.FF_ENABLED")
local Terror = ModSettingGet("Hydroxide.TERROR_ENABLED")


materials = {
	water = {
        probability = 0.8,
        variants = {
            "water_static",
            "water_salt",
            "water_ice",
            "water_swamp",
            "peat",
            "swamp",
        },
    },
	fungi = {
        probability = 0.6,
        variants = {
            "blood_fungi",
            "fungisoil",
        },
    },
	cc_nullium = {
        probability = 0.4,
        variants = {
            "cc_dull_fungus",
        },
    },
	blood = {
        probability = 1.0,
        variants = {
            "ice_blood_static",
            "blood_cold",
            "blood_worm",
        },
    },
	acid = {
        probability = 0.5,
        variants = {
            "ice_acid_static",
            "ice_acid_glass",
        },
    },
	cc_hydroxide = {
        probability = 0.5,
        variants = {
            "cc_ice_hydroxide_static",
            "cc_ice_hydroxide_glass",
        }
    },
	acid_gas = {
        probability = 0.6,
        variants = {
            "acid_gas_static",
            "cc_hydroxide_gas",
            "cc_methane"
        },
    },
    poison_gas = {
        probability = 0.6,
        variants = {
            "fungal_gas",
            "radioactive_gas",
            "radioactive_gas_static",
        },
    },
    poison = {
        probability = 0.9,
        variants = {
            ""
        },
    },
	magic_liquid_polymorph = {
        probability = 0.3,
        variants = {
            "magic_liquid_unstable_polymorph",
            "magic_liquid_random_polymorph"
        },
    },
	oil = {
        probability = 0.6,
    },
    magic_liquid_berserk = {
        probability = 0.6,
        variants = {
            "magic_liquid_charm",
            "magic_liquid_invisibility",
            "cc_veilium",
            "cc_explode_player",
        }
    },
    gold = {
        probability = 0.1,
        variants = {
            "gold_box2d",
        }
    },
    cursed_liquid = {
        probability = 0.8,
        condition = function(self)
            if GameHasFlagRun("greed_curse_gone") then self.probability = self.probability - 0.3 end
            if GameHasFlagRun("greed_curse") then return true end
        end
    },
}

for key, value in pairs(materials) do --ammends table with necessary data
    value.probability = value.probability or 1.0
    value.variants = value.variants or {}
end

if AA then
    table.insert(materials.oil.variants, "aa_oil_splitting")
    table.insert(materials.oil.variants, "aa_light_oil")
    table.insert(materials.oil.variants, "aa_heavy_oil")
end



if ModIsEnabled("grahamsperks") then
    table.insert(materials.magic_liquid_polymorph.variants, "graham_creepypoly")
end

if ModIsEnabled("apotheosis") then
    table.insert(materials.cursed_liquid.variants, "apotheosis_cursed_liquid_red_static")
    table.insert(materials.cursed_liquid.variants, "apotheosis_cursed_liquid_red")
    materials.cursed_liquid.condition = nil
    materials.cursed_liquid.probability = materials.cursed_liquid.probability - 0.2
end




local null_materials = {}

for key, value in pairs(materials) do
    table.insert(null_materials, value)
    null_materials[#null_materials].main_material = key
end

return null_materials
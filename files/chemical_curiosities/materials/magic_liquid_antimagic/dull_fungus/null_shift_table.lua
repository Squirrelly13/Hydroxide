local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")
local FF = ModSettingGet("Hydroxide.FF_ENABLED")
local Terror = ModSettingGet("Hydroxide.TERROR_ENABLED")


NullShift_materials = {
	water = {
		weight = 0.8,
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
		weight = 0.6,
		variants = {
			"blood_fungi",
			"fungisoil",
		},
	},
	cc_nullium = {
		weight = 0.4,
		variants = {
			"cc_dull_fungus",
		},
	},
	blood = {
		weight = 1.0,
		variants = {
			"ice_blood_static",
			"blood_cold",
			"blood_worm",
		},
	},
	acid = {
		weight = 0.5,
		variants = {
			"ice_acid_static",
			"ice_acid_glass",
		},
	},
	cc_hydroxide = {
		weight = 0.5,
		variants = {
			"cc_ice_hydroxide_static",
			"cc_ice_hydroxide_glass",
		}
	},
	acid_gas = {
		weight = 0.6,
		variants = {
			"acid_gas_static",
			"cc_hydroxide_gas",
			"cc_methane"
		},
	},
	poison_gas = {
		weight = 0.6,
		variants = {
			"fungal_gas",
			"radioactive_gas",
			"radioactive_gas_static",
		},
	},
	poison = {
		weight = 0.9,
		variants = {},
	},
	magic_liquid_polymorph = {
		weight = 0.3,
		variants = {
			"magic_liquid_unstable_polymorph",
			"magic_liquid_random_polymorph"
		},
	},
	oil = {
		weight = 0.6,
        variants = {}
	},
	magic_liquid_berserk = {
		weight = 0.6,
		variants = {
			"magic_liquid_charm",
			"cc_explode_player",
		}
	},
	gold = {
		weight = 0.02,
		variants = {}
	},
	cursed_liquid = {
		weight = 0.8,
        variants = {},
		condition = function(self, data)
			if GameHasFlagRun("greed_curse_gone") then self.weight = self.weight - 0.3 end
			if GameHasFlagRun("greed_curse") then return true end
		end
	},
	lava = {
		weight = 0.5,
		variants = {}
	},
	magic_liquid_teleportation = {
		weight = 0.1,
		variants = {
			"magic_liquid_unstable_teleportation"
		}
	}
}

if AA then
	table.insert(NullShift_materials.oil.variants, "aa_oil_splitting")
	table.insert(NullShift_materials.oil.variants, "aa_light_oil")
	table.insert(NullShift_materials.oil.variants, "aa_heavy_oil")
end




if ModIsEnabled("grahamsperks") then
	table.insert(NullShift_materials.magic_liquid_polymorph.variants, "graham_creepypoly")
	table.insert(NullShift_materials.magic_liquid_teleportation.variants, "graham_tele_chaotic")
end

if ModIsEnabled("Apotheosis") then --rework cursed liquid shift if apoth is enabled
	table.insert(NullShift_materials.cursed_liquid.variants, "apotheosis_cursed_liquid_red_static")
	table.insert(NullShift_materials.cursed_liquid.variants, "apotheosis_cursed_liquid_red")
	NullShift_materials.cursed_liquid.condition = nil
	NullShift_materials.cursed_liquid.weight = NullShift_materials.cursed_liquid.weight - 0.2
end

do_mod_appends("mods/Hydroxide/files/chemical_curiosities/materials/magic_liquid_antimagic/dull_fungus/null_shift_table.lua")

for key, value in pairs(NullShift_materials) do --ammends table with necessary data if missing
	value.weight = value.weight or 1.0
	value.variants = value.variants or {}
end


local null_materials = {}

for key, value in pairs(NullShift_materials) do
	table.insert(null_materials, value)
	null_materials[#null_materials].main_material = key
end

return null_materials
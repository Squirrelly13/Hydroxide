local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")

dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


--nvm not adding perks rn cuz apparently Curse of Greed isnt a real perk mb
local cc_perks = {
	{
		_disabled = true,
		id = "CC_GREATER_MATERIAL_CAPACITY",
		ui_name = "$cc_perk_greater_capacity",
		ui_description = "$cc_perkdesc_greater_capacity",
		ui_icon = "data/ui_gfx/perk_icons/extra_hp.png",
		perk_icon = "data/items_gfx/perks/extra_hp.png",
		stackable = true,
		func = function(perk, taker, perk_name, times_taken)
		end,
	},
	{
		id = "CC_CHAOTIC_TRANSFUSION",
		ui_name = "$perkname_cc_chaotic_transfusion",
		ui_description = "$perkdesc_cc_chaotic_transfusion",
		ui_icon = "data/ui_gfx/perk_icons/extra_hp.png",
		perk_icon = "data/items_gfx/perks/extra_hp.png",
		func = function()
			GameAddFlagRun("cc_chaotic_transfusion")
			local material_options = dofile_once("mods/Hydroxide/files/chemical_curiosities/chaotic_transfusion/materials.lua")
			for _,enemy in ipairs(EntityGetWithTag("enemy")) do
				local dmc = EntityGetFirstComponent(enemy, "DamageModelComponent")
				if not dmc then goto continue end
				if not ComponentGetValue2(dmc, "blood_material") == "blood" then goto continue end
				local x,y = EntityGetTransform(enemy)
				SetRandomSeed(x+434,y-1415)
				local option = RandomFromTable(material_options)
				ComponentSetValue2(dmc, "blood_material", option.material)
				ComponentSetValue2(dmc, "blood_spray_material", option.material)
				::continue::
			end
		end
	},
}

local aa_perks = {

}


for _, perk in ipairs(CC and cc_perks or {}) do
	perk_list[#perk_list+1] = perk
end

for _, perk in ipairs(AA and aa_perks or {}) do
	perk_list[#perk_list+1] = perk
end
local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")

dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


--nvm not adding perks rn cuz apparently Curse of Greed isnt a real perk mb
local cc_perks = {
    {
		id = "NLD_HP_ROULETTE",
		ui_name = "$nld_perk_hp_roulette",
		ui_description = "All players wager a portion of their Max Health and the winner is granted the bet three-times over",
		ui_icon = "data/ui_gfx/perk_icons/extra_hp.png",
		perk_icon = "data/items_gfx/perks/extra_hp.png",
		one_off_effect = true,
		do_not_remove = true,
		stackable = true,
		func = function(perk, taker, perk_name, times_taken)
		end,
    } or nil
}

local aa_perks = {

}


for _, perk in ipairs(CC and cc_perks or {}) do
    perk_list[#perk_list+1] = perk
end

for _, perk in ipairs(AA and aa_perks or {}) do
    perk_list[#perk_list+1] = perk
end
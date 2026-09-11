local CC = ModSettingGet("Hydroxide.CC_ENABLED")
local AA = ModSettingGet("Hydroxide.AA_ENABLED")
local MM = ModSettingGet("Hydroxide.MM_ENABLED")

local ip = ItemPedestalLib


local AA_items = {
	{
		origin = "$cc_branch_name_aa",
		id = "aa_vial",
		weight = 40,
		load_entity = "mods/Hydroxide/files/arcane_alchemy/items/vials/vial.xml",
		offset_x = nil, --(default: 0) x offset used for the load_entity method
		offset_y = -5,
		use_self = true,
		load_entity_func = nil,
		spawn_requires_flag = nil,
	},
}

local MM_items = {
	{
		origin = "$cc_branch_name_mm",
		id = "mm_catfood",
		weight = 0, --disabled for now, more interesting acquisition method should be subbed in, or have a condition attached
		load_entity = "mods/Hydroxide/files/mystical_mixtures/entities/catfood.xml",
		offset = -5
	}
}


if CC then
	ip.runestones[#ip.runestones+1] = "mods/Hydroxide/files/chemical_curiosities/items/runestone_crystal/runestone_crystal.xml"
end

if AA then
	for _,item in ipairs(AA_items) do
		ip.lists.default[#ip.lists.default+1] = item
	end
end

if MM then
	for _,item in ipairs(MM_items) do
		ip.lists.default[#ip.lists.default+1] = item
	end
end
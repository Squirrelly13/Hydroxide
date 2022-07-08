--[[
table.insert( actions,
{
	id          = "ALCHEMY_NERF_DARTS",
	name 		= "Nerf Darts",
	description = "A collection of nerf darts for shooting purposes.",
	sprite 		= "mods/Hydroxide/files/entities/nerf_gun/darts.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,3,4,5,6,7", 
	spawn_probability                 = "0,0,0,0,0,0,0,0",
	price = 200000000,
	mana = 0,
	max_uses = 20,
	action 		= function()
		add_projectile("mods/Hydroxide/files/entities/nerf_gun/nerf_dart.xml")
		c.speed_multiplier = 0.1
		c.screenshake = c.screenshake + 20.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10
	end,
});
]]--

table.insert( actions,
{
		id          = "METASTASIZIUM_TRAIL",
		name 		= "METASTASIZUM TRAIL",
		description = "$actiondesc_oil_trail",
		sprite 		= "data/ui_gfx/gun_actions/oil_trail.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/oil_trail_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4,5,6,7", 
		spawn_probability                 = "0,0,0,0,0,0,0,0",
		price = 160,
		mana = 10,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/oil_trail.xml",
		action 		= function()
			c.trail_material = c.trail_material .. "liquid_projectile_trail,"
			c.trail_material_amount = c.trail_material_amount + 20
			draw_actions( 1, true )
		end,
});
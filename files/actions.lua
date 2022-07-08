table.insert( actions,
{
	id          = "SEA_OF_METHANE",
	name 		= "Sea of Methane",
	description = "Summons a large body of methane gas",
	sprite 		= "mods/Hydroxide/files/actions/sea_methane.png",
	type 		= ACTION_TYPE_MATERIAL,
	spawn_level                       = "0,4,5,6", -- BERSERK_FIELD
	spawn_probability                 = "1,1,1,1", -- BERSERK_FIELD
	price = 350,
	mana = 140,
	max_uses = 3,
	action 		= function()
		add_projectile("mods/Hydroxide/files/actions/sea_methane.xml")
		c.fire_rate_wait = c.fire_rate_wait + 15
	end,
} );

table.insert( actions,
{
	id			= "WISPY_FLAME",
	name		= "Wispy Flame",
	description	= "Call forth tongues of flame",
	sprite		= "mods/Hydroxide/files/actions/wispy_flame.png",
	related_projectiles = {"mods/Hydroxide/files/actions/wispy_flame.xml"},
	type		= ACTION_TYPE_PROJECTILE,
	spawn_level						= "1,2,3,4,5,6,7",
	spawn_probability				= "1,1,1,1,1,1,1",
	price		= 200,
	mana		= 10,
	action		= function()
		add_projectile("mods/Hydroxide/files/actions/wispy_flame.xml")
		c.fire_rate_wait = c.fire_rate_wait + 10
	end,
} );
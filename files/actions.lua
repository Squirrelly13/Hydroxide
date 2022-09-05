table.insert( actions,
{
	id          = "SEA_OF_METHANE",
	name 		= "Sea of Methane",
	description = "Summons a large body of methane gas",
	sprite 		= "mods/Hydroxide/files/actions/sea_methane.png",
	type 		= ACTION_TYPE_MATERIAL,
	spawn_level                       = "0,4,5,6", 
	spawn_probability                 = "1,1,1,1",  
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
	spawn_probability				= "1,1,0,0,1,0,0",
	price		= 200,
	mana		= 10,
	action		= function()
		add_projectile("mods/Hydroxide/files/actions/wispy_flame.xml")
		c.fire_rate_wait = c.fire_rate_wait + 10
	end,
});

table.insert( actions,
{
	id			= "LOCAL_SHIFT",
	name		= "Local Shift",
	description	= "Change the world. But not everywhere...",
	sprite		= "mods/Hydroxide/files/actions/local_shift.png",
	related_projectiles = {"mods/Hydroxide/files/entities/projectiles/local_shift.xml"},
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "2,3,4,5,6", -- LOCAL_SHIFT
	spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- LOCAL_SHIFT
	price = 400,
	mana = 260,
	max_uses 	= 10,
	action		= function()
		add_projectile("mods/Hydroxide/files/entities/projectiles/local_shift.xml")
		c.fire_rate_wait    = c.fire_rate_wait + 0.7
        current_reload_time = current_reload_time + 1.0
	end,
});
dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)


local angle = math.rad(Random(70,110))
local speed = Random(5,15)

local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

local notes = {
	"data/entities/projectiles/deck/ocarina/ocarina_a.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_c.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_c.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_e.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_e.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml",
	"data/entities/projectiles/deck/ocarina/ocarina_a2.xml",
}

ShootProjectile(nil, notes[Random(1,#notes)], pos_x, pos_y, vel_x, vel_y)
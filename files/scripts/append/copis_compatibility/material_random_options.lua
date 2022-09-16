
dofile_once("data/scripts/lib/utilities.lua")
local entity = GetUpdatedEntityID();
local options =
{
	{ probability = 1.0000, "acid"},
	{ probability = 1.0000, "blood"},
	{ probability = 1.0000, "oil"},
	{ probability = 1.0000, "water"},
	{ probability = 1.0000, "blood"},
	{ probability = 0.6000, "silver"},
	{ probability = 0.4000, "magic_liquid_berserk"},
	{ probability = 0.4000, "magic_liquid_unstable_teleportation"},
	{ probability = 0.4000, "snow"},
	{ probability = 0.3000, "magic_liquid_polymorph"},
	{ probability = 0.3000, "magic_liquid_random_polymorph"},
	{ probability = 0.2000, "gunpowder_unstable_big"},
	{ probability = 0.2000, "purifying_powder"},
	{ probability = 0.1000, "urine"},
	{ probability = 0.1000, "pea_soup"},
	{ probability = 0.1000, "void_liquid"},
	{ probability = 0.1000, "magic_liquid_hp_regeneration"},
	{ probability = 0.1000, "cement"},
	{ probability = 0.0500, "gold"},
	{ probability = 0.0500, "poo"},
	{ probability = 0.0100, "midas_precursor"},
	{ probability = 0.0100, "magic_liquid_hp_regeneration_unstable"},
	
	{ probability = 1.0000, "hydroxide"},
	{ probability = 0.3000, "AA_MAT_REPULTIUM"},
	{ probability = 0.0020, "AA_UNSTABLE_LIQUID_SPELL"},
	{ probability = 0.2500, "sliceLiquid"},
	{ probability = 0.3000, "AA_LIQUID_ROCK"},
	{ probability = 0.3522, "AA_CLONE"},
	{ probability = 0.3522, "AA_GRAVLIQUID"},
	{ probability = 0.1500, "glitteringLiquid"},
	{ probability = 0.3000, "magic_liquid_movement_slower"},
	{ probability = 0.3000, "magic_liquid_slower_levitation"},
	{ probability = 0.2800, "magic_liquid_slower_levitation_and_movement"},
	{ probability = 0.0100, "metamorphine"},
	{ probability = 0.0020, "unstableMetamorphine"},
	{ probability = 0.5000, "explodePlayer"},
	{ probability = 0.2200, "antimagic"},
	{ probability = 0.7500, "grease"},
	{ probability = 0.0500, "antimatter_gas"},
	{ probability = 0.0500, "antimatter_liquid"},
	{ probability = 0.5000, "AA_ICEFIRE"},
	{ probability = 0.3500, "AA_MAT_ARBORIUM"},
	{ probability = 0.0850, "AA_MAT_HUNGRY_SLIME"},
	{ probability = 0.2000, "solidCrystal_molten"},
	{ probability = 0.1000, "uranium"},
	{ probability = 0.8000, "AA_MAT_NEUTRAL_POTION"},
	{ probability = 0.1000, "increaseMaxHP"},
	{ probability = 0.3000, "AA_MAT_COMPOST"},
	{ probability = 0.1000, "AA_MAT_BLOOM_MAGIC"},
	{ probability = 0.8000, "ferrineSkin"},
	
	{ probability = 0.0600, "wand_tinker"},
	{ probability = 0.2000, "sulphur"},
	{ probability = 0.0100, "devouringMoss"},
	{ probability = 0.2000, "blastPowder"},
	{ probability = 0.5000, "fireStarter"},
	{ probability = 0.0100, "alchemyPowder"},
	{ probability = 0.2000, "lightningPowder"},
	{ probability = 0.4000, "squirrellymorphine"},
	
	{ probability = 0.4000, "frozen_meat"},
	{ probability = 0.6000, "methane"},
	{ probability = 0.3000, "AA_MAT_POTION_GAS"},
	{ probability = 1.0000, "AA_MAT_SOOT"},
	
	{ probability = 0.8000, "iron"},
	{ probability = 0.8000, "cobalt"},
	{ probability = 0.8000, "brass"},
	{ probability = 0.8000, "preskite"},

}

local rnd = random_create(9123,58925+GameGetFrameNum() )
local mat = tostring(pick_random_from_table_weighted( rnd, options )[1])
local children = EntityGetAllChildren( entity ) or {};

for _,particle_emitter in pairs( EntityGetComponent( entity, "ParticleEmitterComponent" ) or {} ) do
    ComponentSetValue2(particle_emitter, "emitted_material_name", mat)
end
for _,material_spawner in pairs( EntityGetComponent( entity, "MaterialSeaSpawnerComponent" ) or {} ) do
    ComponentSetValue2(material_spawner, "material", CellFactory_GetType(mat))
end
for _,projectile in pairs( EntityGetComponent( entity, "ProjectileComponent" ) or {} ) do
    ComponentSetValue2(projectile, "on_death_emit_particle_type", mat)
    ComponentObjectSetValue2(projectile, "config_explosion", "create_cell_material", mat)
end
for _,magic_convert_material in pairs( EntityGetComponent( entity, "MagicConvertMaterialComponent" ) or {} ) do
    ComponentSetValue2(magic_convert_material, "to_material", CellFactory_GetType(mat))
end

for _,child in pairs(children) do
    for _,particle_emitter in pairs( EntityGetComponent( child, "ParticleEmitterComponent" ) or {} ) do
        ComponentSetValue2(particle_emitter, "emitted_material_name", mat)
    end
end


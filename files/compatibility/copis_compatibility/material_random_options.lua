
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
	
	{ probability = 1.0000, "CC_hydroxide"},
	{ probability = 0.3000, "AA_repultium"},
	{ probability = 0.0020, "AA_unstable_pandorium"},
	{ probability = 0.2500, "CC_slicing_liquid"},
	{ probability = 0.3000, "AA_pop_rocks"},
	{ probability = 0.3522, "AA_cloning_solution"},
	{ probability = 0.3522, "AA_condensed_gravity"},
	{ probability = 0.1500, "CC_glittering_liquid"},
	{ probability = 0.3000, "CC_deceleratium"},
	{ probability = 0.3000, "CC_heftium"},
	{ probability = 0.2800, "CC_stillium"},
	{ probability = 0.0100, "CC_metamorphine"},
	{ probability = 0.0020, "CC_unstable_metamorphine"},
	{ probability = 0.5000, "CC_agitine"},
	{ probability = 0.2200, "CC_nullium"},
	{ probability = 0.7500, "CC_grease"},
	{ probability = 0.0500, "CC_antimatter_gas"},
	{ probability = 0.0500, "CC_antimatter_liquid"},
	{ probability = 0.5000, "AA_icy_inferno"},
	{ probability = 0.3500, "AA_arborium"},
	{ probability = 0.0850, "AA_hungry_slime"},
	{ probability = 0.2000, "CC_dormant_crystal_molten"},
	{ probability = 0.1000, "CC_uranium"},
	{ probability = 0.8000, "AA_base_potion"},
	{ probability = 0.1000, "CC_health_tonic"},
	{ probability = 0.3000, "AA_compost"},
	--{ probability = 0.1000, "AA_BLOOM_MAGIC"},
	{ probability = 0.8000, "CC_persistine"},
	
	{ probability = 0.0600, "CC_liberum_magicas"},
	{ probability = 0.2000, "sulphur"},
	{ probability = 0.0100, "CC_devouring_moss"},
	{ probability = 0.2000, "CC_blasting_powder"},
	{ probability = 0.5000, "CC_kindling"},
	{ probability = 0.0100, "CC_alchemy_powder"},
	{ probability = 0.2000, "CC_thunder_powder"},
	{ probability = 0.4000, "CC_morphine"},
	
	{ probability = 0.4000, "CC_frozen_meat"},
	{ probability = 0.6000, "CC_methane"},
	{ probability = 0.3000, "AA_potion_gas"},
	{ probability = 1.0000, "AA_soot"},
	
	{ probability = 0.8000, "CC_iron"},
	{ probability = 0.8000, "CC_cobalt"},
	{ probability = 0.8000, "brass"},
	{ probability = 0.8000, "CC_preskite"},

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


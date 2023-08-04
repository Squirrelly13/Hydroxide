table.insert(materials_standard, {
	material="sulphur",
	cost=175,
});

table.insert(materials_magic, {
	material="devouringMoss",
	cost=2200,
});

table.insert(materials_magic, {
	material="blastPowder",
	cost=750,
});

table.insert(materials_magic, {
	material="fireStarter",
	cost=700,
});

table.insert(materials_magic, {
	materials="alchemyPowder",
	cost=3500,
});

table.insert(materials_magic, {
	materials="lightningPowder",
	cost=800,
});

table.insert(materials_magic, {
	materials="squirrellymorphine",
	cost=800,
});


function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "sand"

	if( Random( 0, 100 ) <= 75 ) then
		-- 0.05% chance of magic_liquid_
		potion_material = random_from_array( materials_magic )
		potion_material = potion_material.material
	else
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
			
		if ( comp ~= nil ) then
			ComponentSetValue( comp, "barrel_size", total_capacity )
		end
		
		EntityAddTag( entity_id, "extra_potion_capacity" )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end
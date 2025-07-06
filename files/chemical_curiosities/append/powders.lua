---@diagnostic disable: undefined-global
table.insert(materials_standard, {
	material="sulphur",
	cost=175,
});

table.insert(materials_magic, {
	material="cc_devouring_moss",
	cost=2200,
});

table.insert(materials_magic, {
	material="cc_blasting_powder",
	cost=750,
});

table.insert(materials_magic, {
	material="cc_kindling",
	cost=700,
});

table.insert(materials_magic, {
	material="cc_alchemy_powder",
	cost=3500,
});

table.insert(materials_magic, {
	material="cc_thunder_powder",
	cost=800,
});

table.insert(materials_magic, {
	material="cc_morphine",
	cost=800,
});

table.insert(materials_magic, {
	material="cc_antimatter_powder",
	cost=600,
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
		print()
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )

		if ( comp ~= nil ) then
			ComponentSetValue2( comp, "barrel_size", total_capacity )
		end

		EntityAddTag( entity_id, "extra_potion_capacity" )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end
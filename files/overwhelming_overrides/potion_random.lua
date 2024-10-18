local old_init = init
init = function( entity_id )
    local x, y = EntityGetTransform( entity_id )
    SetRandomSeed( x, y )
    roll_number = Random(1,100 * 1000) / 1000
    possible_rolls = {}
    for k, v in pairs(materials_magic)do ---@diagnostic disable-line: undefined-global
        if(v.percentage ~= nil)then
            if(roll_number < v.percentage)then
                table.insert(possible_rolls, v)
            end
        end
    end
    if(#possible_rolls == 0)then
        old_init(entity_id)
    else
        potion_material = random_from_array( possible_rolls)
        potion_material = potion_material.material

		-- debug
		--potion_material = "aa_unstable_pandorium"

        local components = EntityGetComponent( entity_id, "VariableStorageComponent" )
    
        if( components ~= nil ) then
            for key,comp_id in pairs(components) do 
                local var_name = ComponentGetValue2( comp_id, "name" )
                if( var_name == "potion_material") then
                    potion_material = ComponentGetValue2( comp_id, "value_string" )
                end
            end
        end
        
        local year,month,day = GameGetDateAndTimeLocal()
        
        if ((( month == 5 ) and ( day == 1 )) or (( month == 4 ) and ( day == 30 ))) and (Random( 0, 100 ) <= 20) then
            potion_material = "sima"
        end
    
        local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
        if ( total_capacity > 1000 ) then
            local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
                
            if ( comp ~= nil ) then
                ComponentSetValue2( comp, "barrel_size", total_capacity )
            end
            
            EntityAddTag( entity_id, "extra_potion_capacity" )
        end

		if(potion_material == "aa_pandorium" or potion_material == "aa_unstable_pandorium")then
			comp1 = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" )
					
			if ( comp1 ~= nil ) then
				ComponentSetValue2( comp1, "hp", 1)
			end

			comp2 = EntityGetFirstComponentIncludingDisabled( entity_id, "ExplodeOnDamageComponent" )
					
			if ( comp2 ~= nil ) then
				ComponentSetValue2( comp2, "physics_body_destruction_required", 80)
			end
			
			comp3 = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialInventoryComponent" )

			if ( comp3 ~= nil ) then
				ComponentSetValue2(comp3, "leak_on_damage_percent", 0)

			end

			comp4 = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyCollisionDamageComponent" )

			if ( comp4 ~= nil ) then
				ComponentSetValue2(comp4, "damage_multiplier", 0)
			end
		end
		
        AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
    end
end
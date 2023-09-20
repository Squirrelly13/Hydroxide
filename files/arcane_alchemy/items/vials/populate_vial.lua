materials = {
    {
        material="oil",
        percentage=100
    }
}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "water"


    potion_roll = Random( 0, 100 )

    allowed_picks = {}

    for k, v in pairs(materials)do
       -- print("huh?")
        if(v.percentage ~= nil)then
           -- print("wab")
            if(potion_roll <= v.percentage)then
               -- print("Add that shizzle")
                table.insert(allowed_picks, v.material)
            end
        end
    end

	if( allowed_picks[1] ~= nil ) then
        potion_material = allowed_picks[Random(1, #allowed_picks)]
        print("Loaded: "..potion_material)
    else
        potion_material = materials[Random(1, #materials)].material
	end


	-- load the material from VariableStorageComponent
	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )

	if( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue( comp_id, "name" )
			if( var_name == "potion_material") then
				potion_material = ComponentGetValue( comp_id, "value_string" )
			end
		end
	end


	AddMaterialInventoryMaterial( entity_id, potion_material, 200 )
end
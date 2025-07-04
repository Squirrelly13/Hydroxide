materials = {
    {
        material="aa_base_potion",
        weight=1,
    },
    {
        material="aa_arborium",
        weight=.7,
    },
    {
        material="aa_catalyst",
        weight=.5,
    },
    {
        material="aa_hungry_slime",
        weight=1,
    },
    {
        material="aa_creeping_slime",
        weight=.4,
    },
    {
        material="aa_pandorium",
        weight=.8,
    },
    {
        material="aa_unstable_pandorium",
        weight=.3,
    },
    {
        material="aa_chaotic_pandorium",
        weight=.5,
    },
    {
        material="aa_cloning_solution",
        weight=.6,
    },
}

--[[ FULL TABLE INCLUDING CC AND MM BRANCHES

    AA:
        material="aa_base_potion",
        weight=1,
        
        material="aa_arborium",
        weight=.7,
        
        material="aa_catalyst",
        weight=.5,
        
        material="aa_hungry_slime",
        weight=1,
        
        material="aa_creeping_slime",
        weight=.4,
        
        material="aa_pandorium",
        weight=.8,
        
        material="aa_unstable_pandorium",
        weight=.3,
        
        material="aa_chaotic_pandorium",
        weight=.5,
        
        material="aa_cloning_solution",
        weight=.6,


    CC:
        material="cc_unstable_metamorphine",
        weight=0.6,

        material="cc_explodePlayer",
        weight=1,

        material="cc_metastasizium",
        weight=.4,

        material="cc_nullium",
        weight=1,

        material="cc_health_tonic",
        weight=.05,

        material="cc_antimatter_liquid",
        weight=.2,
    
        
    MM:
        material="mm_bingus",
        weight=0.6,

        material="mm_alchemical_solvent",
        weight=1,
    
        material="mm_alchemical_base",
        weight=1,

]]




function get_weighted_random(table)
    local total_weight = 0
    for i, v in ipairs(table) do
        total_weight = total_weight + v.weight
    end
    local rnd = Random(0, total_weight)
    for i, v in ipairs(table) do
        rnd = rnd - v.weight
        if rnd <= 0 then
            return v.material
        end
    end
end

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed

    local potion_material = get_weighted_random(materials)

	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )

	if( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue2( comp_id, "name" )
			if( var_name == "potion_material") then
				potion_material = ComponentGetValue2( comp_id, "value_string" )
			end
		end
	end

    AddMaterialInventoryMaterial( entity_id, potion_material, 200 )


end



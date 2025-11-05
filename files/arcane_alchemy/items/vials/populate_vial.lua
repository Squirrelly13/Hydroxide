dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

PrefabVials = {}

VialMaterials = {
    {
        material="aa_base_potion",
        probability=1,
    },
    {
        material="aa_arborium",
        probability=.7,
    },
    {
        material="aa_catalyst",
        probability=.5,
    },
    {
        material="aa_hungry_slime",
        probability=1,
    },
    {
        material="aa_creeping_slime",
        probability=.4,
    },
    {
        material="aa_pandorium",
        probability=.8,
    },
    {
        material="aa_unstable_pandorium",
        probability=.3,
    },
    {
        material="aa_chaotic_pandorium",
        probability=.5,
    },
    {
        material="aa_cloning_solution",
        probability=.6,
    },
}


function init(entity_id)
	local x,y = EntityGetTransform(entity_id)
	SetRandomSeed(x-418, y+22) -- so that all the potions will be the same in every position with the same seed

    local material
    local amount = 200
    local target

	local varcomps = EntityGetComponent( entity_id, "VariableStorageComponent" )
	if( varcomps ~= nil ) then
		for key,comp_id in ipairs(varcomps) do
			local var_name = ComponentGetValue2( comp_id, "name" )
			if( var_name == "potion_material") then
				local vstring = ComponentGetValue2( comp_id, "value_string" )
                if PrefabVials[vstring] then target = PrefabVials[vstring]
                else
                    material = vstring
                    amount = ComponentGetValue2(comp_id, "value_int") or amount
                end
			end
		end
	end

    if not material then
        target = target or RandomFromTable(VialMaterials)
        if target.func then if target:func(entity_id, {amount = amount}) then return end end
        material = target.material
        amount = target.amount or amount
    end

    AddMaterialInventoryMaterial(entity_id, material, amount)
end
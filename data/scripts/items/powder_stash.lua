PowderStashLib = {}
local ps = PowderStashLib

ps.default_material = "sand"

--t should be the table with probability values
function random_from_weighted_table(t)
	if #t == 0 then return nil end

	local weight_sum = 0.0
	for _,it in ipairs(t) do
		it.weight_min = weight_sum
		it.weight_max = weight_sum + it.probability
		weight_sum = it.weight_max
	end

	local val = Randomf(0.0, weight_sum)
	local result = t[1]
	for _,it in ipairs(t) do
		if val >= it.weight_min and val <= it.weight_max then
			result = it
			break
		end
	end

	return result
end

ps.pre_funcs = {}
ps.post_funcs = {}


--Standard materials, 25/101 chance for this pool to be drawn
ps.materials_standard =
{
	{
		material="sand",
		cost = 300,
        probability = 10,
	},
	{
		material="soil",
		cost = 200,
        probability = 10,
	},
	{
		material="snow",
		cost = 200,
        probability = 10,
	},
	{
		material="salt",
		cost = 200,
        probability = 10,
	},
	{
		material="coal",
		cost = 200,
        probability = 10,
	},
	{
		material="gunpowder",
		cost = 200,
        probability = 10,
	},
	{
		material="fungisoil",
		cost = 200,
        probability = 10,
	},
}
materials_standard = {} --so mods not using this lib dont break

--Magic materials, 76/101 chance for this pool to be drawn
ps.materials_magic =
{
	{
		material="copper",
		cost = 500,
        probability = 10,
	},
	{
		material="silver",
		cost = 500,
        probability = 10,
	},
	{
		material="gold",
		cost = 500,
        probability = 10,
	},
	{
		material="brass",
		cost = 500,
        probability = 10,
	},
	{
		material="bone",
		cost = 800,
        probability = 10,
	},
	{
		material="purifying_powder",
		cost = 800,
        probability = 10,
	},
	{
		material="fungi",
		cost = 800,
        probability = 10,
	},
}
materials_magic = {}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed

    for _, value in ipairs(materials_magic) do --account for mods not using this lib
        ps.materials_magic[#ps.materials_magic+1] = value
    end
    for _, value in ipairs(materials_standard) do
        ps.materials_standard[#ps.materials_standard+1] = value
    end

    for index, value in ipairs(ps.materials_magic) do --make sure probability fields are real
        value.probability = value.probability or 10
    end
    for index, value in ipairs(ps.materials_standard) do
        value.probability = value.probability or 10
    end

	local potion_material = ps.default_material
    local potion_data

    for _, value in ipairs(ps.pre_funcs) do value() end

	if( Random( 0, 100 ) <= 75 ) then --76/101 chance for magic pool
		potion_data = random_from_weighted_table(ps.materials_magic) or {}
		potion_material = potion_data.material
        if potion_data.func then potion_data.func() end
	else --25/101 chance for standard pool
		potion_data = random_from_weighted_table(ps.materials_standard) or {}
		potion_material = potion_data.material
        if potion_data.func then potion_data.func() end
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

    for _, value in ipairs(ps.post_funcs) do value() end
    if potion_data.post_func then potion_data.post_func() end
end
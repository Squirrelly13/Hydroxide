PowderStashLib = {}
local ps = PowderStashLib

--use this to store general script data
ps.data = {
    material = "sand", --default material is sand
    material_data = {is_default = true}, --has property is_default for debugging reasons
    amount = 1000, --this will always be 1000 in vanilla gameplay, but pouch code had this so might as well support it
}
local data = ps.data --do this to make stuff more readable


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

ps.pre_funcs = {} --runs after RandomSeed is set, before old tables are merged and material is chosen
ps.funcs = { --regular funcs here is vaguely redundant cuz post_funcs runs very soon after it, but i wanted function calls before and after the pouch material was filled sooo
    {
        origin = "vanilla", --optional
        id = "vanilla_potion_capacity_function", --optional, sorry the func tables are nested like this purely for this, i just think its convenient to be able to identify functions like this and store data
        func = function()
            data.amount = tonumber(GlobalsGetValue("EXTRA_POTION_CAPACITY_LEVEL", "1000"))
            if ( data.amount > 1000 ) then
                local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )

                if ( comp ~= nil ) then
                    ComponentSetValue(comp, "barrel_size", data.amount)
                end

                EntityAddTag( entity_id, "extra_potion_capacity" )
            end
        end,
    }
}
ps.post_funcs = {}


--Standard materials, 25/101 chance for this pool to be drawn
ps.materials_standard =
{
    {
        material="sand",
        cost = 300,
        probability = 10,
        origin = "vanilla", --optional datapoint, just potentially convenient
    },
    {
        material="soil",
        cost = 200,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="snow",
        cost = 200,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="salt",
        cost = 200,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="coal",
        cost = 200,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="gunpowder",
        cost = 200,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="fungisoil",
        cost = 200,
        probability = 10,
        origin = "vanilla",
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
        origin = "vanilla",
    },
    {
        material="silver",
        cost = 500,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="gold",
        cost = 500,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="brass",
        cost = 500,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="bone",
        cost = 800,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="purifying_powder",
        cost = 800,
        probability = 10,
        origin = "vanilla",
    },
    {
        material="fungi",
        cost = 800,
        probability = 10,
        origin = "vanilla",
    },
}
materials_magic = {}



function init( entity_id )
    local x,y = EntityGetTransform( entity_id )
    SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed

    for _, value in ipairs(ps.pre_funcs) do value.func() end --pre-init function hook

    for _, value in ipairs(materials_magic) do --account for mods not using this lib
        ps.materials_magic[#ps.materials_magic+1] = value
    end
    for _, value in ipairs(materials_standard) do
        ps.materials_standard[#ps.materials_standard+1] = value
    end

    for index, value in ipairs(ps.materials_magic) do --make sure probability fields are real
        value.probability = value.probability or 10 --default to 10 probability
    end
    for index, value in ipairs(ps.materials_standard) do
        value.probability = value.probability or 10 --default to 10 probability
    end

    if( Random( 0, 100 ) <= 75 ) then --76/101 chance for magic pool
        data.material_data = random_from_weighted_table(ps.materials_magic) or {}
        data.material = data.material_data.material
        if data.material_data.func then data.material_data.func() end --custom function hook
    else --25/101 chance for standard pool
        data.material_data = random_from_weighted_table(ps.materials_standard) or {}
        data.material = data.material_data.material
        if data.material_data.func then data.material_data.func() end --custom function hook
    end

    for _, value in ipairs(ps.funcs) do value.func() end

    AddMaterialInventoryMaterial( data.entity_id or entity_id, data.material, data.amount )

    if data.material_data.post_func then data.material_data.post_func() end
    for _, value in ipairs(ps.post_funcs) do value.func() end
end
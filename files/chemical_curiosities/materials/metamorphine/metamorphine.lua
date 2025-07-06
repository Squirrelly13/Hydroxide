dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local convertcomponents = EntityGetComponent( entity_id, "MagicConvertMaterialComponent" )

SetRandomSeed( pos_x + 436, pos_y - 3252 )
local material_options = {
	"water",
	"oil",
	"lava",
	"acid",
	"radioactive_liquid",
	"slime",
	"sand",
	"alcohol",
	"blood",
	"snow",
	"blood_worm",
	"blood_fungi",
	"burning_powder",
	"honey",
	"fungi",
	"aa_rice" }
local material_options_rare = {
	"acid",
	"magic_liquid_teleportation",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_invisibility",
	"diamond",
	"plasma_fading",
	"cc_veilium",
	"cc_methane",
	"cc_sparkling_liquid",
	"cc_slicing_liquid",
	"cc_glittering_liquid",
	"cc_blasting_powder", "aa_arborium", "aa_pop_rocks", "aa_potion_gas", "cc_kindling", "brass", "silver", "shock_powder" }
local rare = false

local rnd = Random( 1, 100 )

if ( rnd > 98 ) then
	rare = true
end

local material_string = "water"

if (rare == false) then
	rnd = Random( 1, #material_options )
	material = material_options[rnd]
else
	rnd = Random( 1, #material_options_rare )
	material = material_options_rare[rnd]
end
	
material = CellFactory_GetType( material )

if ( convertcomponents ~= nil ) then
	for key,comp_id in pairs(convertcomponents) do
		local name = tonumber( ComponentGetValue2( comp_id, "from_material" ) )
		--local smoke_id = CellFactory_GetType( "smoke" )
		
		if (material == name) then
			--ComponentSetValue( comp_id, "to_material", smoke_id )
		else
			ComponentSetValue2( comp_id, "to_material", material )
		end
	end
end


edit_component( entity_id, "LuaComponent", function(comp,vars)
	EntitySetComponentIsEnabled( entity_id, comp, false )
end)

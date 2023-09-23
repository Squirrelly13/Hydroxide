dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local convertcomponents = EntityGetComponent( entity_id, "MagicConvertMaterialComponent" )

SetRandomSeed( pos_x + 436, pos_y - 3252 )
local material_options = { "blastPowder", "fireStarter", "lightningPowder", "lightningPowder", "blastPowder"}
local material_options_rare = { "explodePlayer", "glitteringLiquid" }
local rare = false

local rnd = Random( 1, 100 )

if ( rnd > 66 ) then
	rare = true
end

local material_string = "gunpowder"

if (rare == false) then
	rnd = Random( 1, #material_options )
	material = material_options[rnd]
else
	rnd = Random( 1, #material_options_rare )
	material = material_options_rare[rnd]
end
	
material = CellFactory_GetType( material )
local sulphur = CellFactory_GetType( "sulphur" ) 

if ( convertcomponents ~= nil ) then
	for key,comp_id in pairs(convertcomponents) do 
		local name = tonumber( ComponentGetValue( comp_id, "from_material" ) )
		--local smoke_id = CellFactory_GetType( "smoke" 
		
		
		local to = tonumber( ComponentGetValue( comp_id, "to_material" ) )
		if to ~= sulphur then
			
			if (material == name) then
				--ComponentSetValue( comp_id, "to_material", smoke_id )
			else
				ComponentSetValue( comp_id, "to_material", material )
			end
		end
		
	end
end

edit_component( entity_id, "LuaComponent", function(comp,vars)
	EntitySetComponentIsEnabled( entity_id, comp, false )
end)
dofile( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	local x, y = EntityGetTransform( entity_item )

	local has_increased_ammo = false
	if(entity_who_picked ~= nil)then
	
		local inventory = nil

		local player_child_entities = EntityGetAllChildren( entity_who_picked )
		if ( player_child_entities ~= nil ) then
			for i,child_entity in ipairs( player_child_entities ) do
				local child_entity_name = EntityGetName( child_entity )
				
				if ( child_entity_name == "inventory_quick" ) then
					inventory = child_entity
				end
			end
		end

		if ( inventory ~= nil ) then
			local inventory_items = EntityGetAllChildren( inventory )

			if inventory_items ~= nil then
				for i,wand in ipairs( inventory_items ) do

					if(wand ~= 0)then

						local children = EntityGetAllChildren( wand );
						if(children ~= nil)then
							for i,v in ipairs( children ) do
								--print(v)
								local action_component = EntityGetComponentIncludingDisabled( v, "ItemActionComponent" )[1];
								if(action_component ~= nil)then
									local action_id = ComponentGetValue2(action_component, "action_id")
								  --  print(action_id)
									if(action_id == "ALCHEMY_NERF_DARTS")then
										local item_component = EntityGetComponentIncludingDisabled( v, "ItemComponent")[1];
										
										if(item_component ~= nil)then
											local uses_remaining = ComponentGetValue2(item_component, "uses_remaining")
											if(uses_remaining < 20)then
												uses_remaining = uses_remaining + 1
												EntityKill( entity_item )
												ComponentSetValue2(item_component, "uses_remaining", uses_remaining)
												local inventory2_comp = EntityGetFirstComponent( entity_who_picked, "Inventory2Component" )
												if( inventory2_comp ) then
													ComponentSetValue( inventory2_comp, "mActualActiveItem", "0" )
												end
												break
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end	
	end
	
	--[[local inventory = nil

	local player_child_entities = EntityGetAllChildren( entity_who_picked )
	if ( player_child_entities ~= nil ) then
		for i,child_entity in ipairs( player_child_entities ) do
			local child_entity_name = EntityGetName( child_entity )
			
			if ( child_entity_name == "inventory_quick" ) then
				inventory = child_entity
			end
		end
	end

	if ( inventory ~= nil ) then
		local inventory_items = EntityGetAllChildren( inventory )

		if inventory_items ~= nil then
			for i,item_entity in ipairs( inventory_items ) do
				local child_items = EntityGetAllChildren( item_entity )
				
				

				for i,child_entity in ipairs( child_items ) do

					SpellComponents = EntityGetAllComponents(child_entity)
					for i,component in ipairs(SpellComponents) do
						if(ComponentGetTypeName(component) == "ItemActionComponent")then
							ItemActionComponent = component

							if(ItemActionComponent ~= nil)then
								local ItemActionComponent = ItemActionComponent
								local action_id = ComponentGetValue(ItemActionComponent, "action_id")
								if ( action_id == "NERF_DARTS") then
									for i,component2 in ipairs(SpellComponents) do
										local ItemComponent = EntityGetFirstComponent(child_entity, "ItemComponent")
										if(ItemComponent ~= nil)then
											local uses_remaining = ComponentGetValue2(ItemComponent, "uses_remaining")
											uses_remaining = uses_remaining + 1
											
											ComponentSetValue2(ItemComponent, "uses_remaining", uses_remaining)
											local inventory2_comp = EntityGetFirstComponent( entity_who_picked, "Inventory2Component" )
											if( inventory2_comp ) then
												ComponentSetValue( inventory2_comp, "mActualActiveItem", "0" )
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end		]]
	EntityKill( entity_item )
	
end

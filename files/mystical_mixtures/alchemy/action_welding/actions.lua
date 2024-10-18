local handler = dofile("mods/Hydroxide/files/mystical_mixtures/alchemy/action_welding/welding_handler.lua")

for k, action in ipairs(actions)do
	local old_action = action.action
	action.action = function(recursion_level, iteration, a, b, c, d, e, f, g, called_from_weld)

		if(reflecting or called_from_weld or (recursion_level ~= nil and recursion_level > -1))then
			return old_action(recursion_level, iteration)
		end
		local data = handler.hook(action.id, recursion_level, iteration)

		if(data == nil)then
			return old_action(recursion_level, iteration)
		end

		if(data.extra_mana > 0)then
			if(mana - data.extra_mana < 0)then
				OnNotEnoughManaForAction()
				return nil
			else
				mana = mana - data.extra_mana
			end
		end


		local enhancement_old_add_projectile = add_projectile
			
		local enhancement_old_add_projectile_trigger_timer = add_projectile_trigger_timer
	
		local enhancement_old_add_projectile_trigger_hit_world = add_projectile_trigger_hit_world
	
		local enhancement_old_add_projectile_trigger_death = add_projectile_trigger_death

		local trigger_count = 0 + #data.timer + #data.hit_world + #data.death

		add_projectile = function( entity_filename )
			if(trigger_count > 0)then
				for k, v in ipairs(data.timer)do
					enhancement_old_add_projectile_trigger_timer(entity_filename, v.delay_frames, v.action_draw_count)
				end
				for k, v in ipairs(data.hit_world)do
					enhancement_old_add_projectile_trigger_hit_world(entity_filename, v.action_draw_count)
				end
				for k, v in ipairs(data.death)do
					enhancement_old_add_projectile_trigger_death(entity_filename, v.action_draw_count)
				end
			else
				enhancement_old_add_projectile(entity_filename)
			end
		end
		
		add_projectile_trigger_timer = function( entity_filename, delay_frames, action_draw_count )
			if(trigger_count > 0)then
				for k, v in ipairs(data.timer)do
					enhancement_old_add_projectile_trigger_timer(entity_filename, v.delay_frames, v.action_draw_count)
				end
				for k, v in ipairs(data.hit_world)do
					enhancement_old_add_projectile_trigger_hit_world(entity_filename, v.action_draw_count)
				end
				for k, v in ipairs(data.death)do
					enhancement_old_add_projectile_trigger_death(entity_filename, v.action_draw_count)
				end
			else
				enhancement_old_add_projectile_trigger_timer(entity_filename, delay_frames, action_draw_count)
			end
		end
		
		add_projectile_trigger_hit_world = function( entity_filename, action_draw_count )
			if(trigger_count > 0)then
				for k, v in ipairs(data.timer)do
					enhancement_old_add_projectile_trigger_timer(entity_filename, v.delay_frames, v.action_draw_count)
				end
				for k, v in ipairs(data.hit_world)do
					enhancement_old_add_projectile_trigger_hit_world(entity_filename, v.action_draw_count)
				end
				for k, v in ipairs(data.death)do
					enhancement_old_add_projectile_trigger_death(entity_filename, v.action_draw_count)
				end
			else
				enhancement_old_add_projectile_trigger_hit_world(entity_filename, action_draw_count)
			end
		end
		
		add_projectile_trigger_death = function( entity_filename, action_draw_count )
			if(trigger_count > 0)then
				for k, v in ipairs(data.timer)do
					enhancement_old_add_projectile_trigger_timer(entity_filename, v.delay_frames, v.action_draw_count)
				end
				for k, v in ipairs(data.hit_world)do
					enhancement_old_add_projectile_trigger_hit_world(entity_filename, v.action_draw_count)
				end
				for k, v in ipairs(data.death)do
					enhancement_old_add_projectile_trigger_death(entity_filename, v.action_draw_count)
				end
			else
				enhancement_old_add_projectile_trigger_death(entity_filename, action_draw_count)
			end
		end

		local return_value = old_action(recursion_level, iteration)	

		add_projectile = enhancement_old_add_projectile
		add_projectile_trigger_timer = enhancement_old_add_projectile_trigger_timer
		add_projectile_trigger_hit_world = enhancement_old_add_projectile_trigger_hit_world
		add_projectile_trigger_death = enhancement_old_add_projectile_trigger_death

		return return_value
	end
end
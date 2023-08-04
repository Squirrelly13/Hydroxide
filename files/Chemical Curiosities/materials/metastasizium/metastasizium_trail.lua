function shot(projectile_id)
    EntityAddComponent2(projectile_id, "ParticleEmitterComponent", 
        { 
            emitted_material_name = "liquid_projectile_trail",
            render_on_grid = true,
            create_real_particles = true,
            x_pos_offset_min=-5,
            x_pos_offset_max=5,
            count_min = 14,
            count_max = 22,
            emission_interval_min_frames = 1,
            emission_interval_max_frames = 1,
            is_emitting = true,
        }
    )
end

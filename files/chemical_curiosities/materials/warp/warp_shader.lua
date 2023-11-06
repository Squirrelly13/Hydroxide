local postfx = dofile("mods/Hydroxide/lib/shader_utilities.lua")

postfx.append([[
uniform vec4 cc_warp_multiplier;    
]], "uniform vec4 brightness_contrast_gamma;")

postfx.prepend([[
// ============================================================================================================
// warp effect======================================================================================

// create warp effect around center of screen based on multiplier
// when the multiplier is 0, there should be no warping
// when the multiplier is higher it should warp more
// think of the warp as a fisheye effect
float cc_warp_effect_multiplier = cc_warp_multiplier.x;

// Calculate the distance from the center
vec2 cc_warp_center = vec2(0.5); // assuming the center is at (0.5, 0.5)
vec2 cc_warp_direction = tex_coord - cc_warp_center;

// Get the length of the direction vector
float cc_warp_len = length(cc_warp_direction);

// Normalize the direction
vec2 cc_warp_norm_direction = normalize(cc_warp_direction);

// Apply the warp effect
vec2 cc_final_warp_direction = cc_warp_norm_direction * cc_warp_len / (1.0 + (cc_warp_effect_multiplier) * cc_warp_len);

// Get the new texture coordinate
tex_coord = cc_warp_center + (cc_final_warp_direction);
]], [[// sample the original color =================================================================================]])

postfx.prepend([[  
    vec2 cc_warp_triplevision_offset = vec2(min(0.03,0.005 * cos(time*0.5)  * (cc_warp_effect_multiplier / 10.0)),min(0.03, 0.005 * sin(time*0.5) * (cc_warp_effect_multiplier / 10.0) ));
    vec4 cc_warp_offset_texture_1_fg = texture2D(tex_fg, tex_coord + cc_warp_triplevision_offset );
    vec4 cc_warp_offset_texture_2_fg = texture2D(tex_fg, tex_coord - cc_warp_triplevision_offset );
    vec4 cc_warp_offset_texture_1_bg = texture2D(tex_bg, tex_coord + cc_warp_triplevision_offset );
    vec4 cc_warp_offset_texture_2_bg = texture2D(tex_bg, tex_coord - cc_warp_triplevision_offset );
    color_fg = mix( color_fg, cc_warp_offset_texture_1_fg, min(0.5, cc_warp_effect_multiplier) );
    color_fg = mix( color_fg, cc_warp_offset_texture_2_fg, min(0.5, cc_warp_effect_multiplier) );
    color = mix( color, cc_warp_offset_texture_1_bg.rgb, min(0.5, cc_warp_effect_multiplier) );
    color = mix( color, cc_warp_offset_texture_2_bg.rgb, min(0.5, cc_warp_effect_multiplier) );
    
]], [[	vec3 color_orig    = color;]])

postfx.append([[
	// oversaturate the screen based on warp_effect_multiplier
	// when the multiplier is 0, there should be no oversaturation
	// when the multiplier is higher it should oversaturate more
	vec3 cc_warp_weights_ = vec3(0.2125, 0.7154, 0.0721); // sums to 1
	float cc_warp_luminance_ = dot(gl_FragColor.rgb, cc_warp_weights_);
	gl_FragColor = mix(vec4(cc_warp_luminance_), gl_FragColor, vec4((cc_warp_effect_multiplier / 10.0) + 1.0));
    //gl_FragColor.rgb = gl_FragColor.rgb * max(cc_warp_effect_multiplier * 5.0, 1.0);
]], [[	gl_FragColor.rgb  = color;]])
local postfx = dofile("mods/Hydroxide/lib/shader_utilities.lua")

postfx.append([[
uniform vec4 warp_multiplier;    
]], "uniform vec4 brightness_contrast_gamma;")

postfx.prepend([[
// ============================================================================================================
// warp effect======================================================================================

// create warp effect around center of screen based on multiplier
// when the multiplier is 0, there should be no warping
// when the multiplier is higher it should warp more
// think of the warp as a fisheye effect
float warp_effect_multiplier = warp_multiplier.x;

// Calculate the distance from the center
vec2 center = vec2(0.5); // assuming the center is at (0.5, 0.5)
vec2 direction = tex_coord - center;

// Get the length of the direction vector
float len = length(direction);

// Normalize the direction
vec2 norm_direction = normalize(direction);

// Apply the warp effect
vec2 warp_direction = norm_direction * len / (1.0 + (warp_effect_multiplier) * len);

// Get the new texture coordinate
tex_coord = center + (warp_direction);
]], [[// sample the original color =================================================================================]])

postfx.prepend([[  
    vec2 triplevision_offset = vec2(min(0.03,0.005 * cos(time*0.5)  * (warp_effect_multiplier / 10.0)),min(0.03, 0.005 * sin(time*0.5) * (warp_effect_multiplier / 10.0) ));
    vec4 offset_texture_1_fg = texture2D(tex_fg, tex_coord + triplevision_offset );
    vec4 offset_texture_2_fg = texture2D(tex_fg, tex_coord - triplevision_offset );
    vec4 offset_texture_1_bg = texture2D(tex_bg, tex_coord + triplevision_offset );
    vec4 offset_texture_2_bg = texture2D(tex_bg, tex_coord - triplevision_offset );
    color_fg = mix( color_fg, offset_texture_1_fg, min(0.5, warp_effect_multiplier) );
    color_fg = mix( color_fg, offset_texture_2_fg, min(0.5, warp_effect_multiplier) );
    color = mix( color, offset_texture_1_bg.rgb, min(0.5, warp_effect_multiplier) );
    color = mix( color, offset_texture_2_bg.rgb, min(0.5, warp_effect_multiplier) );
    
]], [[	vec3 color_orig    = color;]])

postfx.append([[
	// oversaturate the screen based on warp_effect_multiplier
	// when the multiplier is 0, there should be no oversaturation
	// when the multiplier is higher it should oversaturate more
	vec3 weights_ = vec3(0.2125, 0.7154, 0.0721); // sums to 1
	float luminance_ = dot(gl_FragColor.rgb, weights_);
	gl_FragColor = mix(vec4(luminance_), gl_FragColor, vec4((warp_effect_multiplier / 10.0) + 1.0));
    //gl_FragColor.rgb = gl_FragColor.rgb * max(warp_effect_multiplier * 5.0, 1.0);
]], [[	gl_FragColor.rgb  = color;]])
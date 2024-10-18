local postfx = dofile("mods/Hydroxide/lib/shader_utilities.lua")
--uniform vec4 brightness_contrast_gamma;

postfx.append([[
uniform vec4 grayscale;    
]], "uniform vec4 brightness_contrast_gamma;")

postfx.prepend([[
// ============================================================================================================
// methane colorblindness======================================================================================

{
    
    color = mix(color, vec3(dot(color,vec3(.2126, .7152, .0722))), grayscale.a );
}
]], [[// various debug visualizations================================================================================]])
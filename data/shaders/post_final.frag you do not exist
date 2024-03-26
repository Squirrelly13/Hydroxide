// Sample texture
vec3 testColor = texture2D(tex_fg, tex_coord_).rgb;

// Test if color is a specific color
if( testColor == vec3(38.0/255.0, 42.0/255.0, 44.0/255.0) ){
    // Do funky stuff
    gl_FragColor = vec4(vec3(mod(time/2.0, 0.5)),1.0);
}
precision mediump float;       	// Set the default precision to medium. We don't need as high of a
// precision in the fragment shader.
//uniform vec3 u_LightPos;       	// The position of the light in eye space.
uniform sampler2D u_Texture;

uniform int u_Interweave;

varying vec2 v_TexCoordinate;   // Interpolated texture coordinate per fragment.

// The entry point for our fragment shader.
void main()
{
    vec2 coord = v_TexCoordinate;
    if (u_Interweave == 1)
    {
        float idx = floor(gl_FragCoord.x);
        float factor = mod(idx, 2.0);
        coord.x = (factor == 1.0 ? 0.5 * v_TexCoordinate.x : 0.5 * v_TexCoordinate.x + 0.5);
        
    }
    else if (u_Interweave == 2)
    {
        coord.x = coord.x * 0.5;
    }
    gl_FragColor =  texture2D(u_Texture, coord);
}


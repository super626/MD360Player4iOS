precision mediump float;
uniform lowp sampler2D u_TextureX;
uniform lowp sampler2D u_TextureY;
uniform lowp sampler2D u_TextureZ;
uniform mat3 u_ColorConversion;
varying vec2 v_TexCoordinate;

uniform int u_Interweave;

void main()
{
    mediump vec3 yuv;
    lowp    vec3 rgb;
    
    vec2 coord = v_TexCoordinate;
    if (u_Interweave == 1)
    {
        float idx = floor(gl_FragCoord.x);
        float factor = mod(idx, 2.0);
        coord.x = (factor == 1.0 ? 0.5 * v_TexCoordinate.x : 0.5 * v_TexCoordinate.x + 0.5);
    }
    
    yuv.x = (texture2D(u_TextureX, coord).r - (16.0 / 255.0));
    yuv.y = (texture2D(u_TextureY, coord).r - 0.5);
    yuv.z = (texture2D(u_TextureZ, coord).r - 0.5);
    rgb = u_ColorConversion * yuv;
    gl_FragColor = vec4(rgb, 1);
}

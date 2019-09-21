uniform sampler2D tex;
uniform float custom_alpha;

in vec2 uv;
out vec4 FragColor;

void main()
{
    FragColor = texture(tex, uv) * custom_alpha;
}
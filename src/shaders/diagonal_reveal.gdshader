shader_type canvas_item;

void fragment() {
	COLOR.rgb = texture(TEXTURE, UV).rgb;
	COLOR.a = step(UV.x + UV.y, 2.0 * sin(TIME)) * texture(TEXTURE, UV).a;
}

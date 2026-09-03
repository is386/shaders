shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0) = 0.5;
uniform float width : hint_range(0.0, 1.0) = 0.5;

uniform vec2 highlight_center;
uniform float highlight_strength : hint_range(0.0, 1.0) = 1.0;
uniform float glow : hint_range(0.0, 1.0) = 1.0;

uniform vec3 main_color : source_color;
uniform vec3 highlight_color : source_color;

uniform sampler2D noise : repeat_enable;

void fragment() {
	float circle = step(distance(UV, vec2(0.5)), radius);
	float inner_circle = smoothstep(width * 0.5, 1, distance(UV, vec2(0.5)));
	float main_shape = circle * inner_circle;

	float highlight_shape =
		main_shape * highlight_strength * pow(1.0 - distance(highlight_center, UV), 3.0);

	vec3 color = main_color * main_shape + highlight_shape * highlight_color;
	color *= vec3(1.0 + glow * 5.0);

	float texture_alpha = texture(noise, UV + vec2(TIME * 0.1, 0)).r;

	COLOR.a = (main_shape + highlight_shape) * texture_alpha;
	COLOR.rgb = color;
}

void vertex() {
	VERTEX += VERTEX * sin(TIME) * 0.1;
}

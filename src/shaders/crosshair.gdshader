shader_type canvas_item;

uniform float center_size : hint_range(0.0, 0.1) = 0.1;
uniform float circle_size : hint_range(0.0, 0.5) = 0.5;
uniform float circle_thickness : hint_range(0.0, 0.5) = 0.5;
uniform float circle_gap : hint_range(0.0, 0.1) = 0.1;

uniform float line_distance : hint_range(0.0, 1.0) = 0.25;
uniform float line_length : hint_range(0.0, 1.0) = 0.25;
uniform float line_thickness : hint_range(0.0, 1.0) = 0.5;

float create_circles(vec2 uv) {
	float center_circle = step(distance(uv, vec2(0.5)), center_size);
	float outer_circle = step(distance(uv, vec2(0.5)), circle_size);
	float inner_circle = step(distance(uv, vec2(0.5)), circle_size - circle_thickness);

	float gap_x = step(distance(uv.x, 0.5), circle_gap);
	float gap_y = step(distance(uv.y, 0.5), circle_gap);

	return center_circle + max(outer_circle - inner_circle - gap_x - gap_y, 0);
}

float create_lines(vec2 uv) {
	vec2 center_distance = vec2(0.5) + line_distance;
	float h_width = step(distance(uv.x, center_distance.x), line_length * 0.25) +
					step(distance(1.0 - uv.x, center_distance.x), line_length * 0.25);
	float h_height = step(distance(uv.y, 0.5), line_thickness * 0.02);
	float w_width = step(distance(uv.y, center_distance.y), line_length * 0.25) +
					step(distance(1.0 - uv.y, center_distance.y), line_length * 0.25);
	float w_height = step(distance(uv.x, 0.5), line_thickness * 0.02);
	return h_width * h_height + w_width * w_height;
}

void fragment() {
	COLOR.rgb = vec3(1);
	COLOR.a = create_circles(UV) + create_lines(UV);
}

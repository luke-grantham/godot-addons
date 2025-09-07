shader_type canvas_item;

uniform float alpha;

void fragment() {
	COLOR = vec4(vec3(0.0),alpha);
}
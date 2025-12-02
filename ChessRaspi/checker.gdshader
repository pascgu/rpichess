shader_type spatial;
render_mode world_vertex_coords, unshaded;

global uniform vec4 palette_white : source_color;
global uniform vec4 palette_black : source_color;

varying vec3 pos;

void vertex() {
	pos = VERTEX - (NORMAL * 0.1);
}

void fragment() {
	if ((int(floor(pos.x) + floor(pos.z)) % 2 == 0))
		ALBEDO = palette_black.rgb;
	else
		ALBEDO = palette_white.rgb;
	//ALBEDO = vec3(1,0,0);
}

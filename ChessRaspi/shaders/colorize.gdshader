shader_type spatial;
render_mode unshaded;

global uniform vec4 palette_white;
global uniform vec4 palette_black;

uniform sampler2D sprite;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 a = texture(sprite, UV);
	if (a.r > 0.5)
		ALBEDO = palette_white.rgb;
	else
		ALBEDO = palette_black.rgb;
	ALPHA = a.a;
}
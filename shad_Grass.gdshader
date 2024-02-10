shader_type spatial;
render_mode diffuse_toon, specular_disabled, cull_disabled;

uniform vec3 colorHigh: source_color = vec3(0.2, 0.6, 0.2); //color of higher part of grass
uniform vec3 colorLow: source_color = vec3(0.1, 0.4, 0.1); //color of lower part of grass

uniform bool enableSwing = true; //enable or disable swing
uniform float swingLength: hint_range(0.05, 1) = 0.1; //how much should grass swing 
uniform float swingSpeed: hint_range(1, 10, 0.01) = 1; //how fast should grass swing
uniform vec3 swingDirection = vec3(1, 0, 1); //in what direction grass should be swinging

void vertex() {
	if (enableSwing) { //if swing animation is enabled
		vec3 clampDirection = clamp(swingDirection, 0, 1); //clamp direction between 0 and 1
		VERTEX += (sin(TIME * swingSpeed) * swingLength * VERTEX.y) * clampDirection; //swing animation only for upper part of grass
	}
}

void fragment() {
	ALBEDO = mix(colorHigh, colorLow, UV.y); //sets color to grass
}


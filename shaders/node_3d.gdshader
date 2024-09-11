shader_type spatial;

void vertex() {
	float animation_offset = (cos(TIME * 4.5)) * 0.002 - 0.005;
	
    VERTEX = VERTEX + vec3(animation_offset, 0.0, 0.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

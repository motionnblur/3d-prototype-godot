shader_type spatial;

void vertex() {
	float animation_offset = (cos(TIME * 4.5) + 1.1) * 0.2;

    // Apply position offset
    VERTEX = VERTEX + vec3(0.0, 0.0, animation_offset);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

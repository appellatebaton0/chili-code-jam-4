shader_type canvas_item;

uniform float threshold = 0.5;
uniform float intensity = 1.0;

void fragment() {
	
	COLOR.a = (UV.y * intensity) + threshold;
	
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

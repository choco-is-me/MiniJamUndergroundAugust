/// Create
// Movement variables
direction = 0; // Will be set by the fly when created

// Visual variables
sprite_index = spr_fly_bullet;
image_speed = 0; // Single frame
depth = -85; // Appear in front of flies but behind player

// Spinning variables
spin_speed = 0; // Degrees per step (can be positive or negative)
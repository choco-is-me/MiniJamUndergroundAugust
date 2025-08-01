/// Create
// General variables
state = "Idle";  // Initial state
hp = 2;          // Health points
max_hp = 2;
facing = 1;      // 1 = right, -1 = left
depth = -90;     // Appear behind player but above most objects

// Movement variables
fly_speed = 0.5;    // Base movement speed
vsp = 0;            // Vertical speed
hsp = 0;            // Horizontal speed
move_timer = 0;     // Timer for movement decisions
move_interval = 60; // How often to change movement direction (60 steps = 1 second)
move_direction = irandom(359); // Random initial direction

// Boundary variables
origin_x = x;
origin_y = y;
fly_range = 125;  // Max distance from origin point
return_speed = 1.2;  // Speed when returning to origin (slightly faster than normal movement)

// Attack variables
attack_range = 150;  // Distance to detect player
attack_cooldown = 0;
attack_cooldown_max = 90; // Time between shots (1.5 seconds)
bullet_speed = 1;    // Speed of bullets

// Damaged state variables
damaged_timer = 0;
damaged_duration = 20;
damaged_frame = 0;
damaged_frame_speed = 10;

// Death variables
death_alpha = 1;
death_fade_speed = 0.02;
death_y_speed = -0.5;  // Upward floating speed when dead
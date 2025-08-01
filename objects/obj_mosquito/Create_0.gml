/// Create
// General variables
state = "Idle";  // Initial state
hp = 2;          // Health points (3 HP as requested)
max_hp = 3;
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
fly_range = 150;  // Max distance from origin point
return_speed = 1.5;

// Attack variables
detection_range = 120;   // Distance to detect player (shorter than fly's range)
charge_range = 80;       // Range where mosquito will begin to charge
approach_distance = 60;  // How close to get before preparing to charge
min_approach_distance = 40; // Minimum distance to keep during approach

// Charge attack variables
attack_state = "Chase";  // Sub-states: "Chase", "Prepare", "Charge", "Cooldown"
prepare_timer = 0;
prepare_duration = 120;  // 2 seconds to aim before charging
charge_speed = 4;        // Speed during charge attack
charge_direction = 0;    // Direction of charge
cooldown_timer = 0;
cooldown_duration = 120; // 2 seconds cooldown after charging
has_hit_player = false;  // Flag to prevent multiple hits per charge
charge_target_x = 0;      // Store player's x position at charge start
charge_target_y = 0;      // Store player's y position at charge start
post_player_distance = 50; // How far to travel after passing the player

// Damaged state variables
damaged_timer = 0;
damaged_duration = 20;
damaged_frame = 0;
damaged_frame_speed = 10;

// Death variables
death_alpha = 1;
death_fade_speed = 0.02;
death_y_speed = -0.5;  // Upward floating speed when dead
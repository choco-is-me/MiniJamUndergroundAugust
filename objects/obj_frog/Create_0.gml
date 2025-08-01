// Create
state = "Idle"; // Initial state
current_body_sprite = spr_frog_idle_body;
current_head_sprite = spr_frog_idle_head;
image_speed = 1; // Animation speed for idle and pre-hop animations

// Health system variables
hp = 3; // 3 hearts of health
max_hp = 3;
health_bar_frame = 0; // Starting with image_index 0 (full 3 hearts)
health_transition_active = false;
health_transition_start_frame = 0;
health_transition_target_frame = 0;
health_transition_progress = 0;
health_transition_speed = 0.1; // Speed of health bar animation

// Jump charge variables
jump_charge = 0;
jump_charge_max = 100; // Maximum charge value
charge_rate = 2;       // Charge increase per step

// Movement and gravity variables
vsp = 0;           // Vertical speed
hsp = 0;           // Horizontal speed
gravity_val = 0.5; // Gravity strength

// Jumping and Direction
facing = 1; // 1 for right, -1 for left
base_jump_power_vertical = 8;     // Max vertical power
base_jump_power_horizontal = 2.5; // Horizontal speed when jumping with direction
air_control_force = 0.3;          // How much keys affect hsp in air
max_hsp_air = 4;                  // Max horizontal speed from air control input

// Attack variables
arrow_angle = 90;      // Start at the top (90° = straight up in GameMaker)
arrow_speed = 2;       // Speed of arrow oscillation (degrees per step)
arrow_direction = 1;   // 1 = clockwise, -1 = counterclockwise
arrow_min_angle = -30;  // Minimum angle (-30° = top-right)
arrow_max_angle = 200; // Maximum angle (200° = top-left)
arrow_distance = 24;   // Distance of arrow from frog's center
can_attack = true;     // Whether player can attack

// Tongue variables
tongue_active = false;    // Whether the tongue is currently out
tongue_angle = 0;         // Angle of tongue extension
tongue_length = 0;        // Current tongue length
tongue_max_length = 120;   // Maximum tongue extension length
tongue_speed = 6;         // Speed of ton gue extension
tongue_retracting = false;// Whether tongue is extending (false) or retracting (true)
tongue_damage = 10;       // Damage dealt by tongue hit

// Damaged state variables
damaged_timer = 0;
damaged_duration = 20;    // Duration of damaged animation (adjust as needed)
damaged_frame = 0;
damaged_frame_speed = 10; // Change frame every 10 steps

// Death variables
death_alpha = 1;         // For fading out effect
death_fade_speed = 0.02; // How quickly the frog fades out (decrease alpha)
death_particle_created = false;

// Sound related variables
audio_charging = -1;            // ID for charging sound
audio_charging_playing = false; // Flag to track if charging sound is playing
audio_charging_max_reached = false; // Flag to track if charge is at max

// One-shot sound flags to prevent multiple plays
audio_jump_played = false;
audio_attack_played = false;
audio_hit_played = false;
audio_dead_played = false;
audio_charging_length = 0.79; // Store the length of the charging sound in seconds

// Track enemy hits separately from damage state
audio_enemy_hit_played = false;

depth = -100;
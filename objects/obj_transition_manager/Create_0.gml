// Create
alpha = 0;             // Current fade alpha (0 = clear, 1 = black)
state = "inactive";    // States: inactive, fading_in, delay, fading_out
fade_in_speed = 0.05;  // How fast screen fades to black
fade_out_speed = 0.05; // How fast screen fades from black
delay = 30;            // Frames to wait after teleport before fading out
delay_timer = 0;       // Counter for delay state

// Teleport data (copied from teleporter)
target_x = 0;
target_y = 0;
target_room = room;
target_facing = 1;
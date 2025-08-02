/// @description Initialize transition manager

// Transition properties
alpha = 0;                         // Current fade alpha (0 = clear, 1 = black)
state = "inactive";                // States: inactive, fading_in, delay, fading_out
fade_in_duration = 0.5;            // Seconds to fade to black
fade_out_duration = 0.5;           // Seconds to fade from black
delay_duration = 0.5;              // Seconds to wait after teleport before fading out
timer = 0;                         // Timer for current state (seconds)

// Teleport data (copied from teleporter)
target_x = 0;
target_y = 0;
target_room = room;
target_facing = 1;
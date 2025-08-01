// Create
// Transition parameters
alpha = 0;             // Current alpha value
fade_in_speed = 0.02;  // Speed of fade in (increase for faster fade)
fade_out_speed = 0.02; // Speed of fade out (increase for faster fade)

// Default delay values
menu_delay = 30;       // Longer delay for menu to game transition (~0.75 seconds)
death_delay = 0;      // Shorter delay for death/restart transition (~0.25 seconds)
delay_time = 30;       // Default delay (will be overridden)
delay_counter = 0;     // Counter for delay

// Transition state
// 0 = Fading in
// 1 = Execute room change
// 2 = Delay after room change
// 3 = Fading out
// 4 = Complete
state = 0;

// Target information
target_action = ""; // "next_room" or "restart_room"

// Lock inputs during transition
global.input_locked = true;
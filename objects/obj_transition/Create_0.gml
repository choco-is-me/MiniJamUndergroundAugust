/// @description Initialize transition variables and parameters

// Transition alpha parameters
alpha = 0;                       // Current alpha value
fade_in_speed = 0.02;            // Speed of fade in (increase for faster fade)
fade_out_speed = 0.02;           // Speed of fade out (increase for faster fade)

// Delay parameters (in steps)
menu_delay_steps = 30;           // Longer delay for menu to game transition (~0.75 seconds)
death_delay_steps = 0;           // No delay for death/restart transition
delay_steps = 0;                 // Current delay to use
delay_counter = 0;               // Counter for tracking delay

// Transition state enum equivalent
// (GameMaker doesn't have true enums in GML)
enum TRANS_STATE {
    FADE_IN = 0,
    EXECUTE_ROOM_CHANGE = 1,
    DELAY_AFTER_CHANGE = 2,
    FADE_OUT = 3,
    COMPLETE = 4
}

state = TRANS_STATE.FADE_IN;

// Target information
target_action = "";              // "next_room" or "restart_room"

// Lock inputs during transition
global.input_locked = true;
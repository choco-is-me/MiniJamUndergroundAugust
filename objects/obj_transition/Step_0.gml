// Step
// Set the appropriate delay based on the action type
if (state == 0 && delay_time == 30) { // Only set this once, at the beginning
    if (target_action == "next_room") {
        delay_time = menu_delay; // Use menu delay for next_room
    } else if (target_action == "restart_room") {
        delay_time = death_delay; // Use death delay for restart_room
    }
}

// State machine for transition
switch(state) {
    case 0: // Fade in (to black)
        alpha += fade_in_speed;
        if (alpha >= 1) {
            alpha = 1;
            state = 1; // Move to action state
        }
        break;
        
    case 1: // Execute room change
        // Execute the target action immediately when fully faded to black
        if (target_action == "next_room") {
            room_goto_next();
        } else if (target_action == "restart_room") {
            room_restart();
        }
        state = 2; // Move to delay state
        break;
        
    case 2: // Delay AFTER room change
        delay_counter++;
        if (delay_counter >= delay_time) {
            state = 3; // Move to fade out state
        }
        break;
        
    case 3: // Fade out (from black)
        alpha -= fade_out_speed;
        if (alpha <= 0) {
            alpha = 0;
            state = 4; // Complete
        }
        break;
        
    case 4: // Complete
        // Transition is complete, destroy self
        instance_destroy();
        break;
}
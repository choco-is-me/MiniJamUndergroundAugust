/// @description Process transition states

// Set the appropriate delay based on the action type (only once at the beginning)
if (state == TRANS_STATE.FADE_IN && delay_steps == 0) {
    if (target_action == "next_room") {
        delay_steps = menu_delay_steps;
    } else if (target_action == "restart_room") {
        delay_steps = death_delay_steps;
    }
}

// State machine for transition
switch(state) {
    case TRANS_STATE.FADE_IN: // Fade in (to black)
        alpha += fade_in_speed;
        if (alpha >= 1) {
            alpha = 1;
            state = TRANS_STATE.EXECUTE_ROOM_CHANGE;
        }
        break;
        
    case TRANS_STATE.EXECUTE_ROOM_CHANGE: // Execute room change
        // Execute the target action immediately when fully faded to black
        if (target_action == "next_room") {
            room_goto_next();
        } else if (target_action == "restart_room") {
            room_restart();
        }
        state = TRANS_STATE.DELAY_AFTER_CHANGE;
        break;
        
    case TRANS_STATE.DELAY_AFTER_CHANGE: // Delay AFTER room change
        delay_counter++;
        if (delay_counter >= delay_steps) {
            state = TRANS_STATE.FADE_OUT;
        }
        break;
        
    case TRANS_STATE.FADE_OUT: // Fade out (from black)
        alpha -= fade_out_speed;
        if (alpha <= 0) {
            alpha = 0;
            state = TRANS_STATE.COMPLETE;
        }
        break;
        
    case TRANS_STATE.COMPLETE: // Complete
        // Transition is complete, unlock inputs and destroy self
        global.input_locked = false;
        instance_destroy();
        break;
}
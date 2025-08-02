/// @description Handle teleporter activation and cooldown

// Update cooldown
if (cooldown_timer > 0) {
    cooldown_timer -= delta_time / 1000000;
}

// Check for automatic activation
if (automatic && cooldown_timer <= 0 && 
    collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_player, false, false)) {
    activated = true;
}

// Handle activation
if (activated && obj_transition_manager.state == "inactive") {
    // Store teleport data in the transition manager
    with (obj_transition_manager) {
        fade_in_duration = other.fade_in_duration;
        fade_out_duration = other.fade_out_duration;
        delay_duration = other.delay_duration;
        
        // Copy teleport data to transition manager
        target_x = other.target_x;
        target_y = other.target_y;
        target_room = other.target_room;
        target_facing = other.target_facing;
        
        // Start transition
        state = "fading_in";
    }
    activated = false;
    cooldown_timer = cooldown_time;
}
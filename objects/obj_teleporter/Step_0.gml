if (automatic && 
    collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_player, false, false) && 
    !instance_exists(obj_all_enemies)) {
    activated = true;
}

// Handle activation
if (activated && obj_transition_manager.state == "inactive") {
    // Store teleport data in the transition manager
    with (obj_transition_manager) {
        fade_in_speed = other.fade_in_speed;
        fade_out_speed = other.fade_out_speed;
        delay = other.delay;
        
        // Copy teleport data to transition manager
        target_x = other.target_x;
        target_y = other.target_y;
        target_room = other.target_room;
        target_facing = other.target_facing;
        
        // Start transition
        state = "fading_in";
    }
    activated = false;
}
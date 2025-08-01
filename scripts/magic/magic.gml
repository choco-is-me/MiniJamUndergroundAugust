// Function to handle taking damage
function take_damage(damage_amount) {
    if (state != "Damaged" && state != "Dead") { // Prevent taking damage during damage animation or when dead
        hp -= damage_amount;
        hp = max(0, hp); // Clamp HP to minimum 0
        
        // Start health transition animation
        health_transition_active = true;
        health_transition_progress = 0;
        
        // Set proper transition frames based on current health
        if (hp == 2) {
            health_transition_start_frame = 0;  // image_index 0 (3 hearts)
            health_transition_target_frame = 2;  // image_index 2 (2 hearts)
        } 
        else if (hp == 1) {
            health_transition_start_frame = 2;  // image_index 2 (2 hearts)
            health_transition_target_frame = 4;  // image_index 4 (1 heart)
        }
        else if (hp == 0) {
            health_transition_start_frame = 4;  // image_index 4 (1 heart)
            health_transition_target_frame = 6;  // image_index 6 (0 hearts)
        }
        
        // Enter damaged state
        state = "Damaged";
        damaged_timer = 0;
        damaged_frame = 0;
        
        // Remove knockback effect - just stop movement instead
        vsp = 0;
        hsp = 0;
    }
}

// For Fly
function receive_damage(damage_amount) {
    if (state != "Damaged" && state != "Dead") {
        hp -= damage_amount;
        state = "Damaged";
        damaged_timer = 0;
        damaged_frame = 0;
    }
}

// Start a new transition
function start_transition(_mode, _target_room = -1, _target_x = -1, _target_y = -1, _target_facing = 1, _fade_in_speed = 0.05, _fade_out_speed = 0.05, _delay = 30, _target_obj = noone) {
    mode = _mode;
    target_room = _target_room;
    target_x = _target_x;
    target_y = _target_y;
    target_facing = _target_facing;
    fade_in_speed = _fade_in_speed;
    fade_out_speed = _fade_out_speed;
    delay_duration = _delay;
    target_obj = _target_obj;
    
    // Determine if this is a room change or same-room teleport
    teleport_same_room = (_target_room == -1 && _target_x != -1 && _target_y != -1);
    restart_game = (_mode == TRANS_MODE.FADE_IN && _target_room == -1 && _target_x == -1 && _target_y == -1);
    
    // Initialize for fade in
    if (_mode == TRANS_MODE.FADE_IN) {
        percent = 0;
    }
}

// Check Audio
function music_and_sound_loaded() {
    return audio_group_is_loaded(licensed_sound);
}
// Step
switch(state) {
    case "inactive":
        // Nothing to do when inactive
        break;
        
    case "fading_in":
        // Fade screen to black
        alpha += fade_in_speed;
        if (alpha >= 1) {
            alpha = 1;
            
            // Perform teleportation
            with (obj_frog) {
                // Move to target room if different
                if (room != other.target_room) {
                    room_goto(other.target_room);
                }
                
                // Position player
                x = other.target_x;
                y = other.target_y;
                
                // Set facing direction
                facing = other.target_facing;
                
                // Reset movement
                vsp = 0;
                hsp = 0;
            }
            
            state = "delay";
            delay_timer = delay;
        }
        break;
        
    case "delay":
        // Wait while screen is black
        delay_timer--;
        if (delay_timer <= 0) {
            state = "fading_out";
        }
        break;
        
    case "fading_out":
        // Fade screen back in
        alpha -= fade_out_speed;
        if (alpha <= 0) {
            alpha = 0;
            state = "inactive";
        }
        break;
}
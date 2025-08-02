/// @description Handle room transition states

var dt = delta_time / 1000000;     // Convert delta_time to seconds

switch(state) {
    case "inactive":
        // Nothing to do when inactive
        break;
        
    case "fading_in":
        // Fade screen to black
        timer += dt;
        alpha = timer / fade_in_duration;
        if (alpha >= 1) {
            alpha = 1;
            timer = 0;
            
            // Perform teleportation
            with (obj_player) {
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
        }
        break;
        
    case "delay":
        // Wait while screen is black
        timer += dt;
        if (timer >= delay_duration) {
            timer = 0;
            state = "fading_out";
        }
        break;
        
    case "fading_out":
        // Fade screen back in
        timer += dt;
        alpha = 1 - (timer / fade_out_duration);
        if (alpha <= 0) {
            alpha = 0;
            timer = 0;
            state = "inactive";
        }
        break;
}
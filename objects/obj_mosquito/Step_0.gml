/// Step
// Update animation based on state
switch (state) {
    case "Idle":
        sprite_index = spr_mosquito_flying;
        image_speed = 1;  // Loop the flying animation
        break;
        
    case "Attack":
        sprite_index = spr_mosquito_attack;
        image_speed = 1;  // Loop the attack animation
        break;
        
    case "Damaged":
        sprite_index = spr_mosquito_damaged;
        // Animation handled explicitly in the damaged state code
        break;
        
    case "Dead":
        sprite_index = spr_mosquito_dead;
        image_speed = 0;  // Single frame for dead
        break;
}

// Check for player in range (for attack state transition)
var player = instance_nearest(x, y, obj_frog);
var distance_to_player = 999999; // Large default value

if (player != noone) {
    distance_to_player = point_distance(x, y, player.x, player.y);
    
    // Face towards player
    if (player.x < x) {
        facing = -1;
    } else {
        facing = 1;
    }
}

// State machine
switch (state) {
    case "Idle":
        // Random movement
        move_timer++;
        if (move_timer >= move_interval) {
            move_timer = 0;
            move_direction = irandom(359); // Choose a new random direction
            
            // Adjust movement if too far from origin
            var dist_from_origin = point_distance(x, y, origin_x, origin_y);
            if (dist_from_origin > fly_range * 0.7) { // At 70% of range, start moving back
                // Calculate angle towards origin
                var angle_to_origin = point_direction(x, y, origin_x, origin_y);
                // Move towards origin
                move_direction = angle_to_origin;
            }
        }
        
        // Calculate movement based on direction
        hsp = lengthdir_x(fly_speed, move_direction);
        vsp = lengthdir_y(fly_speed, move_direction);
        
        // Move mosquito
        x += hsp;
        y += vsp;
        
        // Hard boundary check to prevent going too far
        var dist_from_origin = point_distance(x, y, origin_x, origin_y);
        if (dist_from_origin > fly_range) {
            // Force move back towards origin
            var angle_to_origin = point_direction(x, y, origin_x, origin_y);
            x = origin_x + lengthdir_x(fly_range, angle_to_origin);
            y = origin_y + lengthdir_y(fly_range, angle_to_origin);
        }
        
        // Detect player and switch to attack state
        if (player != noone && distance_to_player < detection_range && hp > 0) {
            state = "Attack";
            attack_state = "Chase";  // Start by chasing the player
            has_hit_player = false;  // Reset hit flag
        }
        break;
        
    case "Attack":
        // Attack state has its own sub-state machine
        switch (attack_state) {
            case "Chase":
                if (player != noone) {
                    var angle_to_player = point_direction(x, y, player.x, player.y);
                    
                    // Chase player but keep some distance
                    if (distance_to_player > approach_distance) {
                        // Move closer if too far
                        hsp = lengthdir_x(fly_speed * 1.2, angle_to_player);
                        vsp = lengthdir_y(fly_speed * 1.2, angle_to_player);
                    } else if (distance_to_player < min_approach_distance) {
                        // Back away if too close
                        hsp = lengthdir_x(-fly_speed, angle_to_player);
                        vsp = lengthdir_y(-fly_speed, angle_to_player);
                    } else {
                        // We're at good distance, prepare to charge
                        attack_state = "Prepare";
                        prepare_timer = 0;
                        hsp = 0;
                        vsp = 0;
                    }
                    
                    // Move mosquito
                    x += hsp;
                    y += vsp;
                    
                    // If player is out of charge range, return to idle
                    if (distance_to_player > detection_range * 1.2) {
                        state = "Idle";
                    }
                } else {
                    // No player found, return to idle
                    state = "Idle";
                }
                break;
                
            case "Prepare":
                // Stay relatively still but with slight hovering movement
                hsp = lengthdir_x(fly_speed * 0.2, move_direction);
                vsp = lengthdir_y(fly_speed * 0.2, move_direction);
                x += hsp;
                y += vsp;
                
                // Update facing to continuously track player during preparation
                if (player != noone) {
                    if (player.x < x) {
                        facing = -1;
                    } else {
                        facing = 1;
                    }
                    
                    // Store the direction for charging
                    charge_direction = point_direction(x, y, player.x, player.y);
                    
                    // Store player position for distance calculation during charge
                    charge_target_x = player.x;
                    charge_target_y = player.y;
                }
                
                // Increment prepare timer
                prepare_timer++;
                if (prepare_timer >= prepare_duration) {
                    attack_state = "Charge";
                    has_hit_player = false;  // Reset hit flag for new charge
                }
                
                // If player gets too far away during preparation, go back to chase
                if (player != noone && distance_to_player > charge_range) {
                    attack_state = "Chase";
                }
                break;
                
            case "Charge":
                // Charge in the stored direction at high speed
                hsp = lengthdir_x(charge_speed, charge_direction);
                vsp = lengthdir_y(charge_speed, charge_direction);
                x += hsp;
                y += vsp;
                
                // Check collision with player
                if (!has_hit_player) {
                    var hit_player = collision_rectangle(
                        x - 8, y - 8, 
                        x + 8, y + 8, 
                        obj_frog, false, true
                    );
                    
                    if (hit_player != noone) {
                        // Deal damage to player using the take_damage function
                        with (hit_player) {
                            if (state != "Damaged" && state != "Dead") {
                                take_damage(1);
                            }
                        }
                        has_hit_player = true;  // Prevent multiple hits during the same charge
                    }
                }
                
                // Calculate how far the mosquito has traveled past the player
                var passed_player = false;
                var player_dot_product = dot_product(
                    x - charge_target_x, 
                    y - charge_target_y,
                    lengthdir_x(1, charge_direction),
                    lengthdir_y(1, charge_direction)
                );
                
                // If dot product is positive, we've passed the player along our charge path
                if (player_dot_product > 0) {
                    passed_player = true;
                    var dist_past_player = point_distance(
                        charge_target_x, 
                        charge_target_y,
                        x, 
                        y
                    );
                    
                    // Stop charging if we've gone far enough past the player
                    if (dist_past_player > post_player_distance) {
                        attack_state = "Cooldown";
                        cooldown_timer = 0;
                        hsp = 0;
                        vsp = 0;
                    }
                }
                
                // Check if mosquito has traveled far enough from origin
                var dist_from_origin = point_distance(x, y, origin_x, origin_y);
                if (dist_from_origin > fly_range * 1.2) {  
                    // Instead of teleporting, switch to return state
                    attack_state = "Return";
                    // Keep the momentum for a short period to make it look natural
                    hsp *= 0.5;
                    vsp *= 0.5;
                }
                break;
                
            case "Cooldown":
                // Stay in place during cooldown with slight hovering
                hsp = lengthdir_x(fly_speed * 0.2, move_direction);
                vsp = lengthdir_y(fly_speed * 0.2, move_direction);
                x += hsp;
                y += vsp;
                
                // Increment cooldown timer
                cooldown_timer++;
                if (cooldown_timer >= cooldown_duration) {
                    // Check if player is still within charge range
                    if (player != noone && distance_to_player < charge_range) {
                        // Player is still in range, prepare for another charge
                        attack_state = "Prepare";
                        prepare_timer = 0;
                    } else if (player != noone && distance_to_player < detection_range) {
                        // Player is in detection range but not charge range, chase
                        attack_state = "Chase";
                    } else {
                        // Player is out of range, return to idle
                        state = "Idle";
                    }
                }
                break;
                
            case "Return":
                // Calculate direction back to origin
                var angle_to_origin = point_direction(x, y, origin_x, origin_y);
                var dist_from_origin = point_distance(x, y, origin_x, origin_y);
                
                // Smoothly move back toward origin with distance-based speed
                // This naturally slows down as we get closer to origin
                var return_intensity = min(dist_from_origin / fly_range, 1);
                var current_return_speed = return_speed * return_intensity;
                
                hsp = lengthdir_x(current_return_speed, angle_to_origin);
                vsp = lengthdir_y(current_return_speed, angle_to_origin);
                
                // Apply movement
                x += hsp;
                y += vsp;
                
                // Check if we're back within normal range
                if (dist_from_origin <= fly_range) {
                    // We're back inside normal range, go to cooldown
                    attack_state = "Cooldown";
                    cooldown_timer = 0;
                    hsp = 0;
                    vsp = 0;
                }
                break;
        }
        
        // Handle boundary checks for attack state (except during Return or Charge)
        if (attack_state != "Return" && attack_state != "Charge") {
            var dist_from_origin = point_distance(x, y, origin_x, origin_y);
            if (dist_from_origin > fly_range * 1.2) {
                attack_state = "Return";
                // Reduce velocity to avoid looking too erratic
                hsp *= 0.5;
                vsp *= 0.5;
            }
        }
        break;
        
    case "Damaged":
        // Reset movement
        hsp = 0;
        vsp = 0;
        
        // Handle damaged animation
        damaged_timer++;
        if (damaged_timer % damaged_frame_speed == 0) {
            damaged_frame = !damaged_frame; // Toggle between 0 and 1
        }
        
        image_index = damaged_frame;
        
        // Exit damaged state after animation completes
        if (damaged_timer >= damaged_duration) {
            damaged_timer = 0;
            
            // Return to appropriate state
            if (hp <= 0) {
                state = "Dead";
            } else if (player != noone && distance_to_player < detection_range) {
                state = "Attack";
                attack_state = "Chase";  // Always start with chase after being damaged
            } else {
                state = "Idle";
            }
        }
        break;
        
    case "Dead":
        // Float upward and fade out
        y += death_y_speed; // Move upward
        death_alpha -= death_fade_speed;
        
        if (death_alpha <= 0) {
            // Destroy instance when fully transparent
            instance_destroy();
        }
        break;
}
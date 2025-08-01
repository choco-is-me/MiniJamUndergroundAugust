/// Step
// Update animation based on state
switch (state) {
    case "Idle":
        sprite_index = spr_fly_flying;
        image_speed = 1;  // Loop the flying animation
        break;
        
    case "Attack":
        sprite_index = spr_fly_attack;
        // Animation handled explicitly in the attack state code
        break;
        
    case "Return":  // NEW STATE
        sprite_index = spr_fly_flying;
        image_speed = 1;  // Use flying animation during return
        break;
        
    case "Damaged":
        sprite_index = spr_fly_damaged;
        // Animation handled explicitly in the damaged state code
        break;
        
    case "Dead":
        sprite_index = spr_fly_dead;
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
        
        // Move fly
        x += hsp;
        y += vsp;
        
        // Boundary check - switch to Return state instead of teleporting
        var dist_from_origin = point_distance(x, y, origin_x, origin_y);
        if (dist_from_origin > fly_range) {
            state = "Return";
            // Reduce current velocity to make transition smoother
            hsp *= 0.5;
            vsp *= 0.5;
        }
        
        // Detect player and switch to attack state
        if (player != noone && distance_to_player < attack_range && hp > 0) {
            state = "Attack";
            attack_cooldown = 0;
            image_index = 0; // Start with waiting frame
        }
        break;
        
    case "Attack":
        // Slow movement toward player (half speed)
        if (player != noone) {
            var angle_to_player = point_direction(x, y, player.x, player.y);
            
            // Move slowly toward player but keep distance
            var target_distance = attack_range * 0.7; // Target 70% of attack range
            if (distance_to_player > target_distance) {
                // Move closer if too far
                hsp = lengthdir_x(fly_speed * 0.5, angle_to_player);
                vsp = lengthdir_y(fly_speed * 0.5, angle_to_player);
            } else if (distance_to_player < target_distance * 0.8) {
                // Back away if too close
                hsp = lengthdir_x(-fly_speed * 0.5, angle_to_player);
                vsp = lengthdir_y(-fly_speed * 0.5, angle_to_player);
            } else {
                // Stay in place with minor movement
                hsp = lengthdir_x(fly_speed * 0.2, move_direction);
                vsp = lengthdir_y(fly_speed * 0.2, move_direction);
            }
            
            // Move fly
            x += hsp;
            y += vsp;
            
            // Boundary check - switch to Return state instead of teleporting
            var dist_from_origin = point_distance(x, y, origin_x, origin_y);
            if (dist_from_origin > fly_range * 1.2) { // Allow slightly larger range during attack
                state = "Return";
                // Reduce current velocity to make transition smoother
                hsp *= 0.5;
                vsp *= 0.5;
            }
            
            // Attack logic - shoot at player
            attack_cooldown++;
            
            // Set frame based on attack cooldown
            if (attack_cooldown > attack_cooldown_max - 10 && attack_cooldown <= attack_cooldown_max) {
                // Use shooting frame just before firing
                image_index = 1; // Shooting frame
            } else {
                image_index = 0; // Waiting frame
            }
            
            if (attack_cooldown >= attack_cooldown_max) {
                attack_cooldown = 0;
                
                // Create bullet
                var bullet = instance_create_layer(x, y, "Instances", obj_fly_bullet);
                bullet.speed = bullet_speed;
                bullet.direction = angle_to_player;
                bullet.image_angle = angle_to_player;
                bullet.spin_speed = 5; // Set the desired spinning speed here
            }
            
            // Return to idle if player is out of range
            if (distance_to_player > attack_range * 1.2) { // Give some extra range before leaving attack mode
                state = "Idle";
            }
        } else {
            // No player found, go back to idle
            state = "Idle";
        }
        break;
        
    case "Return":  // NEW STATE - Smooth return to origin
        // Calculate direction back to origin
        var angle_to_origin = point_direction(x, y, origin_x, origin_y);
        var dist_from_origin = point_distance(x, y, origin_x, origin_y);
        
        // Smoothly move back toward origin with distance-based speed
        var return_intensity = min(dist_from_origin / fly_range, 1);
        var current_return_speed = return_speed * return_intensity;
        
        hsp = lengthdir_x(current_return_speed, angle_to_origin);
        vsp = lengthdir_y(current_return_speed, angle_to_origin);
        
        // Apply movement
        x += hsp;
        y += vsp;
        
        // Check if we're back within normal range
        if (dist_from_origin <= fly_range * 0.9) { // Return to within 90% of range
            // We're back inside normal range
            // Check if player is in attack range
            if (player != noone && distance_to_player < attack_range && hp > 0) {
                state = "Attack";
                attack_cooldown = 0;
                image_index = 0;
            } else {
                state = "Idle";
            }
            // Reset movement for clean transition
            hsp = 0;
            vsp = 0;
        }
        
        // Still check for player during return - if player gets very close, attack
        if (player != noone && distance_to_player < attack_range * 0.5 && hp > 0) {
            state = "Attack";
            attack_cooldown = 0;
            image_index = 0;
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
            } else {
                // Check distance from origin to determine next state
                var dist_from_origin = point_distance(x, y, origin_x, origin_y);
                if (dist_from_origin > fly_range) {
                    state = "Return";
                } else if (player != noone && distance_to_player < attack_range) {
                    state = "Attack";
                } else {
                    state = "Idle";
                }
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
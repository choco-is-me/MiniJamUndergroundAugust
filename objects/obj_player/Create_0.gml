/// @description Initialize player variables

// Movement constants
#macro PLAYER_SPEED 120.0 // Units per second instead of per frame
#macro WALL_SLIDE_BUFFER 2

// State constants
enum PLAYER_STATE {
    IDLE,
    MOVING,
    MINING
}

// Facing constants
enum PLAYER_FACING {
    LEFT,
    RIGHT
}

// Player variables
state = PLAYER_STATE.IDLE;
facing = PLAYER_FACING.RIGHT;

// Movement variables
hspd = 0;
vspd = 0;
move_dir = 0;

// Mining variables
mining_timer = 0;
#macro MINING_DURATION 0.5 // Time in seconds for mining animation
mining_target = noone;
mining_range = 16; // Reduced from 32 to 16
#macro MINING_ANGLE 60 // Define mining angle in degrees (instead of 180°)

// Action cooldown variables
#macro ACTION_COOLDOWN 0.5 // Cooldown time in seconds between mining actions
action_cooldown_timer = 0;
can_perform_action = true;

// Pickaxe animation variables
pickaxe_angle = 0;
pickaxe_start_angle = 45; // Starting angle for swing
pickaxe_end_angle = -45;  // Ending angle for swing

// Pickaxe variables
enum PICKAXE_TYPE {
    WOOD,
    STONE,
    IRON,
    GOLD,
    PRISMATIC
}
pickaxe_level = PICKAXE_TYPE.WOOD;
pickaxe_names = ["Wooden", "Stone", "Iron", "Gold", "Prismatic"];

// Resources the player has collected
stone_count = 0;
iron_count = 0;
gold_count = 0;
diamond_count = 0;

// Item attraction variables
#macro ITEM_ATTRACT_RANGE 96  // How far items will be attracted to player
#macro ITEM_ATTRACT_SPEED 180.0 // Units per second

// Input variables - declarations only, they'll be set in get_controls()
key_left = 0;
key_left_hold = 0;
key_right = 0;
key_right_hold = 0;
key_up = 0;
key_up_hold = 0;
key_down = 0;
key_down_hold = 0;
key_action_pressed = 0;
key_action_held = 0;
key_interact_pressed = 0;
key_interact_held = 0;
key_pause_pressed = 0;
key_fullscreen_pressed = 0;
key_upgrade_pickaxe = 0;

// Animation variables
image_speed = 0;
anim_frame = 0;
anim_speed = 9.0; // Frames per second

// UI Animation variables
#macro BUTTON_ANIM_SPEED 4.0 // Frames per second for button animations
button_anim_frame = 0;

// FUNCTION DEFINITIONS (still part of Create Event)
// Idle state processing
function process_idle_state() {
    // Check for movement inputs to change state
    if (key_left_hold || key_right_hold || key_up_hold || key_down_hold) {
        state = PLAYER_STATE.MOVING;
        exit;
    }
    
    // Check for mining action
    if (key_action_pressed && can_perform_action) {
        var target = find_minable_target();
        if (target != noone) {
            state = PLAYER_STATE.MINING;
            mining_target = target;
            mining_timer = 0;
            can_perform_action = false;
            action_cooldown_timer = 0;
            pickaxe_angle = pickaxe_start_angle * (facing == PLAYER_FACING.RIGHT ? 1 : -1);
            exit;
        }
    }
    
    // No inputs, remain in idle
    hspd = 0;
    vspd = 0;
}

// Movement state processing
function process_movement_state() {
    // Calculate movement based on input
    var dt_speed = PLAYER_SPEED * (delta_time / 1000000); // Convert to seconds
    hspd = (key_right_hold - key_left_hold) * dt_speed;
    vspd = (key_down_hold - key_up_hold) * dt_speed;
    
    // Normalize diagonal movement to prevent moving faster diagonally
    if (hspd != 0 && vspd != 0) {
        var len = sqrt(hspd*hspd + vspd*vspd);
        hspd = (hspd / len) * dt_speed;
        vspd = (vspd / len) * dt_speed;
    }
    
    // Update facing direction based on horizontal movement
    if (hspd > 0) facing = PLAYER_FACING.RIGHT;
    else if (hspd < 0) facing = PLAYER_FACING.LEFT;
    
    // Apply movement with collision handling
    apply_movement_with_collision();
    
    // Check for state changes
    if (hspd == 0 && vspd == 0) {
        state = PLAYER_STATE.IDLE;
        exit;
    }
    
    // Check for mining action
    if (key_action_pressed && can_perform_action) {
        var target = find_minable_target();
        if (target != noone) {
            state = PLAYER_STATE.MINING;
            mining_target = target;
            mining_timer = 0;
            can_perform_action = false;
            action_cooldown_timer = 0;
            pickaxe_angle = pickaxe_start_angle * (facing == PLAYER_FACING.RIGHT ? 1 : -1);
            hspd = 0;
            vspd = 0;
            exit;
        }
    }
}

// Mining state processing
function process_mining_state() {
    // Ensure mining target still exists
    if (!instance_exists(mining_target)) {
        state = PLAYER_STATE.IDLE;
        mining_target = noone;
        exit;
    }
    
    // Check if target is still in valid range and direction
    var still_valid = is_target_valid(mining_target);
    if (!still_valid) {
        state = PLAYER_STATE.IDLE;
        mining_target = noone;
        exit;
    }
    
    // Increment mining timer using delta_time
    mining_timer += delta_time / 1000000; // Convert to seconds
    
    // Update pickaxe angle for swing animation
    var swing_progress = mining_timer / MINING_DURATION;
    var direction_multiplier = (facing == PLAYER_FACING.RIGHT ? 1 : -1);
    pickaxe_angle = lerp(
        pickaxe_start_angle * direction_multiplier, 
        pickaxe_end_angle * direction_multiplier, 
        swing_progress
    );
    
    // Check if mining action completed
    if (mining_timer >= MINING_DURATION) {
        // Hit the resource
        with (mining_target) {
            hit_resource(other.pickaxe_level);
        }
        state = PLAYER_STATE.IDLE;
        mining_target = noone;
        mining_timer = 0;
    }
}

// Check if target is still valid (in range and direction)
function is_target_valid(target) {
    if (!instance_exists(target)) return false;
    
    var dist = point_distance(x, y, target.x, target.y);
    if (dist > mining_range) return false;
    
    // Calculate the center angle and check if target is within mining angle
    var center_angle = (facing == PLAYER_FACING.RIGHT) ? 0 : 180;
    var angle_to_target = point_direction(x, y, target.x, target.y);
    var angle_diff = abs(angle_difference(angle_to_target, center_angle));
    
    return (angle_diff <= MINING_ANGLE / 2);
}

// Apply movement with collision handling and wall sliding
function apply_movement_with_collision() {
    // Try horizontal movement first
    if (hspd != 0) {
        if (place_meeting(x + hspd, y, obj_solid)) {
            // Collision detected, move as close as possible to the wall
            while (!place_meeting(x + sign(hspd), y, obj_solid)) {
                x += sign(hspd);
            }
            hspd = 0; // Stop horizontal movement
        } else {
            x += hspd; // No collision, apply movement
        }
    }
    
    // Try vertical movement next
    if (vspd != 0) {
        if (place_meeting(x, y + vspd, obj_solid)) {
            // Collision detected, move as close as possible to the wall
            while (!place_meeting(x, y + sign(vspd), obj_solid)) {
                y += sign(vspd);
            }
            vspd = 0; // Stop vertical movement
        } else {
            y += vspd; // No collision, apply movement
        }
    }
    
    // Wall sliding for diagonal movement - try to slide along walls
    if (hspd != 0 && vspd != 0) {
        // If we couldn't move horizontally but can move vertically, slide along the wall
        if (hspd == 0 && !place_meeting(x, y + vspd, obj_solid)) {
            y += vspd;
        }
        // If we couldn't move vertically but can move horizontally, slide along the wall
        else if (vspd == 0 && !place_meeting(x + hspd, y, obj_solid)) {
            x += hspd;
        }
    }
}

// Find minable object in front of player
function find_minable_target() {
    // Check if any minable objects are within range
    var resources = [obj_stone, obj_iron, obj_gold, obj_diamond];
    var closest_distance = mining_range;
    var closest_instance = noone;
    
    // Calculate the center angle based on facing direction
    var center_angle = (facing == PLAYER_FACING.RIGHT) ? 0 : 180;
    
    for (var i = 0; i < array_length(resources); i++) {
        var res_obj = resources[i];
        with (res_obj) {
            var dist = point_distance(x, y, other.x, other.y);
            
            // Check if within range
            if (dist < other.mining_range) {
                // Calculate angle to resource
                var angle_to_resource = point_direction(other.x, other.y, x, y);
                
                // Check if within the mining angle
                var angle_diff = abs(angle_difference(angle_to_resource, center_angle));
                var is_in_angle = angle_diff <= MINING_ANGLE / 2;
                
                if (is_in_angle && dist < closest_distance) {
                    closest_distance = dist;
                    closest_instance = id;
                }
            }
        }
    }
    
    return closest_instance;
}

// Mark all resources in mining range for outline display
function mark_resources_in_range() {
    // Get list of all resource objects
    var resources = [obj_stone, obj_iron, obj_gold, obj_diamond];
    var center_angle = (facing == PLAYER_FACING.RIGHT) ? 0 : 180;
    
    // First, mark all resources as not in range
    for (var i = 0; i < array_length(resources); i++) {
        var res_obj = resources[i];
        with (res_obj) {
            in_mining_range = false;
        }
    }
    
    // Then mark those that are in range
    for (var i = 0; i < array_length(resources); i++) {
        var res_obj = resources[i];
        with (res_obj) {
            var dist = point_distance(x, y, other.x, other.y);
            
            // Check if within range
            if (dist < other.mining_range) {
                // Calculate angle to resource
                var angle_to_resource = point_direction(other.x, other.y, x, y);
                
                // Check if within the mining angle
                var angle_diff = abs(angle_difference(angle_to_resource, center_angle));
                var is_in_angle = angle_diff <= MINING_ANGLE / 2;
                
                if (is_in_angle) {
                    in_mining_range = true;
                }
            }
        }
    }
}

// Check if pickaxe upgrade is available
function is_pickaxe_upgrade_available() {
    // Check if already at max level
    if (pickaxe_level == PICKAXE_TYPE.PRISMATIC) {
        return false;
    }
    
    // Check if player has enough resources for upgrade
    switch (pickaxe_level) {
        case PICKAXE_TYPE.WOOD:
            // Need 10 stone for Stone Pickaxe
            return (stone_count >= 10);
            
        case PICKAXE_TYPE.STONE:
            // Need 10 iron for Iron Pickaxe
            return (iron_count >= 10);
            
        case PICKAXE_TYPE.IRON:
            // Need 10 gold for Gold Pickaxe
            return (gold_count >= 10);
            
        case PICKAXE_TYPE.GOLD:
            // Need 10 diamond for Prismatic Pickaxe
            return (diamond_count >= 10);
    }
    
    return false;
}

// Handle pickaxe upgrade attempt
function attempt_pickaxe_upgrade() {
    // Check if already at max level
    if (pickaxe_level == PICKAXE_TYPE.PRISMATIC) {
        // Already at max level
        return;
    }
    
    // Check if player has enough resources for upgrade
    var has_resources = false;
    
    switch (pickaxe_level) {
        case PICKAXE_TYPE.WOOD:
            // Need 10 stone for Stone Pickaxe
            has_resources = (stone_count >= 10);
            if (has_resources) {
                stone_count -= 10;
                pickaxe_level = PICKAXE_TYPE.STONE;
            }
            break;
            
        case PICKAXE_TYPE.STONE:
            // Need 10 iron for Iron Pickaxe
            has_resources = (iron_count >= 10);
            if (has_resources) {
                iron_count -= 10;
                pickaxe_level = PICKAXE_TYPE.IRON;
            }
            break;
            
        case PICKAXE_TYPE.IRON:
            // Need 10 gold for Gold Pickaxe
            has_resources = (gold_count >= 10);
            if (has_resources) {
                gold_count -= 10;
                pickaxe_level = PICKAXE_TYPE.GOLD;
            }
            break;
            
        case PICKAXE_TYPE.GOLD:
            // Need 10 diamond for Prismatic Pickaxe
            has_resources = (diamond_count >= 10);
            if (has_resources) {
                diamond_count -= 10;
                pickaxe_level = PICKAXE_TYPE.PRISMATIC;
            }
            break;
    }
    
    // Display upgrade notification
    if (has_resources) {
        // Could connect to a notification system here
        show_debug_message("Upgraded pickaxe to " + pickaxe_names[pickaxe_level] + "!");
    }
}

// Update animation frames
function update_animation() {
    // Update animation frame using delta_time
    var dt = delta_time / 1000000; // Convert to seconds
    
    // Progress animation based on state
    switch(state) {
        case PLAYER_STATE.IDLE:
            image_index = 0; // Static frame for idle
            break;
            
        case PLAYER_STATE.MOVING:
            anim_frame += anim_speed * dt;
            // Keep anim_frame within sprite bounds to avoid potential precision issues
            anim_frame = anim_frame % sprite_get_number(sprite_index);
            image_index = floor(anim_frame);
            break;
            
        case PLAYER_STATE.MINING:
            // Mining animation based on progress
            var total_frames = sprite_get_number(sprite_index);
            image_index = floor((mining_timer / MINING_DURATION) * total_frames);
            if (image_index >= total_frames) image_index = total_frames - 1;
            break;
    }
    
    // Update button animations
    button_anim_frame += BUTTON_ANIM_SPEED * dt;
    button_anim_frame = button_anim_frame % 2; // Only 2 frames for button animations
}

// Update action cooldown timer
function update_action_cooldown() {
    if (!can_perform_action) {
        action_cooldown_timer += delta_time / 1000000; // Convert to seconds
        if (action_cooldown_timer >= ACTION_COOLDOWN) {
            can_perform_action = true;
            action_cooldown_timer = 0;
        }
    }
}
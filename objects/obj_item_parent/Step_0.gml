/// @description Handle item movement and attraction

// Delta time in seconds
var dt = delta_time / 1000000;

// Float animation (bobbing up and down)
float_offset = (float_offset + float_speed * dt) % (2 * pi);

// Find nearest player
var nearest_player = instance_nearest(x, y, obj_player);

if (nearest_player != noone) {
    // Calculate distance to player
    var dist = point_distance(x, y, nearest_player.x, nearest_player.y);
    
    // Check if within attraction range
    if (dist <= ITEM_ATTRACT_RANGE) {
        is_attracted = true;
        
        // Calculate direction to player
        var dir = point_direction(x, y, nearest_player.x, nearest_player.y);
        
        // Accelerate toward player, faster as we get closer
        var attraction_factor = 1 - (dist / ITEM_ATTRACT_RANGE);
        var current_attraction_speed = ITEM_ATTRACT_SPEED * attraction_factor * dt;
        
        // Calculate new speeds with acceleration toward player
        hspd = lerp(hspd, lengthdir_x(current_attraction_speed, dir), 0.2);
        vspd = lerp(vspd, lengthdir_y(current_attraction_speed, dir), 0.2);
        
        // When very close to player, accelerate more for that final "sucking in" effect
        if (dist < 24) {
            hspd = lerp(hspd, lengthdir_x(ITEM_ATTRACT_SPEED * 2 * dt, dir), 0.4);
            vspd = lerp(vspd, lengthdir_y(ITEM_ATTRACT_SPEED * 2 * dt, dir), 0.4);
        }
    }
    else {
        // Apply friction when not attracted - convert to per-frame factor
        var friction_per_frame = power(friction_factor, dt * 60);
        hspd *= friction_per_frame;
        vspd *= friction_per_frame;
    }
}
else {
    // Apply friction when no player exists
    var friction_per_frame = power(friction_factor, dt * 60);
    hspd *= friction_per_frame;
    vspd *= friction_per_frame;
}

// Apply movement with delta time
x += hspd * dt;
y += vspd * dt;

// Handle collisions with solid objects
if (place_meeting(x, y, obj_solid)) {
    // Bounce off walls
    if (place_meeting(x + hspd * dt, y, obj_solid)) {
        hspd = -hspd * bounce_factor;
    }
    
    if (place_meeting(x, y + vspd * dt, obj_solid)) {
        vspd = -vspd * bounce_factor;
    }
}
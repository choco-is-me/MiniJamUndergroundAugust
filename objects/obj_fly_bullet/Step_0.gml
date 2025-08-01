/// Step
// Apply spinning effect
image_angle += spin_speed;

// Check if bullet is outside room
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}

// Check for collision with player
var player = instance_place(x, y, obj_frog);
if (player != noone) {
    // Make sure the player can be damaged (not already in damaged state)
    if (player.state != "Damaged" && player.state != "Dead") {
        // Call the player's take_damage function
        with (player) {
            take_damage(1);
        }
    }
    // Destroy bullet after hitting player
    instance_destroy();
}

//// Check for collision with platforms
//var platform = instance_place(x, y, obj_platform);
//if (platform != noone) {
    //// Destroy bullet on platform collision
    //instance_destroy();
//}
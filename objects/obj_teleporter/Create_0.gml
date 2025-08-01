// Create
// Teleport target variables
target_x = 0;          // X position to teleport to
target_y = 0;          // Y position to teleport to
target_room = room;    // Room to teleport to (default: current room)
target_facing = 1;     // Direction player will face after teleport
fade_in_speed = 0.05;  // How fast screen fades to black
fade_out_speed = 0.05; // How fast screen fades from black
delay = 30;            // Frames to wait after fade completes

// Trigger settings
activated = false;     // Whether teleporter has been triggered
automatic = false;     // Whether it activates automatically on collision

// Make sure transition manager exists
if (!instance_exists(obj_transition_manager)) {
    instance_create_layer(0, 0, "Instances", obj_transition_manager);
}
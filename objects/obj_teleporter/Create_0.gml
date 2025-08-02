/// @description Initialize teleporter variables and settings

// Teleport target variables
target_x = 0;                      // X position to teleport to
target_y = 0;                      // Y position to teleport to
target_room = room;                // Room to teleport to (default: current room)
target_facing = 1;                 // Direction player will face after teleport

// Transition timing (in seconds)
fade_in_duration = 0.5;            // How long screen takes to fade to black
fade_out_duration = 0.5;           // How long screen takes to fade from black
delay_duration = 0.5;              // Seconds to wait after fade completes

// Trigger settings
activated = false;                 // Whether teleporter has been triggered
automatic = false;                 // Whether it activates automatically on collision
cooldown_time = 1.0;               // Seconds before can be triggered again
cooldown_timer = 0;                // Current cooldown timer

// Make sure transition manager exists
if (!instance_exists(obj_transition_manager)) {
    instance_create_layer(0, 0, "Instances", obj_transition_manager);
}
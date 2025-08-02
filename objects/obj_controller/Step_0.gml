/// @description Handle input and game logic
get_controls();

// Toggle fullscreen if the key is pressed
if (!global.input_locked && key_fullscreen_pressed) {
    window_set_fullscreen(!window_get_fullscreen());
}
// Load Controls
get_controls();

// Mouse input checks
var _mouse_x_pos = device_mouse_x(0);
var _mouse_y_pos = device_mouse_y(0);

// Update options length for current menu level
op_length = array_length(option[menu_level]);

// Calculate view dimensions
var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

// Calculate starting positions for left-aligned text
var left_padding = _view_width / 5; // Padding is one-fifth of screen width
start_x = camera_get_view_x(view_camera[0]) + left_padding;
var total_height = (op_length - 1) * op_space + font_get_size(fnt_main_outline_shade) * 0.5;
start_y = camera_get_view_y(view_camera[0]) + (_view_height / 2) - (total_height / 2) + vertical_offset; // Adjusted with offset

// Keyboard navigation
var _new_pos = pos;
if (key_down) _new_pos++;
if (key_up) _new_pos--;

// Handle wrap-around navigation
if(_new_pos >= op_length){
    _new_pos = 0;
}
if(_new_pos < 0){
    _new_pos = op_length - 1;
}

// Mouse hover detection
var _mouse_over_option = -1;
hovering = false; // Reset hover state

for (var _i = 0; _i < op_length; _i++) {
    var _option_x = start_x;
    var _option_y = start_y + op_space * _i;
    var _display_text = option[menu_level, _i];
    var _option_w = string_width(_display_text) * 0.5; // Scale by 0.5 as in draw
    var _option_h = font_get_size(fnt_main_outline_shade) * 0.5;

    // Check if mouse is within the bounding box of this option
    if (_mouse_x_pos >= _option_x && 
        _mouse_x_pos <= _option_x + _option_w && 
        _mouse_y_pos >= _option_y && 
        _mouse_y_pos <= _option_y + _option_h) {
        _mouse_over_option = _i;
        hovering = true;
        break;
    }
}

// Update pos based on latest action
var _old_pos = pos;

if (_mouse_over_option != -1 && !menu_locked) {
    pos = _mouse_over_option;
} else if ((key_up || key_down) && !menu_locked) {
    pos = _new_pos;
}

// Play hover sound if position changed
if (pos != _old_pos && !menu_locked) {
    audio_play_sound(snd_hover, 0, false);
}

// Interaction detection (keyboard or mouse)
var _interaction_detected = (key_space_pressed) || (mouse_left_pressed && hovering);

if (_interaction_detected && !menu_locked) {    
    // Handle menu selections - simplified now that we only have main menu
    switch (pos) {
        case 0: // New Game
            menu_locked = true;
            // Stop the current music
            if (current_track_id != noone) {
                audio_stop_sound(current_track_id);
                current_track_id = noone;
            }
            // Create transition with next_room action
            var trans = instance_create_layer(0, 0, "Instances", obj_transition);
            trans.target_action = "next_room";
            break;
        case 1: // Exit (Touch Some Grass)
            // Stop the current music
            if (current_track_id != noone) {
                audio_stop_sound(current_track_id);
                current_track_id = noone;
            }
            game_end(); 
            break;
    }
}

// Music playlist management
if (!music_initialized) {
    // Start the first track only once
    current_track_id = audio_play_sound(playlist[current_track_index], 10, false);
    music_initialized = true;
} 
else if (!audio_is_playing(current_track_id)) {
    // Current track finished, move to next track
    current_track_index++;
    
    // If we've reached the end of the playlist, reshuffle and start over
    if (current_track_index >= playlist_size) {
        current_track_index = 0;
        shuffle_playlist();
    }
    
    // Play the next track
    current_track_id = audio_play_sound(playlist[current_track_index], 10, false);
}
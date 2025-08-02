/// @description Handle menu logic

// Load Controls
get_controls();

// Mouse input checks
var _mouse_x_pos = device_mouse_x(0);
var _mouse_y_pos = device_mouse_y(0);

// Update options length for current menu level
options_count = array_length(option[menu_level]);

// Calculate view dimensions
var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

// Calculate starting positions for left-aligned text
menu_start_x = camera_get_view_x(view_camera[0]) + (_view_width * MENU_LEFT_PADDING_RATIO);
var _total_menu_height = (options_count - 1) * MENU_OPTION_SPACING + font_get_size(fnt_main_outline_shade) * TEXT_SCALE;
menu_start_y = camera_get_view_y(view_camera[0]) + (_view_height / 2) - (_total_menu_height / 2) + MENU_VERTICAL_OFFSET;

// Precalculate option dimensions if not done already
if (array_length(option_dimensions) != options_count) {
    draw_set_font(fnt_main_outline_shade);
    for (var _i = 0; _i < options_count; _i++) {
        var _display_text = option[menu_level, _i];
        option_dimensions[_i] = {
            width: string_width(_display_text) * TEXT_SCALE,
            height: font_get_size(fnt_main_outline_shade) * TEXT_SCALE
        };
    }
}

// Keyboard navigation
var _new_option = selected_option;
if (key_down) _new_option++;
if (key_up) _new_option--;

// Handle wrap-around navigation
if(_new_option >= options_count){
    _new_option = 0;
}
if(_new_option < 0){
    _new_option = options_count - 1;
}

// Mouse hover detection
var _mouse_over_option = -1;
hovering = false; // Reset hover state

for (var _i = 0; _i < options_count; _i++) {
    var _option_x = menu_start_x;
    var _option_y = menu_start_y + MENU_OPTION_SPACING * _i;
    
    // Check if mouse is within the bounding box of this option
    if (_mouse_x_pos >= _option_x && 
        _mouse_x_pos <= _option_x + option_dimensions[_i].width && 
        _mouse_y_pos >= _option_y && 
        _mouse_y_pos <= _option_y + option_dimensions[_i].height) {
        _mouse_over_option = _i;
        hovering = true;
        break;
    }
}

// Update selected option based on latest action
var _old_option = selected_option;

if (_mouse_over_option != -1 && !menu_locked) {
    selected_option = _mouse_over_option;
} else if ((key_up || key_down) && !menu_locked) {
    selected_option = _new_option;
}

// Play hover sound if position changed
if (selected_option != _old_option && !menu_locked) {
    audio_play_sound(snd_hover, MENU_PRIORITY_NORMAL, false);
}

// Interaction detection (keyboard or mouse)
var _interaction_detected = (key_action_pressed && hovering);

if (_interaction_detected && !menu_locked) {    
    // Handle menu selections - simplified now that we only have main menu
    switch (selected_option) {
        case 0: // New Game
            menu_locked = true;
            // Create transition with next_room action, but only if one hasn't been created yet
            if (!transition_created) {
                var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                trans.target_action = "next_room";
                transition_created = true; // Set flag to prevent creating multiple transitions
            }
            break;
        case 1: // Exit (Touch Some Grass)
            game_end(); 
            break;
    }
}
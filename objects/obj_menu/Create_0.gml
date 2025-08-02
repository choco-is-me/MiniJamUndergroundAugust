/// @description Initialize menu controller

// Control Setup
window_set_cursor(cr_none);

// Audio Setup
audio_sound_set_track_position(snd_hover, 0);

// Constants
#macro CURSOR_SCALE 2
#macro MENU_OPTION_SPACING 20
#macro MENU_VERTICAL_OFFSET 20
#macro TEXT_SCALE 0.5
#macro MENU_LEFT_PADDING_RATIO 0.2 // One-fifth of screen width
#macro MENU_PRIORITY_NORMAL 0 // Audio priority

// Cursor variables
hovering = false;

// Menu state
selected_option = 0;
menu_locked = false;
menu_level = 0;
options_count = 0; 
transition_created = false; // Add flag to track if transition was already created

// Menu positions
menu_start_x = 0;
menu_start_y = 0;

// Menu options setup - only main menu now
option[0, 0] = "New Game";
option[0, 1] = "Touch Some Grass";

// Pre-calculate option widths and heights for collision detection
option_dimensions = array_create(0);
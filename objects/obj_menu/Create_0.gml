// Control Setup
window_set_cursor(cr_none);

// Audio Setup
audio_sound_set_track_position(snd_hover, 0);

// Cursor variables
hovering = false;
cursor_scale_x = 2;
cursor_scale_y = 2;

// Menu dimensions
op_border = 100; // Keeping this for potential padding adjustments, though not used directly now
op_space = 20;   // Vertical spacing between options
vertical_offset = 20; // Moves the menu down by 20 pixels

// New variables for text positioning
start_x = 0;
start_y = 0;

// Menu state
pos = 0;
menu_locked = false;
menu_level = 0;
op_length = 0; 

// Menu options setup - only main menu now
option[0, 0] = "New Game";
option[0, 1] = "Touch Some Grass";
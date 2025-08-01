randomize(); // Seed the random number generator for true randomness
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
menu_level = 0; // Keep only one menu level since settings is removed
op_length = 0;  // Will be set in Step Event

// Menu options setup - only main menu now
option[0, 0] = "New Game";
option[0, 1] = "Touch Some Grass"; // Now this is option 1 instead of 2

// Music playlist setup
playlist = [snd_below_and_above, snd_french_meme_song, snd_fireflies, snd_home, snd_french_meme_song, snd_french_meme_song];
playlist_size = array_length(playlist);
current_track_index = 0;
current_track_id = noone; // To store the actual playing audio instance
music_initialized = false;

// Shuffle the playlist
shuffle_playlist = function() {
    // Fisher-Yates shuffle algorithm
    for (var i = playlist_size - 1; i > 0; i--) {
        var j = irandom(i);
        var temp = playlist[i];
        playlist[i] = playlist[j];
        playlist[j] = temp;
    }
}

// Initial shuffle
shuffle_playlist();
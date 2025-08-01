// Room Start
// Reset the room completion flag when entering a new room
room_complete_played = false;
// Set the gameplay room flag based on the current room
// This determines if we should check for enemy completion in this room
in_gameplay_room = (room != rm_menu && room != initialization_room);

// Check if we're in the menu
if (room == rm_menu) {
    in_menu = true;
    
    // Stop game music if it's playing
    if (game_music_id != noone) {
        if (audio_is_playing(game_music_id)) {
            audio_stop_sound(game_music_id);
        }
        game_music_id = noone;
    }
} else {
    in_menu = false;
    
    // Start game music if not already playing
    if (game_music_id == noone) {
        game_music_id = audio_play_sound(game_music_sound, 5, true);
    }
}
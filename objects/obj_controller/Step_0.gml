// Step
get_controls();
if (key_fullscreen_pressed) {
    window_set_fullscreen(!window_get_fullscreen());
}

// Check if all enemies are defeated and sound hasn't been played yet
if (in_gameplay_room && !room_complete_played && !instance_exists(obj_all_enemies)) {
    audio_play_sound(snd_room_complete, 10, false);
    room_complete_played = true;
}
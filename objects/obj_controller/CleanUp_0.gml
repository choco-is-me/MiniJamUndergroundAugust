// Clean up
// Clean up all fonts and musics
for (var i = 0; i < array_length(font_list); i++) {
    if (font_exists(font_list[i])) {
        font_delete(font_list[i]);
    }
}

if (game_music_id != noone) {
    if (audio_is_playing(game_music_id)) {
        audio_stop_sound(game_music_id);
    }
}
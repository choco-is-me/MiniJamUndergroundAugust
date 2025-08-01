// Step
if (!audio_group_is_loaded(licensed_sound))
{
    audio_group_load(licensed_sound);
}

// Only go to next room when BOTH video has ended AND audio is loaded
if (video_has_ended && music_and_sound_loaded()) {
    room_goto_next();
}
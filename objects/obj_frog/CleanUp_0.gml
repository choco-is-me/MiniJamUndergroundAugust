// Clean up
// Stop all active sounds related to this object to prevent memory leaks
if (audio_charging_playing) {
    audio_stop_sound(audio_charging);
}

// Optional: stop any other potential sounds that might be playing
// Only needed if sounds could still be playing when object is destroyed
var sound_ids = [snd_frog_charging, snd_frog_jump, snd_hit, snd_dead, snd_frog_attack];
for (var i = 0; i < array_length(sound_ids); i++) {
    if (audio_is_playing(sound_ids[i])) {
        audio_stop_sound(sound_ids[i]);
    }
}
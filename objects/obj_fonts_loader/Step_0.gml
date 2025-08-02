/// @description Check audio loading status and progress to next room when ready

// Load audio groups if needed
if (!audio_group_is_loaded(licensed_sound)) {
    audio_group_load(licensed_sound);
}

// Only create transition when BOTH video has ended AND audio is loaded
if (video_has_ended && music_and_sound_loaded() && !transition_created) {
    // Create transition with next_room action instead of directly going to next room
    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
    trans.target_action = "next_room";
    transition_created = true; // Set flag to prevent creating multiple transitions
}
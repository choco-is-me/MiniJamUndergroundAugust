/// @description Handle video playback events and errors

var _type = async_load[? "type"];

if (_type == "video_start") {
    // Video has started playing
    video_is_playing = true;
} else if (_type == "video_end") {
    // Video has finished playing
    video_is_playing = false;
    video_has_ended = true;
    // Don't close the video yet - we'll do that in the Clean Up event
} else if (_type == "video_error") {
    // Handle video errors
    show_debug_message("Video error: " + string(async_load[? "errortext"]));
    video_is_playing = false;
    video_has_ended = true;
    video_close();  // In case of error, we can close it immediately
}
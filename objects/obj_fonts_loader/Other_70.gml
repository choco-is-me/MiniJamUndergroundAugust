var _type = async_load[? "type"];

if (_type == "video_start") {
    // Video has started playing
    video_is_playing = true;
}
else if (_type == "video_end") {
    // Video has finished playing
    video_is_playing = false;
    video_has_ended = true;
    video_close();  // Clean up video resources
}
/// @description Clean up video resources

// Close the video when the object is destroyed (which happens when changing rooms)
if (video_get_status() != video_status_closed) {
    video_close();
}
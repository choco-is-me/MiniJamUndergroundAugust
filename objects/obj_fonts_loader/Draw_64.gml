/// @description Draw splash video centered on screen with offsets

// Draw the video in the Draw GUI event to ensure it appears on top of everything else
if (video_is_playing) {
    var _data = video_draw();
    var _status = _data[0];
    
    if (_status == 0 && video_get_status() == video_status_playing) {
        var _surface = _data[1];
        
        // Check if surface exists before trying to draw it
        if (surface_exists(_surface)) {
            // Get surface dimensions
            var _width = surface_get_width(_surface);
            var _height = surface_get_height(_surface);
            
            // Calculate position to center on screen and apply offsets
            var _x = (display_get_gui_width() - _width) / 2 + VIDEO_X_OFFSET;
            var _y = (display_get_gui_height() - _height) / 2 + VIDEO_Y_OFFSET;
            
            // Draw the video surface at the adjusted position
            draw_surface(_surface, _x, _y);
        }
    }
}
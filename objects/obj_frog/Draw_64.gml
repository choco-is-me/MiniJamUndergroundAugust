// Draw GUI Event
if (sprite_exists(spr_health_bar)) {
    // Scale factors (adjust these to make it bigger)
    var scale_x = 7.0;  // 2x width
    var scale_y = 7.0;  // 2x height
    
    // Draw at top of screen with scaling
    draw_sprite_ext(
        spr_health_bar,    // Sprite
        health_bar_frame,  // Frame/subimg
        120,                // X position
        80,                // Y position
        scale_x,           // X scale (increase to make wider)
        scale_y,           // Y scale (increase to make taller)
        0,                 // Rotation (0 = no rotation)
        c_white,           // Color (white = no tint)
        1                  // Alpha (1 = fully opaque)
    );
}
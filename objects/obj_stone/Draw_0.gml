/// @description Draw resource and outline if in range

// Draw the sprite normally
draw_self();

// If in mining range, draw white outline
if (in_mining_range) {
    // Draw a simple white highlight using primitive drawing
    draw_set_color(c_white);
    
    // Top line
    draw_line(x - sprite_width/2 - 1, y - sprite_height/2 - 1, x + sprite_width/2, y - sprite_height/2 - 1);
    
    // Bottom line
    draw_line(x - sprite_width/2 - 1, y + sprite_height/2, x + sprite_width/2, y + sprite_height/2);
    
    // Left line
    draw_line(x - sprite_width/2 - 1, y - sprite_height/2 - 1, x - sprite_width/2 - 1, y + sprite_height/2);
    
    // Right line
    draw_line(x + sprite_width/2, y - sprite_height/2 - 1, x + sprite_width/2, y + sprite_height/2);
    
    // Reset draw color
    draw_set_color(c_black);
}
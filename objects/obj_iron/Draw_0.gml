/// @description Draw resource and outline if in range

// Draw the sprite with shake offset if active
draw_sprite(sprite_index, image_index, x + x_offset, y + y_offset);

// If in mining range, draw white outline
if (in_mining_range) {
    // Account for shake in outline position
    var outline_x = x + x_offset;
    var outline_y = y + y_offset;
    
    // Draw a simple white highlight using primitive drawing
    draw_set_color(c_white);
    
    // Top line
    draw_line(outline_x - sprite_width/2 - 1, outline_y - sprite_height/2 - 1, 
              outline_x + sprite_width/2, outline_y - sprite_height/2 - 1);
    
    // Bottom line
    draw_line(outline_x - sprite_width/2 - 1, outline_y + sprite_height/2, 
              outline_x + sprite_width/2, outline_y + sprite_height/2);
    
    // Left line
    draw_line(outline_x - sprite_width/2 - 1, outline_y - sprite_height/2 - 1, 
              outline_x - sprite_width/2 - 1, outline_y + sprite_height/2);
    
    // Right line
    draw_line(outline_x + sprite_width/2, outline_y - sprite_height/2 - 1, 
              outline_x + sprite_width/2, outline_y + sprite_height/2);
    
    // Reset draw color
    draw_set_color(c_black);
}
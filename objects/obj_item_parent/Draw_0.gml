/// @description Draw item with float effect

// Apply floating effect to y position for drawing
var float_y = y + sin(float_offset) * float_amount;

// Draw the sprite
draw_sprite(sprite_index, image_index, x, float_y);
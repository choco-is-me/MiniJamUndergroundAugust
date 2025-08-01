/// @description Draw cursor on GUI layer

// Get mouse position in GUI coordinates
var _mouse_x = device_mouse_x_to_gui(0);
var _mouse_y = device_mouse_y_to_gui(0);

// Draw appropriate cursor sprite based on hovering state
var _cursor_sprite = hovering ? spr_cursor_hover : spr_cursor_idle;
draw_sprite_ext(
    _cursor_sprite, 
    0, 
    _mouse_x, 
    _mouse_y, 
    CURSOR_SCALE, 
    CURSOR_SCALE, 
    0, 
    c_white, 
    1
);
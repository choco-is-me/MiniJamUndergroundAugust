// Draw
draw_set_font(fnt_main_outline_shade);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

for(var _i = 0; _i < op_length; _i++){
    var _color = #ecebe7;
    var _display_text = option[menu_level, _i];
    
    if(pos == _i){
        draw_set_font(fnt_main_outline_glow);
        _color = #cbc6c1;
    } else {
        draw_set_font(fnt_main_outline);
    }
    
    // Draw text at the calculated positions
    draw_text_transformed_colour(start_x, start_y + op_space * _i, _display_text, 0.5, 0.5, 0, _color, _color, _color, _color, 1);
}
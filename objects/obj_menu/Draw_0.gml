/// @description Draw menu options and cursor

// Define color constants
#macro COLOR_OPTION_NORMAL $ecebe7
#macro COLOR_OPTION_SELECTED $cbc6c1

// Draw menu options
draw_set_valign(fa_top);
draw_set_halign(fa_left);

for(var _i = 0; _i < options_count; _i++){
    var _color = COLOR_OPTION_NORMAL;
    var _display_text = option[menu_level, _i];
    
    if(selected_option == _i){
        draw_set_font(fnt_main_outline_glow);
        _color = COLOR_OPTION_SELECTED;
    } else {
        draw_set_font(fnt_main_outline);
    }
    
    // Draw text at the calculated positions
    draw_text_transformed_colour(
        menu_start_x, 
        menu_start_y + MENU_OPTION_SPACING * _i, 
        _display_text, 
        TEXT_SCALE, 
        TEXT_SCALE, 
        0, 
        _color, _color, _color, _color, 
        1
    );
}
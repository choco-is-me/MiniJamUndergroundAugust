/// @description Draw resource counters in GUI

// Constants for the resource counter display
#macro RESOURCE_DISPLAY_MARGIN 20       // Margin from screen edges
#macro RESOURCE_DISPLAY_SPACING 32      // Vertical spacing between items
#macro RESOURCE_SPRITE_SCALE 6.0        // Scale for resource sprites
#macro RESOURCE_TEXT_SCALE 1.6          // Scale for text
#macro SPRITE_TEXT_GAP 15               // Space between sprite and text
#macro X_NUMBER_GAP 12                  // Gap between "x" and the number

// Set up the drawing properties
draw_set_font(fnt_main_outline);
draw_set_valign(fa_middle);

// Calculate base position
var base_x = RESOURCE_DISPLAY_MARGIN;
var base_y = display_get_gui_height() - RESOURCE_DISPLAY_MARGIN;

// Define resources to display
var resource_sprites = [spr_stone_item, spr_iron_item, spr_gold_item, spr_diamond_item];
var resource_counts = [stone_count, iron_count, gold_count, diamond_count];

// Find maximum sprite width for centering
var max_sprite_width = 0;
for (var i = 0; i < array_length(resource_sprites); i++) {
    var current_width = sprite_get_width(resource_sprites[i]);
    if (current_width > max_sprite_width) {
        max_sprite_width = current_width;
    }
}

// Calculate consistent positions for alignment
var sprite_center_x = base_x + (max_sprite_width * RESOURCE_SPRITE_SCALE / 2);
var text_x_pos = base_x + (max_sprite_width * RESOURCE_SPRITE_SCALE) + SPRITE_TEXT_GAP;
var number_x_pos = text_x_pos + X_NUMBER_GAP;

// Draw each resource item and count
var current_y = base_y - (array_length(resource_sprites) * (sprite_get_height(resource_sprites[0]) * RESOURCE_SPRITE_SCALE + RESOURCE_DISPLAY_SPACING)) + RESOURCE_DISPLAY_SPACING;

for (var i = 0; i < array_length(resource_sprites); i++) {
    var sprite = resource_sprites[i];
    var count = resource_counts[i];
    
    // Center the sprite based on its width relative to the max width
    var sprite_offset = (max_sprite_width - sprite_get_width(sprite)) * RESOURCE_SPRITE_SCALE / 2;
    
    // Draw the sprite (centered)
    draw_sprite_ext(
        sprite,
        0,  // Image index
        sprite_center_x - sprite_offset,  // Center position with offset for different sized sprites
        current_y,
        RESOURCE_SPRITE_SCALE,
        RESOURCE_SPRITE_SCALE,
        0,
        c_white,
        1
    );
    
    // Draw the "x" symbol (aligned vertically across all rows)
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text_transformed(
        text_x_pos,
        current_y,
        "x",
        RESOURCE_TEXT_SCALE,
        RESOURCE_TEXT_SCALE,
        0
    );
    
    // Draw the count number (aligned vertically across all rows)
    draw_set_halign(fa_left);
    draw_text_transformed(
        number_x_pos,
        current_y,
        string(count),
        RESOURCE_TEXT_SCALE,
        RESOURCE_TEXT_SCALE,
        0
    );
    
    // Update Y position for next resource
    current_y += sprite_get_height(sprite) * RESOURCE_SPRITE_SCALE + RESOURCE_DISPLAY_SPACING;
}

// Calculate the position for the pickaxe upgrade button
var upgrade_button_scale = 6.0;
var button_frame = floor(button_anim_frame);

// Draw the pickaxe upgrade button if an upgrade is available
if (is_pickaxe_upgrade_available()) {
    // Position the button centered above the resource counters with more distance
    var resources_top_y = base_y - (array_length(resource_sprites) * (sprite_get_height(resource_sprites[0]) * RESOURCE_SPRITE_SCALE + RESOURCE_DISPLAY_SPACING));
    var button_y = resources_top_y - 50; // Adjusted: Increased space above the resources
    var button_x = sprite_center_x;
    var button_y_float = sin(current_time / 500) * 3; // Small floating effect
    
    draw_sprite_ext(
        spr_pickaxe_button,
        button_frame,
        button_x,
        button_y + button_y_float,
        upgrade_button_scale,
        upgrade_button_scale,
        0,
        c_white,
        1
    );
}

// Reset drawing properties
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
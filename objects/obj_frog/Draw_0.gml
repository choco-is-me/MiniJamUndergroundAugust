// Draw
// Calculate head offset based on state and current body sprite
var head_offset = -6; // Default for 7px height sprites (idle, hop)
if (state == "Charging" && current_body_sprite == spr_frog_prehop_body) {
    head_offset = -4; // For prehop with shorter sprite
} else if (current_body_sprite == spr_frog_idle_body || current_body_sprite == spr_frog_hop_body) {
    head_offset = -6; // For 7px height sprites
} else if (state == "Attack") {
    head_offset = -6; // For attack sprites - adjust as needed based on your sprites
} else if (state == "Damaged") {
    head_offset = -7; // For damaged sprite - 10px height head on 7px body
} else if (state == "Dead") {
    head_offset = -8; // For dead sprite - 9px height head on 7px body
}

// Draw frog body and head with alpha for death fade, flipping based on 'facing'
if (sprite_exists(current_body_sprite)) {
    draw_sprite_ext(current_body_sprite, image_index, x, y, facing, 1, 0, c_white, death_alpha);
}
if (sprite_exists(current_head_sprite)) {
    draw_sprite_ext(current_head_sprite, image_index, x, y + head_offset, facing, 1, 0, c_white, death_alpha);
}

// Draw oscillating arrow (not during damaged or dead state)
if (state != "Attack" && state != "Damaged" && state != "Dead") {
    var arrow_x = x + lengthdir_x(arrow_distance, arrow_angle);
    var arrow_y = y + lengthdir_y(arrow_distance, arrow_angle);
    
    // Arrow sprite points bottom-right by default (315° in GameMaker's angle system)
    // To make it point in the direction of arrow_angle, add 315°
    draw_sprite_ext(spr_arrow, 0, arrow_x, arrow_y, 1, 1, arrow_angle + 55, c_white, 1);
}

// Draw tongue if active
if (tongue_active && state == "Attack") {
    // Calculate tongue origin position at the frog's mouth
    var tongue_origin_x = x + facing * 0.5; 
    var tongue_origin_y = y + head_offset - 3.5; 
    
    // Calculate tongue body direction and length
    var tongue_dir_x = lengthdir_x(1, tongue_angle);
    var tongue_dir_y = lengthdir_y(1, tongue_angle);
    
    // Draw tongue body
    for (var i = 0; i < tongue_length; i++) {
        var segment_x = tongue_origin_x + tongue_dir_x * i;
        var segment_y = tongue_origin_y + tongue_dir_y * i;
        
        draw_sprite_ext(
            spr_frog_tongue_body, 0,
            segment_x, segment_y,
            1, 1,
            tongue_angle,
            c_white, 1
        );
    }
    
    // Draw tongue head
    var tongue_head_x = tongue_origin_x + tongue_dir_x * tongue_length;
    var tongue_head_y = tongue_origin_y + tongue_dir_y * tongue_length;
    
    draw_sprite_ext(
        spr_frog_tongue_head, 0,
        tongue_head_x, tongue_head_y,
        1, 1,
        tongue_angle,
        c_white, 1
    );
}

// Draw charge bar during Charging state
if (state == "Charging" && sprite_exists(spr_charge_bar)) {
    var charge_ratio = jump_charge / jump_charge_max;
    var number_of_charge_frames = sprite_get_number(spr_charge_bar);
    var frame_index = clamp(floor(charge_ratio * number_of_charge_frames), 0, number_of_charge_frames - 1);
    draw_sprite(spr_charge_bar, frame_index, x + 2, y - 16);
}
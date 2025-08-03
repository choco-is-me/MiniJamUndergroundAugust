/// @description Draw player and pickaxe

// Determine which sprite to use based on VISUAL state and facing
var sprite_to_use;

switch(visual_state) {
    case PLAYER_STATE.IDLE:
        sprite_to_use = spr_player_idle_right;
        break;
        
    case PLAYER_STATE.MOVING:
    case PLAYER_STATE.MINING: // Use move animation for mining too, pickaxe will be separate
        sprite_to_use = spr_player_move_right;
        break;
}

// Draw the player with correct facing
if (facing == PLAYER_FACING.LEFT) {
    draw_sprite_ext(sprite_to_use, image_index, x, y, -1, 1, 0, c_white, 1); // Flipped horizontally
} else {
    draw_sprite(sprite_to_use, image_index, x, y);
}

// Draw pickaxe - always visible but with different position/rotation based on state
var pickaxe_sprite;

// Select pickaxe sprite based on level
switch(pickaxe_level) {
    case PICKAXE_TYPE.WOOD:
        pickaxe_sprite = spr_pickaxe_wood;
        break;
    case PICKAXE_TYPE.STONE:
        pickaxe_sprite = spr_pickaxe_stone;
        break;
    case PICKAXE_TYPE.IRON:
        pickaxe_sprite = spr_pickaxe_iron;
        break;
    case PICKAXE_TYPE.GOLD:
        pickaxe_sprite = spr_pickaxe_gold;
        break;
    case PICKAXE_TYPE.PRISMATIC:
        pickaxe_sprite = spr_pickaxe_prismatic;
        break;
}

// Draw pickaxe differently based on state
if (state == PLAYER_STATE.MINING) {
    // Calculate animation frame for pickaxe during mining
    var pickaxe_frames = sprite_get_number(pickaxe_sprite);
    var pickaxe_frame = floor((mining_timer / MINING_DURATION) * pickaxe_frames);
    if (pickaxe_frame >= pickaxe_frames) pickaxe_frame = pickaxe_frames - 1;
    
    // Draw the pickaxe rotated near the player's hand
    var dir_mult = (facing == PLAYER_FACING.RIGHT) ? 1 : -1;
    var offset_x = dir_mult * 8; // Offset from player center to appear in hand
    
    draw_sprite_ext(
        pickaxe_sprite, 
        pickaxe_frame, 
        x + offset_x, // Position offset from player to look like it's in hand
        y - 2, // Slight vertical offset
        dir_mult, 1, // Scale (flipped based on facing)
        pickaxe_angle, // Rotation angle calculated during mining process
        c_white, 1
    );
} else {
    // Normal idle pickaxe
    var dir_mult = (facing == PLAYER_FACING.RIGHT) ? 1 : -1;
    var offset_x = dir_mult * 8; // Offset from player center to appear in hand
    
    draw_sprite_ext(
        pickaxe_sprite, 
        0, // Default frame
        x + offset_x, 
        y - 2, // Slight vertical offset
        dir_mult, 1, // Scale (flipped based on facing)
        0, // No rotation when idle
        c_white, 1
    );
}

// Draw Tab button indicator above player if upgrade is available
if (is_pickaxe_upgrade_available()) {
    var button_frame = floor(button_anim_frame);
    var button_y_offset = -13; // Adjusted: Reduced offset to move closer to player's head
    var button_y_float = sin(current_time / 500) * 3; // Small floating effect
    
    draw_sprite(
        spr_tab_button, 
        button_frame, 
        x, 
        y + button_y_offset + button_y_float
    );
}
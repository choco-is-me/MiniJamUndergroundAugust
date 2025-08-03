/// @description Draw player and pickaxe

// Determine which sprite to use based on state and facing
var sprite_to_use;

switch(state) {
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

// Draw pickaxe when mining
if (state == PLAYER_STATE.MINING && mining_target != noone) {
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
    
    // Calculate animation frame for pickaxe
    var pickaxe_frames = sprite_get_number(pickaxe_sprite);
    var pickaxe_frame = floor((mining_timer / MINING_DURATION) * pickaxe_frames);
    if (pickaxe_frame >= pickaxe_frames) pickaxe_frame = pickaxe_frames - 1;
    
    // Calculate position offset for pickaxe based on facing
    var offset_x = (facing == PLAYER_FACING.RIGHT) ? 16 : -16;
    
    // Draw the pickaxe
    if (facing == PLAYER_FACING.LEFT) {
        draw_sprite_ext(pickaxe_sprite, pickaxe_frame, x + offset_x, y, -1, 1, 0, c_white, 1);
    } else {
        draw_sprite(pickaxe_sprite, pickaxe_frame, x + offset_x, y);
    }
}

show_debug_message(stone_count)
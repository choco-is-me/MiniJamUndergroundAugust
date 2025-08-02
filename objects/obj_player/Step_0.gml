/// @description Handle player state, movement, and actions

// Get player input
get_controls();

// State machine
switch(state) {
    case PLAYER_STATE.IDLE:
        process_idle_state();
        break;
    case PLAYER_STATE.MOVING:
        process_movement_state();
        break;
    case PLAYER_STATE.MINING:
        process_mining_state();
        break;
}

// Handle pickaxe upgrades regardless of state
if (key_upgrade_pickaxe) {
    attempt_pickaxe_upgrade();
}

// Update animation
update_animation();
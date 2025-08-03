/// @description Handle player state, movement, and actions

// Get player input
get_controls();

// Update action cooldown
update_action_cooldown();

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

// Mark resources in range to display outline
mark_resources_in_range();
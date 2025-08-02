function get_controls(){
    if (global.input_locked) {
        key_left = 0;
        key_left_hold = 0;
        
        key_right = 0;
        key_right_hold = 0;
        
        key_up = 0;
        key_up_hold = 0;
        
        key_down = 0;
        key_down_hold = 0;
        
        key_action_pressed = 0;
        key_action_held = 0;
        
        key_interact_pressed = 0;
        key_interact_held = 0;
        
        key_pause_pressed = 0;
        key_fullscreen_pressed = 0;
        
        key_upgrade_pickaxe = 0; // Added new key variable
        return;
    }
    
    // Movement controls - both pressed and held states
    key_left = InputPressed(INPUT_VERB.LEFT);
    key_left_hold = InputCheck(INPUT_VERB.LEFT);
    
    key_right = InputPressed(INPUT_VERB.RIGHT);
    key_right_hold = InputCheck(INPUT_VERB.RIGHT);
    
    key_up = InputPressed(INPUT_VERB.UP);
    key_up_hold = InputCheck(INPUT_VERB.UP);
    
    key_down = InputPressed(INPUT_VERB.DOWN);
    key_down_hold = InputCheck(INPUT_VERB.DOWN);
    
    // Action controls for mining
    key_action_pressed = InputPressed(INPUT_VERB.ACTION_PRESSED);
    key_action_held = InputCheck(INPUT_VERB.ACTION_HELD);
    
    // Interaction controls for doors, NPCs, etc.
    key_interact_pressed = InputPressed(INPUT_VERB.INTERACT_PRESSED);
    key_interact_held = InputCheck(INPUT_VERB.INTERACT_HELD);
    
    // System controls
    key_pause_pressed = InputPressed(INPUT_VERB.PAUSE);
    key_fullscreen_pressed = InputPressed(INPUT_VERB.FULLSCREEN);
    
    // Pickaxe upgrade control - typically want this as a pressed action, not held
    key_upgrade_pickaxe = InputPressed(INPUT_VERB.UPGRADE_PICKAXE);
}
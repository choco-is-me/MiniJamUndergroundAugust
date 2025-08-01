function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        UP,
        DOWN,
        LEFT,
        RIGHT,
        ACTION_PRESSED,
        ACTION_HELD,
        INTERACT_PRESSED,
        INTERACT_HELD,
        PAUSE,
        FULLSCREEN
    }
    
    enum INPUT_CLUSTER
    {
        NAVIGATION,
    }
    
    // Movement controls
    InputDefineVerb(INPUT_VERB.UP,              "up",              ["W", vk_up],       [-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,            "down",            ["S", vk_down],     [gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,            "left",            ["A", vk_left],     [-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,           "right",           ["D", vk_right],    [gp_axislh, gp_padr]);
    
    // Action controls (mining) - Left mouse button, space bar, and right shoulder button on gamepad
    InputDefineVerb(INPUT_VERB.ACTION_PRESSED,  "action_pressed",  mb_left,            gp_shoulderrb);
    InputDefineVerb(INPUT_VERB.ACTION_HELD,     "action_held",     mb_left,            gp_shoulderrb);
    
    // Interaction controls (doors, NPCs) - E key and X button on gamepad
    InputDefineVerb(INPUT_VERB.INTERACT_PRESSED,"interact_pressed","E",                gp_face1);
    InputDefineVerb(INPUT_VERB.INTERACT_HELD,   "interact_held",   "E",                gp_face1);
    
    // Pause functionality
    InputDefineVerb(INPUT_VERB.PAUSE,           "pause",           vk_escape,          gp_start);
    
    // Fullscreen toggle - F11 on keyboard, no mapping for controller
    InputDefineVerb(INPUT_VERB.FULLSCREEN,      "fullscreen",      vk_f11,             undefined);
    
    // Define the NAVIGATION cluster
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
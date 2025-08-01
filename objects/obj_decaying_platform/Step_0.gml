// Step
if (place_meeting(x, y - 1, obj_frog)) {
    stand_timer += 1;
    
    // Linear fade from 1 to 0 as timer progresses
    alpha = 1 - (stand_timer / break_time);
    
    if (stand_timer >= break_time) {
        // Create the non-solid version at the same position
        var new_platform = instance_create_layer(x, y, layer, obj_decaying_platform_nonsolid);
        // Transfer properties
        new_platform.sprite_index = sprite_index;
        new_platform.image_index = image_index;
        new_platform.image_xscale = image_xscale;
        new_platform.image_yscale = image_yscale;
        new_platform.image_angle = image_angle;
        
        // Destroy this instance
        instance_destroy();
    }
} else {
    stand_timer = 0;
    alpha = 1;
}
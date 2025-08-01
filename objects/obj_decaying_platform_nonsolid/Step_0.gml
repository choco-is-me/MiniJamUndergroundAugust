// Step
inactive_timer += 1;

if (inactive_timer >= reactivate_time) {
    // Create the solid version at the same position
    var new_platform = instance_create_layer(x, y, layer, obj_decaying_platform);
    // Transfer properties
    new_platform.sprite_index = spr_decaying_platform_16_48;
    new_platform.image_index = image_index;
    new_platform.image_xscale = image_xscale;
    new_platform.image_yscale = image_yscale;
    new_platform.image_angle = image_angle;
    
    // Destroy this instance
    instance_destroy();
}
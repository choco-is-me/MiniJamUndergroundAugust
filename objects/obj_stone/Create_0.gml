/// @description Initialize stone resource variables

// Resource properties
hp = 3; // Number of hits to break
required_pickaxe = PICKAXE_TYPE.WOOD; // Minimum pickaxe level needed
resource_name = "Stone";

/// @function hit_resource(pickaxe_level)
/// @param {real} pickaxe_level The level of the pickaxe hitting this resource
function hit_resource(pickaxe_level) {
    // Check if pickaxe is strong enough
    if (pickaxe_level >= required_pickaxe) {
        // Calculate damage based on pickaxe level
        // Higher level pickaxes do more damage
        var damage = 1;
        if (pickaxe_level > required_pickaxe) {
            damage = pickaxe_level - required_pickaxe + 1;
        }
        
        // Apply damage to resource
        hp -= damage;
        
        // Create hit effect/animation here if desired
        // (particle effects, sound, etc.)
        
        // Check if resource is broken
        if (hp <= 0) {
            // Check if the Items layer exists, create it if it doesn't
            var items_layer = layer_get_id("Items");
            if (items_layer == -1) {
                // Layer doesn't exist, create it above the instance layer
                items_layer = layer_create(depth - 100, "Items");
            }
            
            // Spawn 1-3 stone items when broken
            var item_count = irandom_range(1, 3);
            for (var i = 0; i < item_count; i++) {
                // Create with slight random offset
                var offset_x = random_range(-8, 8);
                var offset_y = random_range(-8, 8);
                instance_create_layer(x + offset_x, y + offset_y, items_layer, obj_stone_item);
            }
            
            // Destroy the resource
            instance_destroy();
        }
    } else {
        // Not strong enough pickaxe - create feedback
        // (could be a text popup, sound effect, etc.)
        show_debug_message("Need a better pickaxe to mine " + resource_name);
    }
}
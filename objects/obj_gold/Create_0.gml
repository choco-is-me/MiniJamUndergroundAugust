/// @description Initialize gold resource variables

// Constants for resource settings
#macro GOLD_MAX_HP 7
#macro GOLD_BASE_DAMAGE 1
#macro GOLD_FRAMES 1  // Max frame index (0-1, so value is 1)
#macro GOLD_NO_ANIMATION 0
#macro GOLD_DROP_OFFSET_MIN -8
#macro GOLD_DROP_OFFSET_MAX 8

// Constants for shake effect
#macro GOLD_SHAKE_DURATION 0.2    // Duration in seconds
#macro GOLD_SHAKE_INTENSITY 2     // Maximum shake offset in pixels

// Flag to track if this resource is in mining range of player
in_mining_range = false;

// Original sprite for reference when drawing the outline
original_sprite = sprite_index;

// Resource properties
hp = GOLD_MAX_HP; // Number of hits to break
required_pickaxe = PICKAXE_TYPE.IRON; // Minimum pickaxe level needed
resource_name = "Gold";

// Set random sprite frame for visual variety
image_index = irandom(GOLD_FRAMES); // Randomly select frame 0 or 1
image_speed = GOLD_NO_ANIMATION; // Stop animation to keep the selected frame

// Shake effect variables
shake_time_remaining = 0;
shake_intensity = 0;
x_offset = 0;
y_offset = 0;

/// @function hit_resource(pickaxe_level)
/// @param {real} pickaxe_level The level of the pickaxe hitting this resource
function hit_resource(pickaxe_level) {
    // Check if pickaxe is strong enough
    if (pickaxe_level >= required_pickaxe) {
        // Calculate damage based on pickaxe level
        // Higher level pickaxes do more damage
        var damage = GOLD_BASE_DAMAGE;
        if (pickaxe_level > required_pickaxe) {
            damage = pickaxe_level - required_pickaxe + GOLD_BASE_DAMAGE;
        }
        
        // Apply damage to resource
        hp -= damage;
        
        // Trigger shake effect
        shake_time_remaining = GOLD_SHAKE_DURATION;
        shake_intensity = GOLD_SHAKE_INTENSITY;
        
        // Check if resource is broken
        if (hp <= 0) {
            // Check if the Items layer exists, create it if it doesn't
            var items_layer = layer_get_id("Items");
            if (items_layer == -1) {
                // Layer doesn't exist, create it above the instance layer
                items_layer = layer_create(depth - ITEMS_LAYER_DEPTH_OFFSET, "Items");
            }
            
            // Spawn exactly 1 gold item when broken
            var offset_x = random_range(GOLD_DROP_OFFSET_MIN, GOLD_DROP_OFFSET_MAX);
            var offset_y = random_range(GOLD_DROP_OFFSET_MIN, GOLD_DROP_OFFSET_MAX);
            instance_create_layer(x + offset_x, y + offset_y, items_layer, obj_gold_item);
            
            // Destroy the resource
            instance_destroy();
        }
    } else {
        // Not strong enough pickaxe - create feedback
        show_debug_message("Need a better pickaxe to mine " + resource_name);
    }
}
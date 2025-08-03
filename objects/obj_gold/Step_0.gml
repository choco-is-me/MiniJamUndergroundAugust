/// @description Update shake effect

// Update shake effect
if (shake_time_remaining > 0) {
    // Calculate shake percentage (1.0 to 0.0)
    var shake_percent = shake_time_remaining / GOLD_SHAKE_DURATION;
    
    // Calculate current intensity based on remaining time
    var current_intensity = shake_intensity * shake_percent;
    
    // Generate random offsets
    x_offset = random_range(-current_intensity, current_intensity);
    y_offset = random_range(-current_intensity, current_intensity);
    
    // Reduce remaining shake time
    shake_time_remaining -= delta_time / 1000000; // Convert microseconds to seconds
    
    // Ensure shake_time_remaining doesn't go below 0
    if (shake_time_remaining < 0) {
        shake_time_remaining = 0;
        x_offset = 0;
        y_offset = 0;
    }
}
// 1. Countdown the timer
if (damage_timer > 0) {
    damage_timer -= delta_time;
}

// 2. Detect overlap via the object’s collision mask
var frog_inst = noone;
if (place_meeting(x, y, obj_frog)) {
    frog_inst = instance_place(x, y, obj_frog);
}

// 3. Deal damage and reset when cooldown has elapsed
if (frog_inst != noone && damage_timer <= 0) {
    with (frog_inst) {
        if (state != "Damaged" && state != "Dead") {
            take_damage(1);
        }
    }
    damage_timer = 2_500_000; // 2.5s in μs
}


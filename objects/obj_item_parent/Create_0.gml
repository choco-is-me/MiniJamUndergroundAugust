/// @description Initialize item variables

// Movement variables
hspd = 0;
vspd = 0;
move_speed = 0;
max_speed = 150.0; // Units per second
acceleration = 12.0; // Units per second squared

// Physics variables
bounce_factor = 0.5;
friction_factor = 0.95;

// State
is_attracted = false;

// Give initial random movement
var angle = random(360);
var initial_speed = 90.0; // Units per second
hspd = lengthdir_x(initial_speed, angle);
vspd = lengthdir_y(initial_speed, angle);

// Animation variables
image_speed = 0.2;
float_offset = 0;
float_speed = random_range(1.0, 3.0); // Radians per second
float_amount = random_range(2, 4);
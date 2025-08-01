// In the instance creation code or Room Editor
teleporter = instance_create_layer(x, y, "Instances", obj_teleporter);
teleporter.target_x = 463;
teleporter.target_y = 312;
teleporter.target_room = rm_swamp_9;
teleporter.target_facing = -1;
teleporter.fade_in_speed = 0.02;
teleporter.fade_out_speed = 0.03;
teleporter.delay = 45;
teleporter.automatic = true;  // Will activate when player steps on it
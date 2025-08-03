/// @description Initialize camera position on room start
if (!instance_exists(obj_player)) exit;

var _cam_width = camera_get_view_width(view_camera[0]);
var _cam_height = camera_get_view_height(view_camera[0]);

var _target_cam_x = obj_player.x - _cam_width * 0.5;
var _target_cam_y = obj_player.y - _cam_height * 0.5;

// Restrict camera to room boundaries
var _max_cam_x = max(0, room_width - _cam_width);
var _max_cam_y = max(0, room_height - _cam_height);

_target_cam_x = clamp(_target_cam_x, 0, _max_cam_x);
_target_cam_y = clamp(_target_cam_y, 0, _max_cam_y);

// Set camera position immediately without smoothing
final_cam_x = _target_cam_x;
final_cam_y = _target_cam_y;
camera_set_view_pos(view_camera[0], final_cam_x, final_cam_y);
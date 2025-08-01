// Create
global.input_locked = false;
font_list = [
    fnt_main,
    fnt_main_outline,
    fnt_main_glow,
    fnt_main_shade,
    fnt_main_outline_glow, 
    fnt_main_outline_shade,
    fnt_main_outline_shade_glow
];

// Music system variables
game_music_id = noone;
game_music_sound = snd_nature;
room_complete_played = false;
in_gameplay_room = false;
in_menu = (room == rm_menu);  // Check the initial room
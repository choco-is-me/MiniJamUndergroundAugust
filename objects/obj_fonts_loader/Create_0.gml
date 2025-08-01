// Create
// Video Load
video_has_ended = false;
video_is_playing = false;
video_surface = -1;

// Offset
video_x_offset = 50;  // Positive moves right, negative moves left
video_y_offset = -50;  // Positive moves down, negative moves up

// Open the splash screen video
video_open("spacecat_splash_screen.mp4");
// Don't loop the video - we only want it to play once
video_enable_loop(false);

// Font Load
font_enable_effects(fnt_main_outline, true, {
    outlineEnable: true,
    outlineDistance: 1,
    outlineColour: #586335
});

font_enable_effects(fnt_main_glow, true, {
    glowEnable: true,
    glowEnd: 6,
    glowColour: c_red,
    glowAlpha: 4
});

font_enable_effects(fnt_main_shade, true, {
    dropShadowEnable: true,
    dropShadowSoftness: 20,
    dropShadowOffsetX: 4,
    dropShadowOffsetY: 4,
    dropShadowAlpha: 1,
});

font_enable_effects(fnt_main_outline_glow, true, {
    outlineEnable: true,
    outlineDistance: 1,
    outlineColour: #333c24,
    glowEnable: true,
    glowEnd: 1,
    glowColour: c_white,
    glowAlpha: 4
});

font_enable_effects(fnt_main_outline_shade, true, {
    dropShadowEnable: true,
    dropShadowSoftness: 20,
    dropShadowOffsetX: 4,
    dropShadowOffsetY: 4,
    dropShadowAlpha: 1,
    outlineEnable: true,
    outlineDistance: 1,
    outlineColour: #586335,
});

font_enable_effects(fnt_main_outline_shade_glow, true, {
    dropShadowEnable: true,
    dropShadowSoftness: 20,
    dropShadowOffsetX: 4,
    dropShadowOffsetY: 4,
    dropShadowAlpha: 1,
    outlineEnable: true,
    outlineDistance: 1,
    outlineColour: #333c24,
    glowEnable: true,
    glowEnd: 5,
    glowColour: c_white,
    glowAlpha: 1
});
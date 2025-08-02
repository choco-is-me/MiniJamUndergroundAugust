/// @description Initialize splash screen, video and font effects

// Video Variables
video_has_ended = false;
video_is_playing = false;
video_surface = -1;
transition_created = false; // Add flag to track if transition was already created

// Video Position Constants
VIDEO_X_OFFSET = 50;  // Positive moves right, negative moves left
VIDEO_Y_OFFSET = -50;  // Positive moves down, negative moves up

// Font Effect Constants
OUTLINE_DISTANCE_SMALL = 1;
GLOW_END_SMALL = 1;
GLOW_END_MEDIUM = 5;
GLOW_END_LARGE = 6;
SHADOW_SOFTNESS = 20;
SHADOW_OFFSET = 4;
SHADOW_ALPHA = 1;
GLOW_ALPHA_STRONG = 4;
GLOW_ALPHA_NORMAL = 1;

// Color Constants
COLOR_OUTLINE_DARK = #333c24;
COLOR_OUTLINE_MEDIUM = #586335;

// Open the splash screen video
// We'll attempt to open the video directly and handle any errors in the Async event
try {
    video_open("spacecat_splash_screen.mp4");
    // Don't loop the video - we only want it to play once
    video_enable_loop(false);
} catch (e) {
    show_debug_message("Error trying to open splash video: " + string(e));
    video_has_ended = true; // Skip video if it fails
}

// Font Load
font_enable_effects(fnt_main_outline, true, {
    outlineEnable: true,
    outlineDistance: OUTLINE_DISTANCE_SMALL,
    outlineColour: COLOR_OUTLINE_MEDIUM
});

font_enable_effects(fnt_main_glow, true, {
    glowEnable: true,
    glowEnd: GLOW_END_LARGE,
    glowColour: c_red,
    glowAlpha: GLOW_ALPHA_STRONG
});

font_enable_effects(fnt_main_shade, true, {
    dropShadowEnable: true,
    dropShadowSoftness: SHADOW_SOFTNESS,
    dropShadowOffsetX: SHADOW_OFFSET,
    dropShadowOffsetY: SHADOW_OFFSET,
    dropShadowAlpha: SHADOW_ALPHA
});

font_enable_effects(fnt_main_outline_glow, true, {
    outlineEnable: true,
    outlineDistance: OUTLINE_DISTANCE_SMALL,
    outlineColour: COLOR_OUTLINE_DARK,
    glowEnable: true,
    glowEnd: GLOW_END_SMALL,
    glowColour: c_white,
    glowAlpha: GLOW_ALPHA_STRONG
});

font_enable_effects(fnt_main_outline_shade, true, {
    dropShadowEnable: true,
    dropShadowSoftness: SHADOW_SOFTNESS,
    dropShadowOffsetX: SHADOW_OFFSET,
    dropShadowOffsetY: SHADOW_OFFSET,
    dropShadowAlpha: SHADOW_ALPHA,
    outlineEnable: true,
    outlineDistance: OUTLINE_DISTANCE_SMALL,
    outlineColour: COLOR_OUTLINE_MEDIUM
});

font_enable_effects(fnt_main_outline_shade_glow, true, {
    dropShadowEnable: true,
    dropShadowSoftness: SHADOW_SOFTNESS,
    dropShadowOffsetX: SHADOW_OFFSET,
    dropShadowOffsetY: SHADOW_OFFSET,
    dropShadowAlpha: SHADOW_ALPHA,
    outlineEnable: true,
    outlineDistance: OUTLINE_DISTANCE_SMALL,
    outlineColour: COLOR_OUTLINE_DARK,
    glowEnable: true,
    glowEnd: GLOW_END_MEDIUM,
    glowColour: c_white,
    glowAlpha: GLOW_ALPHA_NORMAL
});
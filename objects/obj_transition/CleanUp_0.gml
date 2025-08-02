/// @description Clean up resources

// This event runs when the object is destroyed
// If transition is incomplete for some reason, ensure inputs are unlocked
if (global.input_locked) {
    global.input_locked = false;
}
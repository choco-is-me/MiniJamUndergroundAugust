/// @description Free resources
// Clean up all fonts
for (var i = 0; i < array_length(self.font_list); i++) {
    if (font_exists(self.font_list[i])) {
        font_delete(self.font_list[i]);
    }
}
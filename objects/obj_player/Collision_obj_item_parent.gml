/// @description Collect any resource item

// Determine which type of resource this is and add to inventory
if (other.object_index == obj_stone_item) {
    stone_count++;
}
else if (other.object_index == obj_iron_item) {
    iron_count++;
}
else if (other.object_index == obj_gold_item) {
    gold_count++;
}
else if (other.object_index == obj_diamond_item) {
    diamond_count++;
}

// Destroy the collected item
instance_destroy(other);
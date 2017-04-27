/// @description Create Event

hp = 10;
direction  = 90;
speed = 0;


//Tile map info
var collisionTiles = layer_get_id("CollisionMask");
tilemap = layer_tilemap_get_id(collisionTiles);

//splrite_info
sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
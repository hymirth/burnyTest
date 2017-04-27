/// @description Movement

speed = 0;

//Movement


if (keyboard_check(ord("D"))) {
	direction = 0;
	image_angle = point_direction(x, y, x+1, y);
	var t1 = tilemap_get_at_pixel(tilemap, bbox_right, y) & tile_index_mask;
	var t2 = tilemap_get_at_pixel(tilemap, bbox_right, bbox_top) & tile_index_mask;
	var t3 = tilemap_get_at_pixel(tilemap, bbox_right, bbox_bottom) & tile_index_mask;
	if (t1 != 0 || t2 != 0 || t3 != 0)  
		{
		speed = 0;
		}
	else 
		{
		speed = 1;
		}

	}

else if (keyboard_check(ord("W"))) {
	direction = 90;
	image_angle = point_direction(x, y, x, y-1);
	var t1 = tilemap_get_at_pixel(tilemap, x, bbox_top) & tile_index_mask;
	var t2 = tilemap_get_at_pixel(tilemap, bbox_left, bbox_top) & tile_index_mask;
	var t3 = tilemap_get_at_pixel(tilemap, bbox_right, bbox_top) & tile_index_mask;
	if (t1 != 0 || t2 != 0 || t3 != 0) 
		{
		speed = 0;
		}
	else 
		{
		speed = 1;
		}

	}
	
else if (keyboard_check(ord("A"))) {
	direction = 180;
	image_angle = point_direction(x, y, x-1, y);
	var t1 = tilemap_get_at_pixel(tilemap, bbox_left, y) & tile_index_mask;
	var t2 = tilemap_get_at_pixel(tilemap, bbox_left, bbox_top) & tile_index_mask;
	var t3 = tilemap_get_at_pixel(tilemap, bbox_left, bbox_bottom) & tile_index_mask;
	if (t1 != 0 || t2 != 0 || t3 != 0) 
		{
		speed = 0;
		}
	else 
		{
		speed = 1;
		}

	}

else if (keyboard_check(ord("S"))) {
	direction = 270;
	image_angle = point_direction(x, y, x, y+1);
	var t1 = tilemap_get_at_pixel(tilemap, x, bbox_bottom) & tile_index_mask;
	var t2 = tilemap_get_at_pixel(tilemap, bbox_right, bbox_bottom) & tile_index_mask;
	var t3 = tilemap_get_at_pixel(tilemap, bbox_left, bbox_bottom) & tile_index_mask;
	if (t1 != 0 || t2 != 0 || t3 != 0)  
		{
		//speed = 0;
		}
	else 
		{
		speed = 1;
		}

	}

//FOV



//this gets the lines for the sides of the camera, currently unused

var cameraTopY=camera_get_view_y(view_camera[0])
var cameraBotY=camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])
var cameraLeftX=camera_get_view_x(view_camera[0])
var cameraRightX=camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])
var i;
var counter = 0


hitVertex = ds_list_create() //creates a list where we will store all the Vertex's that aren't blocked
rayCastVertex = ds_list_create() //creates a list where we will store 2 of the triangles 3 points (the other point being our own position


//this finds all the obj_wallVertex's and puts them into the 2d array vertex
for (i=0; i < instance_number(wallVertex); i += 1)
	{
	vertex[i,0] = instance_find(wallVertex, i).x
	vertex[i,1] = instance_find(wallVertex, i).y
	}

// this sorts the array by angle from player
vertex = scr_sort2dArrayByAngle(vertex, x,y)


//this checks all the vertexs in the array to see if they are visable from the player, the ones which are are stored in the
//hitVertex list
for (i=0; i < array_height_2d(vertex); i+=1)
	{
	//this doesnt really have to be like this, im just too lazy to fix
		if (collision_line(x,y,vertex[i,0],vertex[i,1],obj_visionBlockers,false,true) != noone)
			{
			
			}
		else
			{
			ds_list_add(hitVertex,[vertex[i,0],vertex[i,1]])
			}
	}
	
//this loops round all the vertex's in the hitVertex list
for(i=0; i<ds_list_size(hitVertex); i++)
	{
	point = ds_list_find_value(hitVertex,i) //gets the array in hitVertex at index i, puts it into a new array
	if i==ds_list_size(hitVertex)-1 
	//if we at the end of the list, the next angle of the triangle will be at [0] instead of [i+1]
	//this code is the same as in the else part, this could be made way cleaner
		{
		point2 = ds_list_find_value(hitVertex,0)
		hitpoint1 = scr_raycast(x,y,point[0],point[1],obj_visionBlockers);
		hitpoint1a = [hitpoint1[@0], hitpoint1[@1]]
		hitpoint2 = scr_raycast(x,y,point2[0],point2[1],obj_visionBlockers);
		//scr_raycast returns false if the line never hits a wall
		//hitpoint1a = returns the coordinates where a line through point first hits a wall
		//hitpoint2 = returns the coordinates where a line through point2 first hits a wall
		if hitpoint1 != false //if the first raycast hits a wall
			{
			if point_distance(point[0],point[1],hitpoint1a[0],hitpoint1a[1])>10  && hitpoint2 != false
				//if where the raycast hits is at least 10(pixels?) from the point AND the second raycast hits a wall
				{
				ds_list_add(rayCastVertex,[hitpoint1a[0],hitpoint1a[1], hitpoint2[0], hitpoint2[1]])
				//add to the triangle list the points where the first raycast hits a wall and where the second
				//raycast hits a wall
				}
			else {ds_list_add(rayCastVertex,[point[0],point[1], point2[0], point2[1]])}
			// add the normal points to the triangle list
			}
		else
			{
			ds_list_add(rayCastVertex,[point[0],point[1], point2[0], point2[1]])
			// add the normal points to the triangle list
			}
		}
	else //does same as above however point 2 is the next hitvertex [i+1] (this will be used most of the time)
		{
		point2 = ds_list_find_value(hitVertex,i+1)
		hitpoint1 = scr_raycast(x,y,point[0],point[1],obj_visionBlockers);
		hitpoint1a = [hitpoint1[@0], hitpoint1[@1]]
		hitpoint2 = scr_raycast(x,y,point2[0],point2[1],obj_visionBlockers);
		if hitpoint1 != false
			{
			if point_distance(point[0],point[1],hitpoint1a[0],hitpoint1a[1])>50 && hitpoint2 != false
				{
				ds_list_add(rayCastVertex,[hitpoint1a[0],hitpoint1a[1], hitpoint2[0], hitpoint2[1]])
				}
			else {ds_list_add(rayCastVertex,[point[0],point[1], point2[0], point2[1]])}
			}
		else
			{
			ds_list_add(rayCastVertex,[point[0],point[1], point2[0], point2[1]])
			}
		}
	}


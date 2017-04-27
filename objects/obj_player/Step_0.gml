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



var cameraTopY=camera_get_view_y(view_camera[0])
var cameraBotY=camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])
var cameraLeftX=camera_get_view_x(view_camera[0])
var cameraRightX=camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])
var i;
var counter = 0

hitVertex = ds_list_create()
rayCastVertex = ds_list_create()

for (i=0; i < instance_number(wallVertex); i += 1)
	{
	vertex[i,0] = instance_find(wallVertex, i).x
	vertex[i,1] = instance_find(wallVertex, i).y

	}
vertex = scr_sort2dArrayByAngle(vertex, x,y)

for (i=0; i < array_height_2d(vertex); i+=1)
	{
	//point = [vertex[i,0], vertex[i,1]]
		if (collision_line(x,y,vertex[i,0],vertex[i,1],obj_visionBlockers,false,true) != noone)
			{

			}
		else
			{
			ds_list_add(hitVertex,[vertex[i,0],vertex[i,1]])

			}
	}
for(i=0; i<ds_list_size(hitVertex); i++)
	{
	point = ds_list_find_value(hitVertex,i)
	if i==ds_list_size(hitVertex)-1
		{
		point2 = ds_list_find_value(hitVertex,0)
		hitpoint1 = scr_raycast(x,y,point[0],point[1],obj_visionBlockers);
		hitpoint1a = [hitpoint1[@0], hitpoint1[@1]]
		hitpoint2 = scr_raycast(x,y,point2[0],point2[1],obj_visionBlockers);
		
		if hitpoint1 != false
			{
			if point_distance(point[0],point[1],hitpoint1a[0],hitpoint1a[1])>10  && hitpoint2 != false
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
	else
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






/*	point = [vertex[i].x, vertex[i].y,arctan(vertex[i].y-y/vertex[i].x-x)]
	vertexpoint = point
	col = c_black


	tarray[0]=scr_linesIntersect(x,y,point[0],point[1], 0, cameraTopY, 1, cameraTopY, false)
	tarray[1]=scr_linesIntersect(x,y,point[0],point[1], 0, cameraBotY, 1, cameraBotY, false)
	tarray[2]=scr_linesIntersect(x,y,point[0],point[1], cameraLeftX, 0, cameraLeftX, 1, false)
	tarray[3]=scr_linesIntersect(x,y,point[0],point[1], cameraRightX, 0, cameraRightX, 1, false)
	t=999999999999999999999999999999999999999999999999
	for (i1=0; i1 < 4; i1+=1)
		{
		if tarray[i1]<t && tarray[i1]>0 {t = tarray[i1]}
		}
	if t!=999999999999999999999999999999999999999999999999
		{
		point = [x+t*(point[0]-x),y+t*(point[1]-y)]
		}
		
	
	hitpoint = point
	if (collision_line(x,y,point[0],point[1],obj_visionBlockers,true,true) != noone)
		{
		hitpoint = scr_raycast(x,y,point[0],point[1],obj_visionBlockers);
		if hitpoint==false { hitpoint = [point[0],point[1]] }
		}
	if (point_distance(x,y,hitpoint[0],hitpoint[1])>point_distance(x,y,vertexpoint[0],vertexpoint[1]))
		{ds_list_add(hitpoints, vertexpoint)}
	ds_list_add(hitpoints, hitpoint)
	//draw_line_color(x,y,hitpoint[0],hitpoint[1],col, col);
	}
	
for (i=0; i<ds_list_size(hitpoints); i+=1)
	{
	hitpointsarraytemp = ds_list_find_value(hitpoints, i)
	hitpointsarray[i,0]=hitpointsarraytemp[0]
	hitpointsarray[i,1]=hitpointsarraytemp[1]	
	}
	
ds_list_destroy(hitpoints)
hitpointsarray = scr_sort2dArrayByAngle(hitpointsarray, x, y)
for (i=0; i<array_height_2d(hitpointsarray); i+=1)
	{
	x2=hitpointsarray[i, 0]
	y2=hitpointsarray[i, 1]
	//draw_point_color(x2, y2, c_white)
	}
show_debug_message(arctan( tan( pi/2 - 0.1 )))
show_debug_message(arctan( tan( pi/2 + 0.1 )))
*/


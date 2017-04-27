/// @description Insert description here
// You can write your code in this editor
draw_self()

for (i=0; i<ds_list_size(hitVertex); i+=1){
	point = ds_list_find_value(hitVertex,i)
	//draw_line_color(x,y,point[0],point[1],c_white,c_white)
	//draw_triangle_color(x,y,point[0],point[1],point[2],point[3], c_white, c_white, c_white, true)
}

for (i=0; i<ds_list_size(rayCastVertex); i+=1){
	point = ds_list_find_value(rayCastVertex,i)
	//draw_line_color(x,y,point[0],point[1],c_white,c_white)
	draw_triangle_color(x,y,point[0],point[1],point[2],point[3], c_white, c_white, c_white, true)
}

ds_list_destroy(hitVertex)
ds_list_destroy(rayCastVertex)





//show_debug_message(array_height_2d(hitVertex))
/*
for (i=0; i<array_height_2d(hitpointsarray)-1; i+=1)
	{
	draw_set_color(c_aqua)
	if i=0
		{
		draw_triangle(x,y,hitpointsarray[i,0],hitpointsarray[i,1],hitpointsarray[array_height_2d(hitpointsarray)-1,0],hitpointsarray[array_height_2d(hitpointsarray)-1,1],true)
		}
	else
		{
		draw_triangle(x,y,hitpointsarray[i,0],hitpointsarray[i,1],hitpointsarray[i+1,0],hitpointsarray[i+1,1],true)
		}
	}
*/
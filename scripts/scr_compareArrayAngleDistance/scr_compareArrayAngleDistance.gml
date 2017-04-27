///scr_compareArrayAngleDistance(array1x, array1y, array2x,array2y,xpos,ypos)

array1x = argument0;
array1y = argument1;
array2x = argument2;
array2y = argument3;
xpos = argument4;
ypos = argument5;

//we only want to calculate each angle once, saves computation
angle1 = scr_calcAngle(xpos,ypos, array1x, array1y)
angle2 = scr_calcAngle(xpos,ypos, array2x, array2y)
return  (angle1 < angle2)
		|| (angle1 == angle2)
		&& sqrt(sqr(array1x-xpos)+sqr(array1y-ypos)) < sqrt(sqr(array2x-xpos)+sqr(array2y-ypos))
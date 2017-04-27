///scr_sort2dArrayByAngle(2darray,x,y)

ar=argument0;
xpos=argument1;
ypos=argument2;

/*
swapped = true;


while swapped == true{
	swapped = false;
	for (i=1; i<(array_height_2d(ar));i++)
		{
		if scr_compareArrayAngleDistance(ar[i,0], ar[i,1],ar[i-1,0],ar[i-1,1],xpos,ypos)==true
			{
				//show_debug_message(i)
				tempar[0] = ar[i-1,0];
				tempar[1] = ar[i-1,1]
				ar[i-1,0] = ar[i,0];
				ar[i-1,1] = ar[i,1];
				ar[i,0] = tempar[0];
				ar[i,1] = tempar[1];				
				swapped = true;
			}
		}
	}

return ar; */


// bubblesort from https://forum.yoyogames.com/index.php?threads/game-maker-array-sorting-algorithms.5930/
///scr_sort2dArrayByAngle(2darray,x,y)

length = array_height_2d(ar)
for (j=0; j<length; j++)
	{
	for (i=1; i<=j;i++)
		{
		if scr_compareArrayAngleDistance(ar[i,0], ar[i,1],ar[i-1,0],ar[i-1,1],xpos,ypos)==true
			{
				//show_debug_message(i)
				tempar[0] = ar[i-1,0];
				tempar[1] = ar[i-1,1]
				ar[i-1,0] = ar[i,0];
				ar[i-1,1] = ar[i,1];
				ar[i,0] = tempar[0];
				ar[i,1] = tempar[1];	
			}
		}
	}

return ar; 

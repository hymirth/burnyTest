///calcAngle(xpos,ypos,desx,desy)
	xpos = argument0;
	ypos = argument1;
	desx = argument2;
	desy = argument3;
	
if xpos == desx {
	if ypos < desy {
		return pi/2
		}
	return -pi/2
	}
else if ypos == desy {
	if xpos < desx {
		return 0
		}
	return pi
	}
else {
	quadrant = 0
	if desx < xpos && desy > ypos 
		{ quadrant = 2 }
	if desx < xpos && desy < ypos 
		{ quadrant = 3 }
	if quadrant != 0
		{ return pi+arctan((desy-ypos)/(desx-xpos))}
	else
		{ return arctan((desy-ypos)/(desx-xpos)) }
	}
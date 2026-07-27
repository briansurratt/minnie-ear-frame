$fn = $preview ? 32 : 512;

version = "v2.0.0";
bowRadius = 62;
bowThickness = 3;

type = "STAND";

bodyHeight = 25;

stand_parameters = object (
    leg_length= 50, 
    leg_width = 25,
    leg_thickness = bodyHeight,
    base_diameter = 125, 
    step_height = 10);


frame_params = object (frame = true, filled = false,stand=false,bowHeight=50);
solid_params = object (frame = false, filled = true,stand=false,bowHeight=50);
open_params = object (frame = false, filled = false,stand=false,bowHeight=50);
stand_params = object (frame = false, filled = false,stand=true,bowHeight=bodyHeight);

bowLip = 5;
bowLipHeight = 5;

bowTheta = 28;
bowAngles = [0+bowTheta,180-bowTheta];

bowShiftY = 12;


wallThickness = 3;

earAngle = 46;
earPositionRatio = 111/73;


headDiameter = 66.5;

earDiameter = headDiameter * (3/5);
earCenterRadius = headDiameter/2 * earPositionRatio;
earCenterX = cos(earAngle) * earCenterRadius;
earCenterY = sin(earAngle) * earCenterRadius;



// are all used in the frame module

frameAllowance = 0.5;
frameHeight = 10;

frameEdge = 8;
frameWindowDiameter = frameEdge * 2;

earOuterDiameter = earDiameter + (wallThickness * 2) + frameAllowance;
headOuterDiameter = headDiameter + (wallThickness * 2) + frameAllowance;

detentThickness = 0.25;
detentZOffset = 5;

// this is just a starting point
bow_interface_channel = wallThickness;
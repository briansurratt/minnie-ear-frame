version = "v1.2.0";
bowRadius = 62;
bowThickness = 3;


bowHeight = 50;
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

bodyHeight = 20;

// are all used in the frame module

frameAllowance = 0.5;
frameHeight = 10;

frameEdge = 8;
frameWindowDiameter = frameEdge * 2;

earOuterDiameter = earDiameter + (wallThickness * 2) + frameAllowance;
headOuterDiameter = headDiameter + (wallThickness * 2) + frameAllowance;

detentThickness = 0.25;
detentZOffset = 5;
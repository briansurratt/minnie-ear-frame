$fn = $preview ? 32 : 128;


include <constants_v1_1_0.scad>

// #translate([-90.5, -121, 0]) {
//     import("reference/Mickey_Mouse_head_and_ears.svg");    
// }



earDiameter = headDiameter * (3/5);
earCenterRadius = headDiameter/2 * earPositionRatio;
earCenterX = cos(earAngle) * earCenterRadius;
earCenterY = sin(earAngle) * earCenterRadius;


bow();

difference() {
    linear_extrude(height=10) {

        circle(d=headDiameter);

        translate([-earCenterX, earCenterY, 0]) {
            circle(d=earDiameter);
        }

        translate([earCenterX, earCenterY, 0]) {
            circle(d=earDiameter);
        }
        

    }
    version_text();
}


// #square([125, 125], center=true);

module bow() {

    translate([0,0,bowHeight])
    mirror([0,0,1]) {

    linear_extrude(height=bowHeight)
    arc(bowRadius, bowAngles, bowThickness, $fn);

    difference() {

        linear_extrude(height=bowLipHeight)
        arc(bowRadius, bowAngles, bowThickness + bowLip, $fn);

rotate([0, 0,bowTheta]) {
    translate([0, 0, bowLip + 1])
    rotate_extrude(angle = 180-2*bowTheta, convexity = 2) {
        translate([bowRadius + bowLip + bowThickness, 0, 0])
        circle(r=bowLip);
    }
}



    }
}
}

module version_text() {
    translate([0, 0, -0.5])
    linear_extrude(height=1)
    mirror([1, 0, 0]) 
    #text(version, size=5, halign="center", valign="center");
}




module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}



module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 
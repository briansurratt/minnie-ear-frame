$fn = $preview ? 32 : 128;


include <constants_v1_1_1.scad>

// #translate([-90.5, -121, 0]) {
//     import("reference/Mickey_Mouse_head_and_ears.svg");    
// }



earDiameter = headDiameter * (3/5);
earCenterRadius = headDiameter/2 * earPositionRatio;
earCenterX = cos(earAngle) * earCenterRadius;
earCenterY = sin(earAngle) * earCenterRadius;


module back() {

    bow();
    hanger();

    difference() {
        linear_extrude(height=bodyHeight) {

            hollowRing(headDiameter);
            

            translate([-earCenterX, earCenterY, 0]) {
                hollowRing(earDiameter);
            }

            translate([earCenterX, earCenterY, 0]) {
                hollowRing(earDiameter);
            }
            

        }
        version_text();
    }



}

module hanger() {

    translate([0, bowShiftY,0])

    difference() {

        linear_extrude(wallThickness) {
            hull() {
                arc(bowRadius + 2, [80,100], 1, $fn);
                translate([0,bowRadius + 10,0])
                circle(d=10);
            }
        }

        // nail hole
        translate([0, bowRadius + 10, wallThickness/2 ])
        cylinder(d=3, h=wallThickness + 2, center=true);

    }

}

render_back = false;

if (render_back) {
    back();
} else  {
    frame();
}



module frame() {

    frameAllowance = 1;
    frameHeight = 10;

    earOuterDiameter = earDiameter + (wallThickness * 2) + frameAllowance;
    headOuterDiameter = headDiameter + (wallThickness * 2) + frameAllowance;

    difference() {

        // rings
        linear_extrude(height=frameHeight) {
            translate([earCenterX, earCenterY, 0]) circle(d=earOuterDiameter);
            translate([-earCenterX, earCenterY, 0]) circle(d=earOuterDiameter);
            circle(d=headOuterDiameter);
        }

        // negatives
        translate([0, 0, 2])    
        linear_extrude(height=frameHeight) {
        
        translate([earCenterX, earCenterY, 0]) circle(d=earOuterDiameter - (wallThickness * 2));
        translate([-earCenterX, earCenterY, 0]) circle(d=earOuterDiameter - (wallThickness * 2));
        circle(d=headOuterDiameter - (wallThickness * 2));    
        }

        // frame cutout
        cylinder(d=headOuterDiameter - 15, h=10, center=true);

        // bow cutout for ears
        translate([0,bowShiftY,-1])
        linear_extrude(height=frameHeight + 2) {
            arc(bowRadius - 0.25, bowAngles, bowShiftY + 1, $fn);
        }

    }

}


module hollowRing(diam= 10) {
        difference() {
            circle(d=diam);
            circle(d=diam-(wallThickness * 2));
        }
}


// #square([125, 125], center=true);

module bow() {

    translate([0,bowShiftY,bowHeight])
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
include <constants.scad>
use <components.scad>

MODE_BACK = "mode_back";
MODE_FRAME = "mode_frame";
MODE_TEMPLATE = "mode_template";

gen_params = solid_params;
mode=MODE_BACK;

echo(str("mode = ", mode));
echo(str("parameters = ", gen_params));

if (mode == MODE_BACK) {
    back(gen_params);
} else if (mode == MODE_FRAME) {
    frame();
} else if (mode == MODE_TEMPLATE) {
    template();
} 



module back(gen_params) {

    headInternals(gen_params);
    bow(gen_params);
    hanger();

    difference() {
        silhouette(gen_params)
    
        translate([0,0,bodyHeight- detentZOffset])
        detents(false,gen_params);
    }

}




module detents(male=true,gen_params) {

    if (gen_params.frame) {

        positions = [
            [headDiameter/2,0,0, 0],
            [-headDiameter/2,0, 0, 0],
            [0, headDiameter/2, 0, 90],
            [0, -headDiameter/2, 0, 90]
        ];

        for (pos = positions) {
            translate([pos[0], pos[1], pos[2]])
            rotate([0,0,pos[3]])
                detent(male);
        }

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


module template() {

    difference() {
        cylinder (d=headDiameter, 6, center=true);
        // frame window cutout
        cylinder(d=headOuterDiameter - frameWindowDiameter, h=frameHeight, center=true);
    }

}

module frame() {

    frameFaceThickness = 2;

    union() {

    difference() {

        // rings
        linear_extrude(height=frameHeight) {
            translate([earCenterX, earCenterY, 0]) circle(d=earOuterDiameter);
            translate([-earCenterX, earCenterY, 0]) circle(d=earOuterDiameter);
            circle(d=headOuterDiameter);
        }

        // negatives
        translate([0, 0, frameFaceThickness])    
        linear_extrude(height=frameHeight) {
                translate([earCenterX, earCenterY, 0]) circle(d=earOuterDiameter - (wallThickness * 2));
            translate([-earCenterX, earCenterY, 0]) circle(d=earOuterDiameter - (wallThickness * 2));
            circle(d=headOuterDiameter - (wallThickness * 2));    
        }

        // frame cutout
        cylinder(d=headOuterDiameter - frameWindowDiameter, h=10, center=true);

        // bow cutout for ears
        translate([0,bowShiftY,-1])
        linear_extrude(height=frameHeight + 2) {
            arc(bowRadius - 0.25, bowAngles, bowShiftY + 1, $fn);
        }

    }

    translate([0,0,detentZOffset + frameFaceThickness]) detents(true);
    }

}

// module stand_bow(gen_params) {
//     bow(gen_params);

//     // translate([earCenterX, earCenterY, 0])
//     // rotate([0, 0, -45]) 
//     // cube([bow_interface_channel-0.5,earDiameter/2 + 2,bodyHeight/2]);


//     // translate([-earCenterX, earCenterY, 0])
//     // rotate([0, 0, 35]) 
//     // cube([bow_interface_channel-0.5,earDiameter/2 + 2,bodyHeight/2]);

// }




module version_text() {
    translate([0, 0, -0.5])
    linear_extrude(height=1)
    mirror([1, 0, 0]) 
    #text(version, size=5, halign="center", valign="center");
}






module headInternals(gen_params) {

    if (gen_params.frame) {

        linear_extrude(height=bodyHeight) {

        square([wallThickness, headDiameter - 1], center=true);
        square([headDiameter - 1, wallThickness], center=true);

        }

    }

}


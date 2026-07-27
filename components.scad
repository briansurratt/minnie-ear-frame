include <constants.scad>

module detent (male=true) {   

    mod = male ?  0 : 0.25;

    resize( [detentThickness*2 + mod, 1, 1.0])
            sphere( r = 1, $fn = 32); 

}

module hollowRing(diam= 10, gen_params) {

    difference() {
        circle(d=diam);
        if (!gen_params.filled) {
            circle(d=diam-(wallThickness * 2));
        }
    }

}

module silhouette(gen_params) {

    difference() {
        
    linear_extrude(height=bodyHeight) {

        hollowRing(headDiameter,gen_params);
        

        translate([-earCenterX, earCenterY, 0]) {
            hollowRing(earDiameter,gen_params);
        }

        translate([earCenterX, earCenterY, 0]) {
            hollowRing(earDiameter,gen_params);
        }
        

    }

    // this takes slots out for the bow to interface with
    // will be used on the future
    // if (gen_params.stand) {
    //     translate([earCenterX, earCenterY, bodyHeight/2])
    //     rotate([0, 0, -45]) 
    //     cube([bow_interface_channel,earDiameter/2 + 2,bodyHeight/2]);

    //     translate([-earCenterX, earCenterY, bodyHeight/2])
    //     rotate([0, 0, 35]) 
    //     cube([bow_interface_channel,earDiameter/2 + 2,bodyHeight/2]);

    // }
    
    }

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

module bow(gen_params) {

        translate([0,bowShiftY,gen_params.bowHeight]){

            mirror([0,0,1]) {

                linear_extrude(height=gen_params.bowHeight)
                arc(bowRadius, bowAngles, bowThickness, $fn);

                bow_lip();
            }
        }
        if(gen_params.stand) {
            translate([0,bowShiftY,0])
            bow_lip();
        }
}


module bow_lip() {

    difference() {

        // this builfs the lip
        linear_extrude(height=bowLipHeight)
        arc(bowRadius, bowAngles, bowThickness + bowLip, $fn);

        // this takes the curve out
        rotate([0, 0,bowTheta]) {
            translate([0, 0, bowLip + 1])
            rotate_extrude(angle = 180-2*bowTheta, convexity = 2) {
                translate([bowRadius + bowLip + bowThickness, 0, 0])
                #circle(r=bowLip);
            }
        }

    }
}

module roundover_disc (disc_od = 50, disc_height = 10, roundover_radius=1) {
                // outer ring
            cylinder(d=disc_od + 2 * roundover_radius, h=disc_height-roundover_radius, center=false);
            // inner ring
            cylinder(d=disc_od, h=disc_height, center=false);

            translate([0, 0, disc_height-roundover_radius])
            rotate_extrude()
            translate([disc_od/2 , 0, 0])
            circle(r=roundover_radius);
}

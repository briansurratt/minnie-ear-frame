include <constants.scad>
use <components.scad>

// stand(stand_params);
base(stand_params);


module stand(gen_params) {

    #silhouette(gen_params);

    cube_y = stand_parameters.leg_length + stand_parameters.step_height;
    cube_x = stand_parameters.leg_width;
    translate([-cube_x/2, -cube_y - headDiameter/2 + wallThickness - 0.25, 0]) {
        cube([cube_x,cube_y, bodyHeight],false);
    }

    bow(gen_params);

}

module base(gen_params) {
    lip_radius = 1;
    interface_margin = 0.5;

    base_dia = stand_parameters.base_diameter;
    base_z = stand_parameters.step_height;

    difference()  {

        union() {
            roundover_disc(base_dia, base_z, lip_radius);
            translate([0, 0, base_z]) 
            roundover_disc(stand_parameters.leg_width *2, base_z, lip_radius);
        }

        translate([0, 0, stand_parameters.step_height * 1.5]) 
        #cube([
            stand_parameters.leg_width + interface_margin,
            stand_parameters.leg_thickness + interface_margin,
            (stand_parameters.step_height * 2) 
            ],
            center = true
        );

        mirror([1,0,0])
        translate([-12, -4.5, -1.5]) {
            import("signature.stl", convexity=3);
        }
    
    }

}
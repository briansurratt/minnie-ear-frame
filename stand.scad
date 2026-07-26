include <constants.scad>
use <components.scad>

stand(stand_params);

module stand(gen_params) {

    #silhouette(gen_params);

    cube_y = stand_parameters.leg_length + stand_parameters.step_height;
    cube_x = stand_parameters.leg_width;
    translate([-cube_x/2, -cube_y - headDiameter/2 + wallThickness - 0.25, 0]) {
        cube([cube_x,cube_y, bodyHeight],false);
    }

    bow(gen_params);

}


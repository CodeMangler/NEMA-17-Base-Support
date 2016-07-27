width = 42.3; // NEMA 17s are 42.3 x 42.3 x motor_height
chamfer_width = 33; // Set it to the same as width if there is no chamfer
support_height = 17.5;

skirt_height = 4;
thickness = 1; // Additional thickness (which primarily shows up as the skirt thickness in the model)

connector_width = 16;

shrink_buffer = 0.5; // Additional room to make it easier for the motor to fit into the shape
hole_buffer = 1; // Hole shapes need to be slightly bigger than the obejcts they're cutting through

difference(){
    motor_support(width + shrink_buffer, chamfer_width + shrink_buffer, support_height, skirt_height, thickness);
    translate([width / 2, 0, support_height / 2]) {
        connector_hole(connector_width + shrink_buffer, thickness, skirt_height);
    };
}

module connector_hole(width, thickness, height) {
    cube([thickness + hole_buffer, width, height + hole_buffer], center = true);
}

module motor_support(width, chamfer_width, support_height, skirt_height, thickness) {
    difference() {
        motor_body(width + (thickness * 2), chamfer_width + (thickness * 2), support_height + skirt_height);
        translate([0, 0, support_height / 2]) {
            motor_body(width, chamfer_width, skirt_height + hole_buffer);
        };
    };
}

module motor_body(width, chamfer_width, height) {
    hull() {
        cube([width, chamfer_width, height], center = true);
        rotate([0, 0, 90]){
            cube([width, chamfer_width, height], center = true);
        };
    };
}

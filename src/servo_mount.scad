include <BOSL2/std.scad>
include <parameters.scad>

module servo_mount_unit() {
  servo_mount(5);
  right(5 + 3.5) servo_mount(5);
}

module servo_mount(width) {
  thickness = 2;
  claw_height = 2;
  claw_width = 1;
  servo_thickness = 11.5 + 2 * tolerance;
  points = [
    [0, 0],
    [servo_thickness + claw_height - 1, 0],
    [servo_thickness + claw_height, 1],
    [servo_thickness + claw_height, thickness],
    [servo_thickness + 1, thickness + claw_width],
    [servo_thickness, thickness + claw_width],
    [servo_thickness, thickness],
    [0, thickness],
  ];
  xrot(90) yrot(90) linear_extrude(width, center=false) polygon(points);
}

servo_mount_unit();

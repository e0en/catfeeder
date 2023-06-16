include <BOSL2/std.scad>
include <parameters.scad>

module servo_mount_unit(anchor, spin, orient) {
  width = 5;
  mount_gap = 3.0;
  thickness = 2;

  attachable(anchor, spin, orient, [2 * width + mount_gap, thickness, 12 + tolerance]) {
  mirror_copy([0, 1, 0])
    fwd((thickness + 22) / 2)
    mirror_copy([1, 0, 0]) left((width + mount_gap) / 2) servo_mount(width);
    children();  // dummy
  }
}

module servo_mount(width) {
  thickness = 2;
  claw_height = 2;
  claw_width = 1;
  servo_thickness = 12 + tolerance;
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

  down((12 + tolerance) / 2) fwd(1) right(width / 2) {
    yrot(-90) linear_extrude(width, center=false) polygon(points);
  }
}

servo_mount_unit();

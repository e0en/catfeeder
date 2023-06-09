include <BOSL2/std.scad>
include <parameters.scad>
use <servo_mount.scad>
use <corner_locks.scad>

module container(
  size, 
  thickness,
  gap, 
  hinge_radius,
) {

  // hinge rotates along this line
  hinge_axis_y = -size / 2 + hinge_radius / 2 + gap + thickness;
  hinge_axis_z = hinge_radius + 1.0;

  // dig a hinge hole as a ball shape, centered here.
  hinge_x = size / 2 - thickness - hinge_radius / 2;

  union() {
    difference() {
      rect_tube(size=size, wall=thickness, h=size);
      translate([0, hinge_axis_y, hinge_axis_z]) {
        xflip_copy() left(hinge_x) sphere(hinge_radius, $fn=circle_edge);
      }
    }

    up(size) corner_locks(size, 10, 3);

    // TODO: fix position & orientation
    translate([0 + lever_width + 6, size / 2, 3]) {
      down(tolerance) servo_mount_unit();
      up(23 + 4) {
        mirror([0, 0, 1]) servo_mount_unit();
      }
    }
  }
}

container(box_size, wall_thickness, 1, 2);

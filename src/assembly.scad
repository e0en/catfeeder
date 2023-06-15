include <BOSL2/std.scad>
include <parameters.scad>

use <container.scad>
use <hinged_floor.scad>
use <servo.scad>
use <bottom_part.scad>
use <lid.scad>

module assembly(size, thickness, gap, hinge_radius) {
  container(size, thickness, gap, hinge_radius);
  hinge_axis_y = -size / 2 + hinge_radius / 2 + gap + thickness;
  hinge_axis_z = hinge_radius + 1.0;
  translate([0, hinge_axis_y, hinge_axis_z]) {
    hinged_floor(size, thickness, gap, hinge_radius);
  }

}

union() {
  assembly(box_size, 1.5, 1, 2);
  translate([6, box_size / 2, 23 + 5 + 1.5]) {
    rotate(180, [0, 1, 0]) servo(-180 -$t * 90);
  }
}


down(box_size) bottom_part(box_size, wall_thickness);
up(box_size + 1) lid(box_size, 2);

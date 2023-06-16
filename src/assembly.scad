include <BOSL2/std.scad>
include <parameters.scad>

use <container.scad>
use <hinged_floor.scad>
use <servo.scad>
use <bottom_part.scad>
use <lid.scad>

module assembly(size, thickness, gap, hinge_radius, anchor, spin, orient) {
  attachable(anchor, spin, orient, [size, size, size]) {
    union() {
      container(size, thickness, gap, hinge_radius)
        position(BACK + BOTTOM) up(10 + tolerance) right(3) color([0, 0, 1]) servo(anchor=FRONT+TOP, orient=BOTTOM);
      hinge_axis_y = -size / 2 + hinge_radius / 2 + gap + thickness;
      hinge_axis_z = -size / 2 + hinge_radius + 1.0;
      translate([0, hinge_axis_y, hinge_axis_z]) {
        hinged_floor(size, thickness, gap, hinge_radius);
      }
    }
    children();  // dummy
  }

}

bottom_part(box_size, wall_thickness, leg_thickness, leg_joiner_size)
  attach(TOP)
    assembly(box_size, wall_thickness, floor_gap, hinge_radius, anchor=BOTTOM);

include <BOSL2/std.scad>
include <parameters.scad>
use <corner_locks.scad>

module bottom_part(
  size, 
  thickness,
  leg_thickness,
  leg_joiner_size,
) {

  unit_height = size / 2;
  hole_width = size - thickness * 2;
  hole_height = size / 2;
  hole_origin = [
    -size / 2 + thickness,
    size / 2 - thickness,
    thickness,
  ];

  difference() {
    union() {
      rect_tube(size=size, wall=thickness, h=size);
      up(thickness/2) cube([size, size, thickness], center=true);
      up(size) corner_locks(size, 10, 3);
      up(size / 4 + thickness) wedge([size, size, size / 2], orient=UP, center=true);
    }

    translate(hole_origin)
      fwd(eps)
      cube([hole_width, thickness + eps * 2, hole_height]);
  }
}

bottom_part(box_size, wall_thickness, leg_thickness, leg_joiner_size);

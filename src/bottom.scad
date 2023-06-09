include <BOSL2/std.scad>
include <parameters.scad>
use <corner_locks.scad>

module feet_and_bottom(
  size, 
  thickness,
  gap, 
) {

  unit_height = size / 2;

  union() {
    up(unit_height) rect_tube(size=size, wall=thickness, h=unit_height);
    up(size) corner_locks(size, 10, 3);

    // opening
    opening(size, unit_height, thickness);

  }
}

module opening(width, height, thickness) {
  zrot(180) up(height / 2) difference() {
    wedge([width, width, height], center=true, orient=DOWN);
    fwd(eps) up(thickness) wedge([width - 2 * thickness, width, height], center=true, orient=DOWN);
  }
}

feet_and_bottom(box_size, wall_thickness, 1);

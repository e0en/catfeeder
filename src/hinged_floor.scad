include <BOSL2/std.scad>
include <parameters.scad>

module hinged_floor(outer_size, thickness, gap, hinge_radius) {
  size = outer_size - 2 * (thickness + gap);
  r = hinge_radius - tolerance;

  union() {
    hull() {
      back(size / 2) cube([size, size - hinge_radius, thickness], center=true);
      xcyl(size, r, $fn=circle_edge);
    }

    hinge_x = size / 2 + gap - r / 2;
    xflip_copy() left(hinge_x) sphere(r, $fn=circle_edge);
  }
}

hinged_floor(box_size, wall_thickness, 1, 2);

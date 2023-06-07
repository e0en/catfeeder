include<parameters.scad>

module hinged_floor(outer_size, thickness, gap, hinge_radius) {
  size = outer_size - 2 * (thickness + gap);
  r = hinge_radius - tolerance;

  union() {
    hull() {
      translate([0, hinge_radius, hinge_radius - thickness / 2]) {
        cube([size, size - hinge_radius, thickness]);
      }
      // connect hinge balls to the floor body
      translate([0, hinge_radius, hinge_radius]) {
        rotate(90, [0, 1, 0]) {
          cylinder(size, r, r, $fn=circle_edge);
        }
      }
    }

    // add hinge balls
    translate([-gap + r / 2, hinge_radius, hinge_radius]) {
      sphere(r, $fn=circle_edge);
    }
    translate([size + gap - r/2, hinge_radius, hinge_radius]) {
      sphere(r, $fn=circle_edge);
    }
  }
}

module rounded_sheet(xsize, ysize, thickness) {
  union() {
    translate([0, thickness / 2, 0]) {
      cube([xsize, ysize - thickness, thickness]);
    }
    radius = thickness / 2;
    translate([0, radius, radius]) {
      rotate(90, [0, 1, 0]) {
        cylinder(xsize, radius, radius, $fn=circle_edge);
      }
    }
    translate([0, ysize - radius, radius]) {
      rotate(90, [0, 1, 0]) {
        cylinder(xsize, radius, radius, $fn=circle_edge);
      }
    }
  }
}

hinged_floor(box_size, wall_thickness, 1, 2);

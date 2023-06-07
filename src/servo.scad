include<parameters.scad>

module servo(arm_angle=0) {
  long_side = 23;
  short_side = 11.5;
  h = 5;
  arm_thickness = 1.5;

  rotor_origin = [short_side / 2, short_side / 2, long_side];

  union() {
  
    // casing
    color([0, 0, 1]) {
      cube([long_side, short_side, long_side]);

      translate([long_side, 0, long_side - 2.5 - 4]) {
      cube([5, short_side, 2.5]);
      }
      translate([-5, 0, long_side - 2.5 - 4]) {
      cube([5, short_side, 2.5]);
      }

      // gearbox extrusion
      r1 = short_side / 2;
      translate(rotor_origin) {
        cylinder(h, r1, r1, $fn=circle_edge);
      }
      r2 = 2.5;
      translate(rotor_origin + [6, 0, 0]) {
        cylinder(h, r2, r2, $fn=circle_edge);
      }
    }

    // rotor
    color([0.9, 0, 0]) {
      translate(rotor_origin) {
      translate([0, h, 0]) {
        rotate(90, [1, 0, 0]) {
        cylinder(3, 2.5, 2.5, $fn=circle_edge);
        }
      }
      }
    }

    // arm
    color([0.9, 0.9, 0.9]) {
      translate(rotor_origin) {
        r = 7.5 / 2;
        translate([0, 0, r+1]) {
          difference() {
            cylinder(4, r, r, $fn=circle_edge);
            translate([0, 0, -eps]) {
              cylinder(arm_thickness, r - 1, r - 1, $fn=circle_edge);
            }
          }
          hull() {
            cylinder(arm_thickness, r-1, r-1, $fn=circle_edge);
            translate([20, 0, 0]) {
              cylinder(arm_thickness, 2, 2, $fn=circle_edge);
            }
          }
        }
      }
    }
  }
}

servo();

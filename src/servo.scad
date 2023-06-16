include <BOSL2/std.scad>
include <parameters.scad>

module servo(arm_angle=0, anchor, spin, orient) {
  long_side = 22;
  short_side = 12;
  h = 5;

  attachable(anchor, spin, orient, [long_side, short_side, long_side]) {
    union() {

      // casing
      cube([long_side, short_side, long_side], center=true) {
        mirror_copy([1, 0, 0])
          position(RIGHT + BOTTOM + FRONT) up(15.5) cube([5, short_side, 2.5]);

        // gearbox
        r1 = short_side / 2;
        r2 = 2.5;
        position(TOP + RIGHT) {
          left(r1) {
            cyl(h, r1, $fn=circle_edge, center=false)
              position(TOP)
                color([1, 1, 1]) {
                 cyl(3, 2.5, $fn=circle_edge, center=false);
                 up(1) servo_arm();
               }
          }
          left(r1 + 6) cyl(h, r2, $fn=circle_edge, center=false);
        }
      }
    }

    children();  // dummy
  }
}


module servo_arm() {
  arm_thickness = 1.5;
  r = 7 / 2;
  difference() {
    union() {
      cyl(4, r, $fn=circle_edge, center=false);
      up(4 - arm_thickness)
        hull() {
          cyl(arm_thickness, r-0.5, $fn=circle_edge, center=false);
          right(14.5) cyl(arm_thickness, 2, $fn=circle_edge, center=false);
        }
    }
    up(4 - 1) cyl(1 + eps, r - 1, $fn=circle_edge, center=false);
  }
}

servo();

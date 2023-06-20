include <BOSL2/std.scad>
include <parameters.scad>
use <servo_mount.scad>
use <corner_locks.scad>

module container(
  size, 
  thickness,
  gap, 
  hinge_radius,
  anchor,
  spin,
  orient,
) {

  attachable(anchor, spin, orient, [size, size, size]) {
    down(size / 2) {
      // hinge rotates along this line
      hinge_axis_y = -size / 2 + hinge_radius / 2 + gap + thickness;
      hinge_axis_z = hinge_radius + 1.0;

      // dig a hinge hole as a ball shape, centered here.
      hinge_x = size / 2 - thickness - hinge_radius / 2;

      diff() {
        rect_tube(size=size, wall=thickness, h=size) {
          position(BACK+BOTTOM) {
            up(9)
            right(5)
            yrot(90)
            servo_mount_unit(orient=BACK, anchor=BOTTOM+RIGHT);

            tag("remove")
            fwd(thickness + eps)
              cube([40, thickness + 2 * eps, 3], anchor=BOTTOM+FRONT);
          }
        }
        up(size) corner_locks(size, 5, 3);

        tag("remove") translate([0, hinge_axis_y, hinge_axis_z]) {
          xflip_copy() left(hinge_x) sphere(hinge_radius, $fn=circle_edge);
        }
      }
    }

    children(); // dummy
  }
}

container(box_size, wall_thickness, floor_gap, hinge_radius);

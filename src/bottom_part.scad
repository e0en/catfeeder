include <BOSL2/std.scad>
include <parameters.scad>
use <corner_locks.scad>
use <leg.scad>

module bottom_part(
  size, 
  thickness,
  leg_thickness,
  leg_joiner_size,
  anchor,
  spin,
  orient,
) {

  attachable(anchor, spin, orient, [size, size, size]) {
    unit_height = size / 2;
    opening_width = size - thickness * 2;
    opening_height = size / 2;
    opening_origin = [
      -size / 2 + thickness,
      size / 2 - thickness,
      thickness,
    ];

    down(size / 2) {
      difference() {
        rect_tube(size=size, wall=thickness, h=size) {
          mirror_copy([0, 1, 0])
            mirror_copy([1, 0, 0])
              position(BACK+LEFT+BOTTOM)
                up(leg_joiner_size * 2)
                 fwd(leg_joiner_size * 2)
                  xrot(15)
                    leg_attachment(leg_thickness, leg_joiner_size, anchor=BOTTOM, orient=BACK);
        }
        translate(opening_origin)
          fwd(eps)
          cube([opening_width, thickness + eps * 2, opening_height]);
      }

      up(thickness/2) cube([size, size, thickness], center=true); // bottom
      up(size) corner_locks(size, 5, 3);

      fwd(size / 2)
      up(size / 2)
      left(size / 2)
        skew(azy=-atan(0.5))
          cube([size, size, thickness]);

    }
    children();  // dummy
  }
}

bottom_part(box_size, wall_thickness, leg_thickness, leg_joiner_size);

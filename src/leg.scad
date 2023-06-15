include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
include <parameters.scad>


module leg(r, h, length, joiner_size, anchor, spin, orient) {
  d = 2 * r;
  l = length - r;
  attachable(size=[d, h, length + joiner_size], anchor=anchor, spin=spin, orient=orient) {
    union() {
      up((r - joiner_size) / 2) 
      cuboid([d, h, l])
        attach([TOP]) dovetail_male(joiner_size, h);
      
      down(length / 2 - r + joiner_size / 2) zrot(90) yrot(90) cylinder(h, r, r, center=true);
    }
    children();  // dummy
  }
  
}

module leg_attachment(r, h, joiner_size, anchor, spin, orient) {
  zrot(90)
    yrot(90)
      attachable(anchor, spin, orient, r=r, l=h) {
        d = 2 * r;
        intersection() {
          cyl(h, r, chamfer2=4, center=true);
          diff() {
          left(r / 4) cuboid([d, d, h])
          attach([RIGHT])
            tag("remove") dovetail_female(joiner_size, h);
          }
        }
        children();  // dummy
      }
}

module dovetail_male(size, h) {
  dovetail("male", slide=h, width=size * 2, height=size, chamfer=1);
}

module dovetail_female(size, h) {
  dovetail("female", slide=h, width=size * 2, height=size, chamfer=1);
}

leg(4, 12, 60, 6)
  attach([TOP])
    leg_attachment(12, 12, 6, anchor=RIGHT);

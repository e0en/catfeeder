include <BOSL2/std.scad>
include <parameters.scad>


module lid(
  container_size, 
  thickness,
) {
  union() {
    cube([container_size, container_size, thickness], center=true);
    handle(10, thickness);
  }
}


module handle(size, thickness) {
  xrot(90) pie_slice(ang=180, l=thickness, r=size);
}

lid(box_size, 2);

include<parameters.scad>

module lid(
  container_size, 
  thickness,
) {
  union() {
    cube([container_size, container_size, thickness]);
    translate([container_size / 2, container_size / 2, thickness - eps])
      handle(10, thickness);
  }
}


module handle(size, thickness) {
  rotate(-90, [1, 0, 0]) {
    difference() {
      cylinder(thickness, size, size);
      translate([-size, 0, -eps]) cube(2 * size + 2 * eps);
    }
  }
}

lid(box_size, 2);

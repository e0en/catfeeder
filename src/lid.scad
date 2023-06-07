include<parameters.scad>

module lid(
  container_size, 
  thickness,
) {
  difference() {
    cube([container_size, container_size, thickness]);
    translate([container_size/2, container_size/2, -eps]) {
      cylinder(thickness + 2 * eps, 10, 10, $fn=circle_edge);
    }
  }
}

lid(box_size, 2);

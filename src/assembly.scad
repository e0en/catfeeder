include<parameters.scad>
use<container.scad>
use<floor.scad>
use<servo.scad>
use<bottom.scad>

module assembly(size, thickness, gap, hinge_radius) {
  container(size, thickness, gap, hinge_radius);
  floor_offset = thickness + gap;

  translate([floor_offset, floor_offset, 15]) {
    hinged_floor(size, thickness, gap, hinge_radius);
  }

}

union() {
  assembly(box_size, 1.5, 1, 2);
  translate([box_size / 2 + 6, box_size, 23 + 5 + 1.5]) {
    rotate(180, [0, 1, 0]) servo(-180 -$t * 90);
  }
}


translate([0, 0, -box_size]) feet_and_bottom(box_size, 1.5, 1);

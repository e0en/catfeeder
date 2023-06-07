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

translate([0, 0, 2 * (box_size + tolerance)]) {
  union() {
    assembly(box_size, 1.5, 1, 2);
    translate([box_size + 2, box_size, 5]) {
      rotate(90, [0, 0, 1]) {
        // servo(-180 -$t * 90);
      }
    }
  }
}

translate([0, 0, box_size + tolerance]) {
  union() {
    assembly(box_size, 1.5, 1, 2);
    translate([box_size + 2, box_size, 5]) {
      rotate(90, [0, 0, 1]) {
        // servo(-180 -$t * 90);
      }
    }
  }
}


union() {
  assembly(box_size, 1.5, 1, 2);
  translate([box_size + 2, box_size, 5]) {
    rotate(90, [0, 0, 1]) {
      // servo(-180 -$t * 90);
    }
  }
}


translate([box_size, box_size, -box_size]) rotate(180, [0, 0, 1])feet_and_bottom(box_size, 1.5, 1);

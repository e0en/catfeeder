include<parameters.scad>
use<servo_mount.scad>

module container(
  size, 
  thickness,
  gap, 
  hinge_radius,
) {

  // hinge rotates along this line
  hinge_axis_y = hinge_radius + gap + thickness;
  hinge_axis_z = hinge_radius + lever_length;

  // location of slits for lever
  slit_x = (size - lever_width) / 2;
  slit_y = size - 2 * gap - eps;

  union() {

    difference() {
      square_column(size, thickness);


      // bottom 
      translate([slit_x, slit_y, -tolerance]) {
        cube([lever_width, thickness + 2 * tolerance, 15]);
      }

      // top
      translate([slit_x, slit_y, size - 15 + tolerance]) {
        cube([lever_width, thickness + 2 * tolerance, 15]);
      }

      // "right" hinge joint
      translate([thickness + hinge_radius / 2, hinge_axis_y, hinge_axis_z]) {
        sphere(hinge_radius, $fn=circle_edge);
      }

      // "left" hinge joint
      translate([size - thickness - hinge_radius / 2, hinge_axis_y, hinge_axis_z]) {
        sphere(hinge_radius, $fn=circle_edge);
      }
    }

    translate([0, 0, size]) {
      corner_locks(size, 10, 3);
    }

     // todo: add a servo motor mount
     translate([slit_x + lever_width + 6, size, 3]) {
      translate([0, 0, -tolerance]) servo_mount_unit();
       translate([0, 0, 23 + 4]) {
        mirror([0, 0, 1]) servo_mount_unit();
      }
    }
  }
}

module square_column(size, thickness) {
  difference() {
    cube(size);
    translate([thickness, thickness, -eps]) {
      inner_size = size - thickness * 2;
      cube([inner_size, inner_size, size + eps * 2]);
    }
  }
}

module corner_locks(box_size, width, height) {
  // add corner locks around a square box
  for (i = [0:3]) {
    xoffset = (i == 1 || i == 2) ? 1 : 0;
    yoffset = (i >= 2) ? 1 : 0;
    
    translate([box_size * xoffset, box_size * yoffset, 0]) {
      rotate(90 * i, [0, 0, 1]) {
      corner_lock(width, height);
      }
    }
  }
}

module corner_lock(size, height) {
  t = 2;

  union() {
    lower_thickness = t + tolerance;
    translate([-lower_thickness , -lower_thickness, -2 * lower_thickness]) {
      tapered_l_shape(size + tolerance, lower_thickness);
      translate([0, 0, 2 * lower_thickness]) {
        l_shape(size + tolerance, t, height);
      }
    }
  }
}

module l_shape(size, thickness, height) {
  difference() {
    cube([size, size, height]);
    translate([thickness, thickness, -eps]) {
      cube([size - thickness + eps, size - thickness + eps, height + 2 * eps]);
    }
  }
}

module tapered_l_shape(size, thickness) {
  difference() {
    rotate(180, [0, 0, 1]) {
      translate([-size, -size, 0]) {
        tapered_box(size - thickness, size, thickness * 2);
      }
    }
    translate([thickness, thickness, -eps]) {
      cube([size - thickness + eps, size - thickness + eps, thickness * 2 + 2 * eps]);
    }
  }
}

module tapered_box(bottom_size, top_size, height) {
  points = [
    [0, 0, 0],
    [bottom_size, 0, 0],
    [bottom_size, bottom_size, 0],
    [0, bottom_size, 0],
    [0, 0, height],
    [top_size, 0, height],
    [top_size, top_size, height],
    [0, top_size, height],
  ];
  faces = [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3],  // left
    ];
  polyhedron(points, faces);
}

container(box_size, wall_thickness, 1, 2);

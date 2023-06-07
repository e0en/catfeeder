include<parameters.scad>

module feet_and_bottom(
  size, 
  thickness,
  gap, 
) {

  // location of slits for lever
  slit_x = (size - lever_width) / 2;
  slit_y = - eps;

  unit_height = size / 3;

  union() {

    // top 1/3
    difference() {
      translate([0, 0, 2 * size / 3]) square_column(size, size / 3, thickness);
      translate([slit_x, slit_y, size - 15 + tolerance]) {
        cube([lever_width, thickness + 2 * tolerance, 15]);
      }
    }
    translate([0, 0, size]) {
      corner_locks(size, 10, 3);
    }

    // middle 1/3
    translate([0, 0, size / 3]) middle_box(size, size, size / 3, thickness);
    vshape(size, size, size / 3, size / 3, wall_thickness);
    translate([0, 0, size / 3]) square_column(size, size / 3, thickness);

    // bottom 1/3
    translate([size / 2, size, 0]) back_plate(size, size / 3, thickness);
    vshape(size, size, size / 3, 0, wall_thickness);

    // legs
    translate([0, 0, size / 6]) {
      round_stick(5, [-size / 6, -size / 6, -size / 2], [size / 6, size / 6, 0]);
      translate([0, size, 0]) mirror([0, 1, 0]) round_stick(5, [-size / 6, -size / 6, -size / 2], [size / 6, size / 6, 0]);
    }

    translate([size, 0, 0])
    mirror([1, 0, 0])
    translate([0, 0, size / 6]) {
      round_stick(5, [-size / 6, -size / 6, -size / 2], [size / 6, size / 6, 0]);
      translate([0, size, 0]) mirror([0, 1, 0]) round_stick(5, [-size / 6, -size / 6, -size / 2], [size / 6, size / 6, 0]);
    }

  }
}


module square_column(size, height, thickness) {
  difference() {
    cube([size, size, height]);
    translate([thickness, thickness, -eps]) {
      inner_size = size - thickness * 2;
      cube([inner_size, inner_size, height + eps * 2]);
    }
  }
}

module corner_locks(size, width, height) {
  // add corner locks around a square box
  for (i = [0:3]) {
    xoffset = (i == 1 || i == 2) ? 1 : 0;
    yoffset = (i >= 2) ? 1 : 0;
    
    translate([size * xoffset, size * yoffset, 0]) {
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

module vshape(width, depth, z1, z2, thickness) {
  w = width / 2;
  points = [
    [0, depth, z2], 
    [-w, depth, z1 + z2], 
    [-w, 0, z1], 
    [0, 0, 0], 
    [0, depth, z2 + thickness], 
    [-w, depth, z1 + z2 + thickness], 
    [-w, 0, z1 + thickness], 
    [0, 0, thickness], 
  ];

  faces = [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]]; // left

  translate([w, 0, 0]) {
    polyhedron(points, faces);
    mirror([1, 0, 0])polyhedron(points, faces);
  }
}

module middle_box(width, depth, height, thickness) {
  points = [
    [0, 0],
    [depth, height],
    [0, height],
  ];

  difference() {
    rotate(90, [0, 1, 0]) {
      rotate(90, [0, 0, 1]) {
        linear_extrude(width) polygon(points, [[0, 1, 2]]);
      }
    }
    translate([thickness, thickness, -eps]) {
      cube([width - 2 * thickness, depth - 2 * thickness, height + 2 * eps]);
    }
  }
}

module back_plate(width, depth, thickness) {
  w = width / 2;
  points = [
    [0, 0], 
    [-w, depth], 
    [w, depth], 
  ];
  rotate(90, [1, 0, 0]) linear_extrude(thickness) polygon(points, [[0, 1, 2]]);
}

module round_stick(radius, start_point, end_point) {
  hull() {
    translate(start_point) sphere(radius, $fn=24);
    translate(end_point) sphere(radius, $fn=24);
  }
}

feet_and_bottom(box_size, wall_thickness, 1);

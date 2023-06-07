include<parameters.scad>

module feet_and_bottom(
  size, 
  thickness,
  gap, 
) {

  unit_height = size / 2;

  union() {
    translate([0, 0, unit_height]) square_column(size, unit_height, thickness);
    translate([0, 0, size]) {
      corner_locks(size, 10, 3);
    }

    // opening
    opening(size, unit_height, thickness);

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

module opening(width, height, thickness) {
  translate([0, width, height])
  rotate(-90, [0, 0, 1]) 
  rotate(-90, [1, 0, 0])
  difference() {
    union() { 
      right_triangle_box(width, height, width);
      rotate(90, [1, 0, 0]) square_column(width, thickness, 10 * thickness); 
    }
    translate([-thickness, -eps - thickness, thickness]) right_triangle_box(width, height, width - 2 * thickness);
  }
}

module right_triangle_box(width, depth, height) {
  points = [
    [0, 0],
    [width, 0],
    [0, depth],
  ];
  linear_extrude(height) polygon(points);
}

feet_and_bottom(box_size, wall_thickness, 1);

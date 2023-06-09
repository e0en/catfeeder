include <BOSL2/std.scad>
include <parameters.scad>

module corner_locks(box_size, width, height) {
  // add corner locks around a square box
  yflip_copy() xflip_copy()
    left(box_size / 2) fwd(box_size / 2)
      corner_lock(width, height);
}

module corner_lock(size, height) {
  t = 2;
  path = [
    [0, size],
    [0, 0],
    [size, 0],
  ];

  path_sweep2d(trapezoid(h=t, w2=height, ang=[30, 90], spin=90, anchor=BOTTOM), path);
}

corner_locks(60, 10, 3);

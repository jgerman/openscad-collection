// these should probably all live within the modules
// x dimension
base_tray_width = 216;

// y dimension
base_tray_depth = 140;

// z dimension
base_tray_thickness = 5.5;

wing_width = 5;
wing_depth = 124;

module wing () {
  difference() {
    // wing TODO why do I need the + 3 in depth??
    cube([wing_width, wing_depth, base_tray_thickness], center=true);

    // wing cutout
        translate([1, 0, -3.5]) cube([wing_width, wing_depth + 2, base_tray_thickness], center=true);
  }
}

module base_platform() {
  corner_radius = 2;

  linear_extrude(base_tray_thickness, center=true)
  minkowski() {
    square([base_tray_width - corner_radius, base_tray_depth - corner_radius], center=true);
    circle(corner_radius, center=true);
  }
}

module base_tray () {

  base_platform();
  // right wing
  translate([(base_tray_width / 2) + (wing_width / 2), 0, 0])
    rotate([0, 0, 180])
    wing();

  // left wing
  translate([-((base_tray_width / 2) + (wing_width / 2)), 0, 0])
    wing();
}

module magnet_sheet_tray (depth_of_hollow, offset_from_edge) {

  difference() {
    base_tray();
    translate([0, 0, base_tray_thickness - depth_of_hollow])
    cube([base_tray_width, base_tray_depth, base_tray_thickness], center=true);
  }
}


magnet_sheet_tray(1.5, 2);

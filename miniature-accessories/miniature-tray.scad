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

module base_platform () {
  corner_radius = 2;

  module corner () {
    cylinder(base_tray_thickness, corner_radius, corner_radius, center=true, $fn=50);
  }

  hull() {
    cube([base_tray_width, base_tray_depth, base_tray_thickness], center=true);

    translate([(base_tray_width / 2) - (corner_radius / 2),

               (base_tray_depth / 2) - (corner_radius / 2),
               0]) corner();

    translate([-((base_tray_width / 2) - (corner_radius / 2)),
               (base_tray_depth / 2) - (corner_radius / 2),
               0]) corner();

    translate([(base_tray_width / 2) - (corner_radius / 2),
               -((base_tray_depth / 2) - (corner_radius / 2)),
               0]) corner();

    translate([-((base_tray_width / 2) - (corner_radius / 2)),
               -((base_tray_depth / 2) - (corner_radius / 2)),
               0]) corner();
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

base_tray();

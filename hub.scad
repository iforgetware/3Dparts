$fn = 90;

radius = 74;

thickness = 6;
offset = 2;

center_hole_radius = 27.4;

rim_bolts_radius = 35;
rim_bolt_hole_radius= 4.2;

sprocket_step_radius = 58.15;
sprocket_bolts_radius = 67.5;
sprocket_bolt_hole_radius = 3.15;

difference () {
	body ();
	center_hole ();
	bolt_holes ();
}

module body () {
	union () {
		cylinder (r=sprocket_step_radius, h=thickness);
		cylinder (r=radius, h=thickness-offset);
	}
}

module center_hole () {
	cylinder (r=center_hole_radius, h=thickness);
}

module bolt_holes () {
	for (a1 = [0, 90, 180, 270]) {
		rotate (a=a1) {
			translate ([rim_bolts_radius, 0, 0]) {
				cylinder (r=rim_bolt_hole_radius, h=thickness);
			}
		}
	}
	for (a2 = [15, 75, 135, 195, 255, 315]) {
		rotate (a=a2) {
			translate ([sprocket_bolts_radius, 0, 0]) {
				cylinder (r=sprocket_bolt_hole_radius, h=thickness);
			}
		}
	}
}
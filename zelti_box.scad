module pixelart(l) {
	for (y = [0 : len(l)-1]) for (x = [0 : len(l[y])-1])
		if (l[y][x] == 1) translate([x - 0.01, -y - 1.01]) square([1.02, 1.02]);
}

module zelti() {
	pixelart([
		[0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0],
		[0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0],
		[0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0],
		[0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0],
		[0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0],
		[0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0],
		[0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	]);
}

module zelti_filled() {
	pixelart([
		[0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
		[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
		[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
		[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
		[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
		[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
		[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	]);
}

module zelti_hollow() {
	difference() {
		zelti_filled();
		polygon([
			[0.6, -9.8],
			[1.2, -9],
			[1.2, -8],
			[2.2, -7],
			[2.2, -6],
			[3.2, -5],
			[3.2, -4],
			[6, -1.2],
			[10, -1.2],
			[12.8, -4],
			[12.8, -5],
			[13.8, -6],
			[13.8, -7],
			[14.8, -8],
			[14.8, -9],
			[15.4, -9.8],
		]);
	}
}

r  = 7.5;
w  = r * 16;
h  = r * 10;
d1 = 37;
d2 = 2;
d3 = 1;

module zelti_raw() {
	for (i = [0, 1]) translate([i*w, 0, 0]) rotate([0, 0, i*180]) {
		translate([0, 0, 0]) rotate([90, 0, 0]) linear_extrude(d1 + 0.1, convexity = 20) scale(r) translate([0, 10]) zelti_hollow();
		translate([0, -d1, 0]) rotate([90, 0, 0]) linear_extrude(d2 + 0.1, convexity = 20) scale(r) translate([0, 10]) zelti_filled();
		translate([0, -(d1 + d2 - 0.1), 0]) rotate([90, 0, 0]) linear_extrude(d3 + 0.1, convexity = 20) scale(r) translate([0, 10]) zelti();
	}
}

module zelti_bottom() {
	dtop = 2*(d1 + d2 + d3 - r);
	difference() {
		zelti_raw();
		translate([w/2, 0, 1.4*h]) rotate([90, 0, 0]) cylinder(d = w, h = dtop, center = true, $fn = 4);
		translate([w/2, 0, h]) cube([5.5*r, dtop, h], center = true);
	}
}

module zelti_top() {
	dtop = 2*(d1 + d2 + d3 - r);
	difference() {
		union() {
			intersection() {
				zelti_raw();
				translate([w/2, 0, 1.4*h]) rotate([90, 0, 0]) cylinder(d = w - 0.1, h = dtop - 0.2, center = true, $fn = 4);
			}
			difference() {
				translate([w/2 - 2.75*r, -dtop/2 + 0.1, h - 1.75*r]) cube([5.5*r, dtop - 0.2, 0.75*r]);
				translate([w/2 - 2.25*r, -dtop/2, h - 2*r]) cube([4.5*r, dtop, 1*r]);
			}
		}
		translate([w/2, 0, 0]) cube([10, 40, 250], center = true);
	}
}

zelti_bottom();
translate([0, 0, 2*r]) zelti_top();

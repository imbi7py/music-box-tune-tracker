/* This file has been generated by "music box tune tracker" v{VERSION} on {DATE_TIME}
 * https://github.com/odrevet/music-box-tune-tracker
 * using "Fred's Fisher Price record creator" .scad template file
 * http://www.instructables.com/id/3D-printing-records-for-a-Fisher-Price-toy-record-/
 */

// writing functions by HarlanDMii
// http://www.thingiverse.com/thing:16193
use <Write.scad>

// Configuration
$fn = 100;
hStock = {THICKNESS};
rStock = 60.58;
oDrive = 21.8;
rDrive = 1.55;
hInset = 1;
rInset = 25.6;
hGroove = 1.2;
overlap = 0.2;

hasSecondSide = {SECOND_SIDE};

// Create disc
module createDisc() {
	union() {

		createBlank();

		// Add the notes for the song. This part is dynamically generated.
{NOTES}
	}
}

// Create the blank, ready for dynamically added pins
module createBlank() {

	difference() {

		// stock
		cylinder(h=hStock, r=rStock);

		// top cutout
		translate(v = [0,0,hStock-hInset+overlap]) {
			cylinder(h=hInset + overlap, r=rInset);
		}

		// Bottom cutout lets the disc sit flatter, but some printers my struggle with the overhang
		translate(v = [0,0,-overlap]) {
			cylinder(h=hInset + overlap, r=rInset);
		}

		// Centre hole
		cylinder(h=hStock, r=3.22);

		// Drive holes
		translate(v = [0,oDrive,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [0,-oDrive,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [oDrive,0,0]) { cylinder(h=hStock, r=rDrive); }
		translate(v = [-oDrive,0,0]) { cylinder(h=hStock, r=rDrive); }

		// Tracks - each one for two notes
		track(28.15, 0);
		track(30.89, 0);
		track(33.71, 0);
		track(36.425, 0);
		track(39.225, 0);
		track(42, 0);
		track(44.825, 0);
		track(47.555, 0);
		track(50.315, 0);
		track(53.11, 0);
		track(55.9, 0);

		if (hasSecondSide > 0) {
			track(28.15, 1);
			track(30.89, 1);
			track(33.71, 1);
			track(36.425, 1);
			track(39.225, 1);
			track(42, 1);
			track(44.825, 1);
			track(47.555, 1);
			track(50.315, 1);
			track(53.11, 1);
			track(55.9, 1);
		}
	}
}

// Negative for a double track
module track(inner, onSecondSide) {
	if (onSecondSide > 0) {
		translate(v = [0,0,-overlap]) {
			difference() {
				cylinder(h=hGroove+overlap, r=inner+2);
				cylinder(h=hGroove+overlap, r=inner);
			}
		}
	}
	else {
		translate(v = [0,0,hStock-hGroove]) {
			difference() {
				cylinder(h=hGroove+overlap, r=inner+2);
				cylinder(h=hGroove+overlap, r=inner);
			}
		}
	}

}

// Create a pin at a certain angle
module pin(inner, outer, angle, onSecondSide)
{
	rotate(a=angle) {
		if (onSecondSide > 0) {
			translate(v=[inner, -0.5, - overlap]) {
				# cube (size=[outer-inner, 1 ,hGroove + overlap], center=false);
			}
		} else {
			translate(v=[inner, -0.5, hStock - hGroove - overlap]) {
				# cube (size=[outer-inner, 1 ,hGroove + overlap], center=false);
			}
		}
	}
}

module title(text, onSecondSide)
{
	if (onSecondSide>0)
		writecylinder(text, [0,0,-hInset], radius=20, height=hStock-hInset, h=3, t=hInset, face="bottom");
	else
		writecylinder(text, [0,0,0], radius=20, height=hStock-hInset, h=3, t=hInset, face="top");
}



// Do the work
createDisc();

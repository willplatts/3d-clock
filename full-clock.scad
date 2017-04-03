//definitions
outer_radius = 95;
outer_band_thickness = 8;

inner_radius = 5;
hole_radius = 1;

spoke_start = 0;
spoke_step = 30;
spoke_end = 330;

spoke_length = 95;
spoke_width = 3;

number_text = ["12","1","2","3","4",
        "5","6","7","8",
        "9","10","11"];
        
face = true;
digits = true;

//outer band
module outer_band() {
    difference() {
        circle(outer_radius);
        circle(outer_radius-outer_band_thickness);
    };
}

module outer_band_holes() {
    for (angle = [0:7.5:352.5]) {
        if (angle % 30 != 0)
        {
            rotate(a = [0,0,angle]) {
                translate([0, spoke_length-(outer_band_thickness/2), 0]) {
                    circle(2);
                }
            }
        }
    }
}

//inner circle
module inner_circle() {
    circle(inner_radius);
}

//spokes
module spokes() {
    for (angle = [spoke_start:spoke_step:spoke_end]) {
        rotate(a = [0, 0, angle]) {
            translate([0, -spoke_width/2, 0]) {
                square([spoke_length-outer_band_thickness+1,
                    spoke_width], false);
            }
        }
    }
}


module clock_digits() {
    for (angle = [11:-1:0]) {
        rotate(a = [0, 0, (angle*30)]) {
            translate([0, spoke_length, 0]) {
                text(number_text[angle], 
                    size = 18, 
                    halign="center", 
                    valign="center");
            }
        }
    }
}


if (face) {
    //Main clock level
    linear_extrude(height = 3) {
        difference () {
            union() {
                difference() {
                    outer_band();
                    outer_band_holes();
                }
                inner_circle();
                spokes();
            }
            circle(hole_radius);
        }
    }
}

if (digits) {
    #translate([0,0,3]) {
        linear_extrude(height = 3) {
            clock_digits();
        }
    }
}
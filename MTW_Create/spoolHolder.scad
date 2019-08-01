$fn = 90;

x = 74;
y = 120;
z = 25;

spoolDiameter = 100;
spoolWidth = 62;

mainCutZ = spoolDiameter;
mainCutWidth = 45;

barCutSpacing = 27.3;
barCutWidth = 5;
barCutDepth = 8;
barCutRadius = 0.5 * barCutWidth;

spoolCutX = (0.5 * x) - 7;
spoolCutWidth = 7.2;

bearingHoleAngle = 22;
bearingHoleOffset = 7;
bearingHoleRadius = 2.6;

chamferRadius = 15;

difference(){
    cube([x, y, z], center = true);
    mainCut();
    barCuts();
    spoolCuts();
    bearingHoles();
    chamfers();
}

//spool();

module spool()
{
    translate([0, 0, mainCutZ]){
        rotate([0, 90, 0]){
            cylinder(h = spoolWidth, r = spoolDiameter - 5, center = true);
        }
    }
}

module mainCut()
{
    translate([0, 0, mainCutZ]){
        rotate([0, 90, 0]){
            cylinder(h = mainCutWidth, r = 16 + spoolDiameter, center = true);
        }
    }
}

module barCuts()
{
    for(b = [0, barCutSpacing, -barCutSpacing, 2 * barCutSpacing, -2 * barCutSpacing]){
        translate([0, b, barCutDepth - z]){
            union(){
                cube([0.1 + x, barCutWidth, z], center = true);
                translate([0, 0, 0.5 * z]){
                    rotate([0, 90, 0]){
                        cylinder(h = 0.1 + x, r = barCutRadius, center = true);
                    }
                }
            }
        }
    }
}

module spoolCuts()
{
    for(sX = [spoolCutX, -spoolCutX]){
        translate([sX, 0, mainCutZ]){
            rotate([0, 90, 0]){
                cylinder(h = spoolCutWidth, r = 20 + spoolDiameter, center = true);
            }
        }
    }
    spool();
}

module bearingHoles(){
    translate([0, 0, mainCutZ]){
        for(bA = [bearingHoleAngle, -bearingHoleAngle]){
            rotate([bA, 0, 0]){
                translate([0, 0, -spoolDiameter - bearingHoleOffset]){
                    rotate([0, 90, 0]){
                        cylinder(h = 0.1 + x, r = bearingHoleRadius, center = true);
                    }
                }
            }
        }
    }
}

module chamfers(){
    for(chamferY = [0.5 * y, -0.5 * y]){
        translate([0, chamferY, 0.5 * z]){
            rotate([0, 90, 0]){
                difference(){
                    cylinder(h = 0.1 + x, r = chamferRadius, center = true);
                    for(cY = [chamferRadius, -chamferRadius]){
                        for(cX = [chamferRadius, -chamferRadius]){
                            translate([cX, cY, 0]){
                                cylinder(h = 0.1 + x, r = chamferRadius, center = true);
                            }
                        }
                    }
                }
            }
        }
    }
}
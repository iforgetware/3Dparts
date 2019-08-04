$fn = 90;

x = 74;
y = 120;
z = 25;

spoolRadius = 100;
spoolCenterZ = spoolRadius - 7;
spoolWidth = 62;
spoolEdgeThickness = 4;
spoolEdgeOffset = 0.5 * (spoolWidth - spoolEdgeThickness); 

spoolHubOR = 45;
spoolHubIR = 26;

filamentWidth = spoolWidth - (2 * spoolEdgeThickness);
filamentOR = spoolRadius - 5;
filamentIR = spoolHubOR;

mainCutWidth = 45;

floorThickness = 3;

barCutSpacing = 27.3;
barCutWidth = 5;
barCutDepth = 3;
barCutRadius = 0.5 * barCutWidth;

wireCutY = barCutSpacing + (0.5 * y);

spoolCutX = (0.5 * x) - 7;
spoolCutWidth = 7.2;

bearingRadius = 7;
bearingCutRadius = bearingRadius + 1;

bearingHoleAngle = 22;
bearingHoleRadius = 2.6;

chamferRadius = 15;

difference(){
    cube([x, y, z], center = true);
    mainCut();
    wireCuts();
    barCuts();
    filament();
    spoolCuts();
    bearingCuts();
    chamfers();
}

//spool();
//filament();

module spool()
{
    translate([0, 0, spoolCenterZ]){
        rotate([0, 90, 0]){
            union(){
                cylinder(h = spoolWidth, r = spoolHubOR, center = true);
                for(sO = [spoolEdgeOffset, -spoolEdgeOffset]){
                    translate([0, 0, sO]){
                        cylinder(h = spoolEdgeThickness, r = spoolRadius, center = true);
                    }
                }
            }
        }
    }
}

module filament()
{
    translate([0, 0, spoolCenterZ]){
        rotate([0, 90, 0]){
            difference(){
                cylinder(h = filamentWidth, r = filamentOR, center = true);
                cylinder(h = filamentWidth, r = filamentIR, center = true);
            }
        }
    }
}

module mainCut()
{
    translate([0, 0, floorThickness]){
        cube([mainCutWidth, 0.1 + y, z], center = true);
    }
}

module wireCuts()
{
    for(wY = [wireCutY, -wireCutY]){
        translate([0, wY, 0]){
            cube([mainCutWidth, 0.1 + y, z], center = true);
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
        translate([sX, 0, spoolCenterZ]){
            rotate([0, 90, 0]){
                cylinder(h = spoolCutWidth, r = bearingRadius + spoolRadius, center = true);
            }
        }
    }
}

module bearingCuts()
{
    translate([0, 0, spoolCenterZ]){
        for(bA = [bearingHoleAngle, -bearingHoleAngle]){
            rotate([bA, 0, 0]){
                translate([0, 0, -spoolRadius - bearingRadius]){
                    rotate([0, 90, 0]){
                        union(){
                            cylinder(h = 0.1 + x, r = bearingHoleRadius, center = true);
                            for(bO = [spoolCutX, -spoolCutX]){
                                translate([0, 0, bO]){
                                    cylinder(h = spoolCutWidth, r = bearingCutRadius, center = true);
                                }
                            }
                        }
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

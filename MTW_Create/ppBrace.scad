$fn = 90;

xS = [9, -9];
thickness = 3;
bodyRadius = 4.5;
holeRadius = 1.8;

difference(){
    hull(){
        for(bX = xS){
            translate([bX, 0, 0]){
                cylinder(h = thickness, r = bodyRadius, center = true);
            }
        }
    }
    for(hX = xS){
        translate([hX, 0, 0]){
            cylinder(h = 0.1 + thickness, r = holeRadius, center = true);
        }
    }
}

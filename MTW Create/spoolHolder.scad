x = 24;
y = 60;
z = 20;

frameCutOffset = 16;
frameCutWidth = 17;
frameCutDepth = 14;

barCutOffset = -22;
barCutWidth = 6;
barCutDepth = 11;


footY = -11;
footDepth = 5;
footRadius = 8;

difference(){
    cube([x, y, z], center = true);
    frameCut();
    barCut();
    footDimple();
}


module frameCut()
{
    translate([x - frameCutDepth, frameCutOffset, 0]){
        cube([x, frameCutWidth, 0.1 + z], center = true);
    }
}

module barCut()
{
    translate([x - barCutDepth, barCutOffset, 0]){
        cube([x, barCutWidth, 0.1 + z], center = true);
    }
}

module footDimple()
{
    translate([footDepth - x, footY, 0]){
        rotate([0, 90, 0]){
            cylinder(h = x, r = footRadius, center = true);
        }
    }
}

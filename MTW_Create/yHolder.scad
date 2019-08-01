x = 80;
y = 60;
z = 15;

difference(){
    cube([x, y, z], center = true);
    mainCut();
    frameCut();
    tableCut();
}

module mainCut()
{
    translate([25, 35, 0]){
        cube([x, y, 0.1+ z], center = true);
    }
}

module frameCut()
{
    translate([-(0.5 * x) - 18.5, 40, 0]){
        cube([x, y, 0.1+ z], center = true);
    }
}

module tableCut()
{
    translate([20, 18 - (0.5 * y), 0]){
        cube([x, 16, 0.1+ z], center = true);
    }
}


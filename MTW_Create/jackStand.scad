wall = 8; // wall thickness is actually half of this

footX = 60;
footY = footX;

neckZ = 55;
neckX = 20;
neckY = 20;

topZ = 95;
topX = 30;
topY = neckY;

hollowBottomX = footX - wall;
hollowBottomY = hollowBottomX;

hollowTopZ = neckZ;
hollowTopX = neckX - wall;
hollowTopY = neckY - wall;
hollowNeckHeight = 2 * ( topZ - neckZ);

channelZ = 87;
channelX = 21;
channelY = topY + 1;

difference(){
    body();
    hollowOut();
    channel();
    sideCutouts();
}

module body(){
    union(){
        hull(){
            foot();
            neck();
        }
        hull(){
            neck();
            top();
        }
    }
}

module hollowOut(){
    union(){
        hull(){
            hollowBottom();
            hollowTop();
        }
        translate([0, 0, neckZ]){
            cube([hollowTopX, hollowTopY, hollowNeckHeight], center = true);
        }
    }
}

module foot(){
    cube([footX, footY, 0.1], center = true);
}

module neck(){
    translate([0, 0, neckZ]){
        cube([neckX, neckY, 0.1], center = true);
    }
}

module top(){
    translate([0, 0, topZ]){
      cube([topX, topY, 0.1], center = true);
    }
}

module hollowBottom(){
    translate([0, 0, -0.1]){
      cube([hollowBottomX, hollowBottomY, 0.1], center = true);
    }
}

module hollowTop(){
    translate([0, 0, hollowTopZ]){
      cube([hollowTopX, hollowTopY, 0.1], center = true);
    }
}

module channel(){
    translate([0, 0, channelZ + 5]){
      cube([channelX, channelY, 10], center = true);
    }
}

module sideCutouts(){
    cO = 6;
    for(rA = [0, 90]){
        rotate([0, 0, rA]){
            hull(){
                translate([0, 0, neckZ - cO - 2]){
                    rotate([90, 0, 0]){
                        cylinder(h = footX, r = cO, center = true);
                    }
                }
                for(cX = [footX - cO, cO - footX]){
                    translate([0.2 * cX, 0, 2 * cO]){
                        rotate([90, 0, 0]){
                            cylinder(h = footX, r = cO, center = true);
                        }
                    }
                }
            }
        }
    }
}

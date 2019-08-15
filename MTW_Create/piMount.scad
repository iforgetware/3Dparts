$fn = 90;

mpWidth = 155; // x
mpDepth = 135; // y
mpHeight = 4;  // z

mountHoleXs = [60 - (0.5 * mpWidth), 5 - (0.5 * mpWidth)];
mountHoleYs = [63.5, -63.5];

mwT = 4; // double thickness of walls for mounts
         // ie: mwT = 4 means 2mm thick walls
mountOffset = -0.5 * mpHeight;

portX = 32.5 - (0.5 * mpWidth);
rj45X = portX;
rj45Y = 40;
rj45Width = 40;
rj45Depth = 30;
rj45CutoutWidth = 16;
rj45CutoutHeight = 14;
rj45CutoutOffset = 1.5;
rj45ScrewXs = [13.5, -13.5];
rj45ScrewRadius = 1.8;

usbX = portX;
usbY = 3;
usbWidth = 40;
usbDepth = 25;
usbCutoutWidth = 14;
usbCutoutHeight = 8.5;
usbScrewXs = [13.5, -13.5];
usbScrewRadius = 1.8;

ppX = portX;
ppY = -38;
ppWidth = 35;
ppDepth = 35;
ppCutoutWidth = 27;
ppCutoutHeight = 7;
ppScrewZs = [9, -9];
ppScrewRadius = 1.3;

piPXs = [(0.5 * mpWidth) - 7, (0.5 * mpWidth) - 56];
piPYs = [(0.5 * mpDepth) - 7, (0.5 * mpDepth) - 65];
piPRadius1 = 6;
piPRadius2 = 2.8;
piPHoleRadius = 1.3;
piPHeight = 22;
piPZ = 0.5 * (mpHeight + piPHeight);

difference(){
    union(){
        difference(){
            mainPlane();
            mountHoles();
        }
        rj45Mount();
        usbMount();
        ppMount();
        piPosts();
    }
    topCut();
    cornerCut();
//    piCut();
}

module mainPlane()
{
    
    
    
    
    
    
    // make this a hull of round corners
    
    
    
    
    
    
    
    difference(){
        cube([mpWidth, mpDepth, mpHeight], center = true);
        rj45Frame();
        usbFrame();
        ppFrame();
    }
}    

module mountHoles()
{
    for(mX = mountHoleXs){
        for(mY = mountHoleYs){
            translate([mX, mY, 0]){
                cylinder(h = 0.1 + mpHeight, r = 1.7, center = true);
            }
        }
    }
}

module topCut()
{
    translate([0, 0, -(0.5 * mpHeight) - 50]){
        cube([mpWidth, mpDepth, 100], center = true);
    }
}

module cornerCut()
{
    translate([2 + (0.5 * mpWidth), 0, 0]){
        rotate([0, 0, -55]){
            translate([0.5 * mpWidth, 0, 0]){
                cube([mpWidth, 2 * mpDepth, 0.1 + mpHeight], center = true);
            }
        }
    }
}

module piCut()
{
    translate([(0.5 * mpWidth) - 12, 0, 0]){
        cube([mpWidth, mpDepth, 100], center = true);
    }
}

module rj45Frame()
{
    translate([rj45X, rj45Y, mountOffset]){
        rotate([45, 0, 0]){
            cube([rj45Width, rj45Depth, rj45Depth], center = true);
        }
    }
}

module rj45Mount()
{
    difference(){
        rj45Frame();
        translate([rj45X, rj45Y, mountOffset]){
            rotate([-45, 0, 0]){
                union(){
                    cube([rj45Width - mwT, rj45Depth - mwT, rj45Depth - mwT], center = true);
                    translate([0, 0, rj45CutoutOffset]){
                        cube([rj45CutoutWidth, 2 * rj45Depth, rj45CutoutHeight], center = true);
                    }
                }
                for(rSX = rj45ScrewXs){
                    translate([rSX, 0, 0]){
                        rotate([90, 0, 0]){
                            cylinder(h = 2 * rj45Depth, r = rj45ScrewRadius, center = true);
                        }
                    }
                }
            }
        }
    }
}

module usbFrame()
{
    translate([usbX, usbY, mountOffset]){
        rotate([45, 0, 0]){
            cube([usbWidth, usbDepth, usbDepth], center = true);
        }
    }
}

module usbMount()
{
    difference(){
        usbFrame();
            translate([usbX, usbY, mountOffset]){
            rotate([-45, 0, 0]){
                union(){
                    cube([usbWidth - mwT, usbDepth - mwT, usbDepth - mwT], center = true);
                    cube([usbCutoutWidth, 2 * usbDepth, usbCutoutHeight], center = true);
                }
                for(uSX = usbScrewXs){
                    translate([uSX, 0, 0]){
                        rotate([90, 0, 0]){
                            cylinder(h = 2 * usbDepth, r = usbScrewRadius, center = true);
                        }
                    }
                }
            }
        }
    }
}

module ppFrame()
{
    translate([ppX, ppY, mountOffset]){
        rotate([45, 0, 0]){
            cube([ppWidth, ppDepth, ppDepth], center = true);
        }
    }
}

module ppMount()
{
    difference(){
        ppFrame();
            translate([ppX, ppY, mountOffset]){
            rotate([-45, 0, 0]){
                union(){
                    cube([ppWidth - mwT, ppDepth - mwT, ppDepth - mwT], center = true);
                    cube([ppCutoutWidth, 2 * ppDepth, ppCutoutHeight], center = true);
                    translate([0, 0, -1]){
                        cube([ppCutoutWidth / 3, 2 * ppDepth, 2 + ppCutoutHeight], center = true);
                    }
                }
                for(pSZ = ppScrewZs){
                    translate([0, 0, pSZ]){
                        rotate([90, 0, 0]){
                            cylinder(h = 2 * ppDepth, r = ppScrewRadius, center = true);
                        }
                    }
                }
            }
        }
    }
}

module piPosts()
{
    for(piPX = piPXs){
        for(piPY = piPYs){
            translate([piPX, piPY, piPZ]){
                difference(){
                    cylinder(h = piPHeight, r1 = piPRadius1, r2 = piPRadius2, center = true);
                    cylinder(h = 0.1 + piPHeight, r = piPHoleRadius, center = true);
                }
            }
        }
    }
}
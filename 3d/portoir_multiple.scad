  include <./MCAD/boxes.scad>
X_MAIN = 80;
Y_MAIN = 40;

Z_MAIN = 20;

D_EPP = 11.5 ;

//cube([X_MAIN, Y_MAIN, Z_MAIN]);

//cylinder(h=60, r= 10);
difference(){
  %  translate([0, 0, Z_MAIN /2])
  roundedBox([X_MAIN, Y_MAIN, Z_MAIN], 3, true);
  for (i =[ -2, - 1, 0 ,  1]) for (j = [-1, 1]) {
      translate([10 + 20 * i, 10 * j, 2 ]) cylinder(h = 25, d = D_EPP);
        }
  }
  include <./MCAD/boxes.scad>
X_MAIN = 40;
Y_MAIN = 40;

Z_MAIN = 20;
Z_BAS_TENON = 3; 
D_EPP = 12;

SPACE = 0.8; // bethween 2 parts (friction free zone). 
EPS =  0.01; 


module mortaise(){
    linear_extrude(Z_MAIN-Z_BAS_TENON) 2d_mortaise();
} ;

module 2d_mortaise(delta){
    offset(SPACE) 2d_tenon(); 
    };

module 2d_tenon(){
    offset(1, $fn= 20) polygon(points = [[0.5,0], [0,2], [10, 2], [9.5,0]]);  
};

module tenon(){
        linear_extrude(Z_MAIN - Z_BAS_TENON) 2d_tenon();
}



DEL = -2;
module body(){
      //translate([0, 0, Z_MAIN /2])
    difference(){
    union(){
  roundedBox([X_MAIN, Y_MAIN, Z_MAIN], 3, true);
        difference(){
  translate([-5, 20, -(Z_MAIN/2 - Z_BAS_TENON)]) tenon();
  translate([7,20, -(Z_MAIN/2-Z_BAS_TENON)])
        rotate(90) chamfert();       
        }
        
        
//  %translate([-5, 20, -(Z_MAIN/2 - Z_BAS_TENON)])
        difference(){
  translate([20, 5, -(Z_MAIN/2 - Z_BAS_TENON)]) rotate(-90) tenon();
  translate([20,-7, -(Z_MAIN/2-Z_BAS_TENON)])
        chamfert(); 
        }
   }
   
   
    // placement des mortaises       
   translate([-5, -20 +2 +DEL, -(Z_MAIN/2 - Z_BAS_TENON)])
        mortaise();

   translate([-20, 5 , -(Z_MAIN/2 - Z_BAS_TENON)])
        rotate(-90) mortaise(); 

   };
};

module chamfert(){
   rotate([0,25,0]) cube([10, 20,10]);
}
module box(){
    difference(){
    
  body();
  // holes for tubes
  for (i =[  - 1, 0 ]) for (j = [-1, 1]) {
      translate([10 + 20 * i, 10 * j, 2 ]) cylinder(h = 25, d = D_EPP, $fn= 30);
        };
  }
};


box();

//color("yellow",  0.9) translate([40, 0])box();
//2d_tenon();
//2d_mortaise();
  
  



  include <./MCAD/boxes.scad>
X_MAIN = 40;
Y_MAIN = 40;

Z_MAIN = 34;
Z_BAS_TENON = 3;
D_EPP_REEL = 10.7;
COMPENSATION_IMPRIMANTE = 0.8 ;
D_EPP = D_EPP_REEL + COMPENSATION_IMPRIMANTE + 0.3 ; // Diamètre pour Eppendorf.

DIA_TROU_BAS_REEL = 3 ;
DIA_TROU_BAS = DIA_TROU_BAS_REEL+ COMPENSATION_IMPRIMANTE ; 


SPACE = 0.5; // bethween 2 parts (friction free zone).
EPS =  0.01; 

module mortaise(){
    linear_extrude(Z_MAIN - Z_BAS_TENON +EPS) 2d_mortaise();
};

module 2d_mortaise(){
    offset(SPACE) 2d_tenon(); 
};

module 2d_tenon(){
    offset(0.5, $fn= 30) polygon(points = [[0.5 +0.2, 0], [0, 2], [10, 2], [9.5-0.2, 0]]);  
};

module tenon(){
        linear_extrude(Z_MAIN - Z_BAS_TENON) 2d_tenon();
};

DEL = -2;


module tenon_biseau(){
                        // tenon 2 avec un biseau en bas
                    union(){
                        difference(){
                          translate([20, 5, -(Z_MAIN/2 - Z_BAS_TENON)]) rotate(-90) 
                               tenon();     
                          translate([20,-7, -(Z_MAIN/2-Z_BAS_TENON)])
                               chamfert();  // biseau
                        };
                    };
                };     

module body(){
      //translate([0, 0, Z_MAIN /2])
    translate([0, 0, Z_MAIN/2])
    difference(){
        // union ci-dessoud contient : boîte + 2 tenons
        union(){
                    roundedBox([X_MAIN, Y_MAIN, Z_MAIN], 3, $fn= 16, true);
                    // tenon 1 avec un biseau en bas
                       rotate(90) tenon_biseau();
                    
                    // tenon 2 avec un biseau en bas
                       tenon_biseau();
                       
        } // end of union
               
        // placement des 2 mortaises       
       translate([-5, -20 +2 +DEL, -(Z_MAIN/2 - Z_BAS_TENON)])
            mortaise();
       translate([-20 , 5 , -(Z_MAIN/2 - Z_BAS_TENON)])
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
          translate([10 + 20 * i, 10 * j, 2 ]) 
                cylinder(h = Z_MAIN, d = D_EPP, $fn= 60);
          translate([10 + 20 * i, 10 * j, -2 ]) 
                cylinder(h= 10, d = DIA_TROU_BAS, $fn = 30);
      };  
    };
};

module make_a_slice(height=1.5) {
    intersection(){
        children();
        translate([-30, -30, +15]) cube([100, 100, height]);
    }
} ;

// Faire une slice
// make_a_slice() box();



// Faire une découpe pour connexion
//intersection(){
//    
//    make_a_slice(2) {
//        box(); 
//        color("yellow",  0.9) translate([50, 0]) box();
//        };
//    translate([10,-10])cube([30,25,40]); 
//    }



// faire un slice de 2 emboitements : 
//make_a_slice() {
//    box(); 
//    color("yellow",  0.9) translate([40, 0]) box();
//    };
    
    
//color("yellow",  0.9) translate([40, 0]) make_a_slice();

// boîte
box();

// %color("yellow",  0.9) translate([40, 0])box();
//2d_tenon();
//2d_mortaise();
  
//  tenon_biseau();






Y = 82; 
Z = 2 ;
EPS = 0.01 ; 
Z_LETTER = 0.6 ; 


Y_SPACE = 16; 
$fn = 60 ; 
X_BY  = 2 ; 

D_INIT = 11 ; 
INC = 0.5 ; // Incrémentation du diamètre. 
NB_TROUS = 10;


MIN_D = D_INIT; 
MAX_D = MIN_D + INC * (NB_TROUS - 1) ;  


echo ("MAX_D"); 
echo (MAX_D);
X = MAX_D  + (MAX_D - INC)+4;
echo(X); 
X_SPACE= MAX_D+1.5 ; 

difference(){
cube ([X, Y, Z]);
    for ( i  = [ 0:NB_TROUS - 1 ]) {
       translate ([ (D_INIT / 2 + 3)+(i % X_BY) *X_SPACE , 8 + Y_SPACE * floor(i/X_BY), -0.1])        
        cylinder(h=5, d = (D_INIT +i*INC));
    }

}

translate ([1, 2, Z- EPS])
linear_extrude(Z_LETTER) text(str(D_INIT), size  = 2); 

translate ([1 + D_INIT +4, 2, Z- EPS])
linear_extrude(Z_LETTER) text(str(INC), size  = 2); 

translate ([1 + D_INIT , Y_SPACE, Z- EPS])
linear_extrude(Z_LETTER) text(str("$fn", str($fn)) , size  = 2); 

AA = str("$fn", str($fn));
echo (AA);


/* [Box dimensions] */
  Length        = 280;       
  Width         = 400;                     
  TopHeight        = 10;  
  BottomHeight     = 21;  
  SlopeHeight      = 20;
  BackShelf     =130;
  Thick         = 3;//[2:5]  


  
/* [Box options] */
  PCBFeet       = 1;// [0:No, 1:Yes]
  Vent          = 1;// [0:No, 1:Yes]
  Vent_width    = 1.5;   



  Filet         = 9;//[0.1:12] 
  Resolution    = 50;//[1:100] 
  m             = 0.9;
  
/* [PCB_Feet--the_board_will_not_be_exported) ] */
PCBPosX         = 0;
PCBPosY         = 0;
PCBLength       = 142;
PCBWidth        = 360;
FootHeight      = 5;
FootDia         = 10;
FootHole        = 5;  /* 4.4 for melt in 5 for glue in */
  

/* [STL element to export] */
//Top shell
  TShell        = 0;// [0:No, 1:Yes]
//Bottom shell
  BShell        = 1;// [0:No, 1:Yes]
// Show PCBs
  ShowPCB       = 1;// [0:No, 1:Yes]
  
/* [Hidden] */
Couleur1        = "Orange";       
Couleur2        = "OrangeRed";    
Dec_Thick       = Vent ? Thick*2 : Thick; 
Dec_size        = Vent ? Thick*2 : 0.8;

PCBL=PCBLength;
PCBW=PCBWidth;



   
module SlopeRoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;     
                         
                        translate([Filet,-Filet/2,Filet])
                        {  
                    minkowski ()
                    {  
              
                    translate([0,($b/2)+1,TopHeight])
                       rotate(a=[0,-90,90])
                          linear_extrude(height =(($b/2)-Filet/2)+1, center = false, convexity = 0, twist = 0)
                              polygon(points=[[0,0],[(SlopeHeight+TopHeight)*-1,0],[(SlopeHeight+TopHeight)*-1,BackShelf*-1],  [TopHeight*-1,($a-Filet*2)*-1],[0,($a-Filet*2)*-1]], paths=[[3,2,1,0]]);                      
                        
                     rotate([270,0,0]){    
                        cylinder(r=Filet,h=Width/2+1, center = false);
                            } 
                        }
                    }
                }// End of SlopeRoundBox Module                


module RoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;            
                    translate([0,Filet,Filet]){  
                    minkowski (){                                              
                        cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
                        rotate([0,90,0]){   
                           translate([0,0,Filet]){  
                        cylinder(r=Filet,h=Length/2-(2*Filet), center = false);}
                            } 
                        rotate([270,0,0]){    
                        cylinder(r=Filet,h=.1, center = false);
                            } 
                        }
                    }
                }// End of RoundBox Module

      


module TopShell(){
    Thick = Thick*2;  
    difference(){    
        difference(){
            union(){    
                     difference() {
                      
                        difference(){
                            union() {                                
                                        KeyboardCutoutReinforcement();

                            difference(){
                                SlopeRoundBox();
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        SlopeRoundBox($a=Length-Thick*2, $b=Width-Thick*2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }
                                    }
                               translate([-Thick,-Thick,TopHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                      }
                                }                                          
                // These are the tabs that attach the top to the bottom
                difference(){
                    union(){
                        
                        // four sides
                        translate([3*Thick +5,Thick,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                       translate([Length-((3*Thick)+5),Thick,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }

                    translate([3*Thick +5,Width-Thick/2-2.4,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                       translate([Length-((3*Thick)+5),Width-Thick/2-2.4,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }

                        // front and back
                       translate([Length-Thick-0.5,(Width/2)-Thick/2-2.4,TopHeight]){
                            rotate([90,0,90]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                        }




                            
                    } 
                    
                    
            }

       }


///Put Difference Keyboard Cutout Here

            union(){ //sides holes
                $fn=50;
                translate([3*Thick+5,20,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),20,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([3*Thick+5,Width+5,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),Width+5,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                
                
                translate([Thick/2,(Width/2)-Thick/2-2.4,TopHeight+4]){
                    rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-Thick-0.5,(Width/2)-Thick/2-2.4,TopHeight+4]){
                    rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
                
            }

         // Serial Opening    
            translate([-1,(Thick)+245,Thick]){
              cube([20,20,BottomHeight-9]);
            }   
            
        // Joystick Opening    
            translate([96,20,Thick]){    
              cube([20,Width+2,BottomHeight-9]);
            }
            translate([137,20,Thick]){    
              cube([20,Width+2,BottomHeight-9]);
            }

         // Power Switch Opening    
            translate([45,Thick-10,Thick-13]){
              cube([20,13,13]);
            }   


         // Reset Switch Opening    
            translate([85,(Thick),Thick-7]){
             rotate([90,0,0])
                    cylinder(d=7,20);
            }   


        // Power Jack Opening    
            translate([-1,(Thick)+355,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=11,20);
            }
                
       
        // Audio and Video RCA Jack Openings    
            translate([-1,(Thick)+305,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=7,20);
            }   
             translate([-1,(Thick)+320,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=7,20);
            }   
             translate([-1,(Thick)+335,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=7,20);
            }   



        KeyboardCutout();

        }//fin de difference holes
        KeyboardFeet();
        
   // Reset Switch Opening    
          //  translate([85,(Thick),Thick-7]){
           //  rotate([90,0,0])
             //       cylinder(d=7,20);
            //}   
        
        

}





module BottomShell(){
    Thick = Thick*2;  
    translate([0,2,0]){
    
    difference(){    
        difference(){
            //Main Box
            union(){    
                     difference() {
                      
                        difference(){
                            union() {
                            difference(){
                                RoundBox($a=Length, $b=Width-2, $c=TopHeight+BottomHeight);
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        RoundBox($a=Length-Thick, $b=Width-Thick-2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }

                                    }
                               translate([-Thick,-Thick,BottomHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                      }
                                }                                          


              
            }

       
            // vent holes
            union(){           
            for(i=[0:Thick:Length/4]){
                    translate([10+i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/2]);
                    }
                    translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/2]);
                    }
               
                  }
                }
                
        
            // Joystick Opening    
            translate([96,-2,Thick]){    
              cube([20,Dec_Thick+2,BottomHeight-5]);
            }
            translate([137,-2,Thick]){    
              cube([20,Dec_Thick+2,BottomHeight-5]);
            }

                

        
            
            // Glamour Line        
            translate([Length-1,0,BottomHeight-1.25]){
             cube([20,Width,20]);
                }               
            translate([0,0,BottomHeight-1.25]){
             cube([1,Width,20]);
                }
             translate([0,0,BottomHeight-1.25]){    
              cube([Length,1,5]);
            }  
             translate([0,Width-3,BottomHeight-1.25]){    
              cube([Length,20,5]);
            }  
           
                
            }//fin difference decoration


            union(){ //sides holes
                $fn=50;
                translate([3*Thick+5,20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([3*Thick+5,Width+5,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),Width+5,BottomHeight-4]){
                   rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                
               // front and back
               translate([Length-Thick-0.5,(Width/2)-Thick/2+2.4,BottomHeight-4]){
                 rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
            

            }
        }
        }
}



module thinFoot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=(FootDia),FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia)/1.75,0,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole/2,FootHeight+1, $fn=100);
               }          
}

module foot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=FootDia+Filet,FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia+Filet*2)/2,Filet,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole,FootHeight+1, $fn=100);
               }          
}

module KeyboardCutout()
{
      color("OrangeRed"){
        translate([BackShelf+40,Width-20,-16])
          {
           rotate(a=[8,0,270])
           { 
               linear_extrude(height =15, center = false, convexity = 0, twist = 0)              
                                polygon(points=[[20,2],[251,2],[251,24],[242,24],[242,40],[289,40],[289,81],[291,81],[291,59],[310,59],[310,40],
                                                [332,40],[332,59],[351,59],[351,81],[336,81],[195,81],[195,100],
                                                [73,100],[73,81],[1,81],[1,40],[28,40],[28,24],[20,24],[20,2]]
               , paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]]);                             
           }
                            

               //LED OPENING
                 rotate(a=[8,0,270])
                            linear_extrude(height =12, center = false, convexity = 0, twist = 0)              
                                polygon(points=[[7,-50],[17.1,-50],[17.1,-52.1],[7,-52.1]], paths=[[0,1,2,3]]);  
          }              
        }
    }

module KeyboardCutoutReinforcement()
{
    
      color("Green")
        translate([BackShelf+40,Width-20,-14])
          {
                       rotate(a=[8,0,270])
           { 
               
               linear_extrude(height =5, center = false, convexity = 0, twist = 0)  
                polygon(points=[[18,0],[253,0],[253,26],[244,26],[244,38],[290,38],[290,83],[290,83],[290,57],[308,57],[308,38],
                                                [334,38],[334,57],[353,57],[353,83],[336,83],[197,83],[197,102],
                                                [71,102],[71,83],[-1,83],[-1,38],[26,38],[26,26],[18,26],[18,2]]
               , paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]]);  
       }              
     }
    }


module KeyboardFeet()
{
     color("OrangeRed"){         
        translate([BackShelf+40,Width-20,-15])
          {
                       rotate(a=[8,0,270])
           { 
               // top row
               translate([.8,-18.428,Thick/2]){foot(FootDia,FootHole,FootHeight+6);}
               translate([135.8,-18.428,Thick/2]){foot(FootDia,FootHole,FootHeight+6);}
               
               translate([211.7,-10.128]){foot(FootDia,FootHole,FootHeight+8  );}
               
               translate([344.5,3.8]){foot(FootDia,FootHole,FootHeight+8  );}
               
               //bottom row
               translate([344.3,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               translate([270.5,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               translate([.8,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               translate([203,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               
               
               
               }
                            }              
        }
    }

module BottomFeet(){     

//top 
    translate([31,340,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
       
    translate([10,228,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
    
    translate([11.4,260.3,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
    translate([11.4,326,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);

    translate([10,17,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);

// middle
        translate([127,340,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([106.5,190.5,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([127,17,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);


//bottom       
        translate([206,340,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([206,17,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);


// Power Supply
        translate([235,166,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+3.4);
        translate([235,20,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+3.4);
}


module MainPCB()
{
rotate([0,0,90])
    translate([-17,24,2])
        color("Green",0.30)    
            import("main_pcb.stl");
}


module KeyboardPCB()
{
rotate([80.55,0,270])
    translate([-194,69,-259])
        color("Green",0.30)    
         import("keyboard_pcb.stl");   
}


module PowerSupplyPCB()
{
rotate([90,90,0])
    translate([-13,218,-370])
        color("Green",0.30)    
         cube([18,35,154]); 
}


module UnicornPCB()
{
rotate([90,90,0])
    translate([1,208,-190])
        color("Green",0.30)    
         cube([2,60,100]); 
}


///////////////////////////////////// - Main - ///////////////////////////////////////



if(BShell==1)
{
    color(Couleur1){ 
        BottomShell();
    }
    if (PCBFeet==1)
    // Feet
    translate([PCBPosX,PCBPosY,0]){ 
    BottomFeet();
    }
}

if(ShowPCB==1)
{
    if(BShell==1)
    {
        MainPCB();
        PowerSupplyPCB();
        UnicornPCB();
    }
    if(TShell==1)
        KeyboardPCB();
}
if(TShell==1)
{
    color( Couleur1,1){
        translate([0,Width,TopHeight+BottomHeight+0.2]){
            rotate([0,180,180]){
                TopShell();
            }
        }
    }
 
}


